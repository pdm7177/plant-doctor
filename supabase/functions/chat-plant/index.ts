import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // ── Auth (login is mandatory for chat) ────────────────────────────────
    const authHeader = req.headers.get('Authorization')
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      authHeader ? { global: { headers: { Authorization: authHeader } } } : {},
    )

    let userId: string | null = null
    if (authHeader) {
      const { data: { user } } = await supabase.auth.getUser()
      userId = user?.id ?? null
    }
    if (!userId) {
      return new Response(
        JSON.stringify({ error: 'unauthorized' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      )
    }

    const { plantContext, messages, language } = await req.json()
    if (!Array.isArray(messages) || messages.length === 0) {
      throw new Error('messages is required')
    }

    // ── Admin client (service role): profile read + counter update ────────
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
    )

    // ── Read tier + daily counter ─────────────────────────────────────────
    const { data: profile } = await supabaseAdmin
      .from('profiles')
      .select('subscription_tier, chat_count, chat_count_date')
      .eq('id', userId)
      .maybeSingle()

    const tier = (profile?.subscription_tier as string) ?? 'free'

    // ── Daily limit (calendar day, UTC; lazy reset) ───────────────────────
    const today = new Date().toISOString().slice(0, 10) // YYYY-MM-DD (UTC)
    const usedToday = profile?.chat_count_date === today
      ? (profile?.chat_count as number ?? 0)
      : 0
    const limit = tier === 'free' ? 15 : 80
    if (usedToday >= limit) {
      return new Response(
        JSON.stringify({ error: 'daily_chat_limit_reached', tier }),
        { status: 429, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      )
    }

    // ── Choose OpenAI key by tier (strict, no fallback) ───────────────────
    const keyByTier: Record<string, string | undefined> = {
      free: Deno.env.get('OPENAI_API_KEY_FREE'),
      monthly: Deno.env.get('OPENAI_API_KEY_MONTHLY'),
      yearly: Deno.env.get('OPENAI_API_KEY_YEARLY'),
    }
    const openaiKey = keyByTier[tier]
    if (!openaiKey) throw new Error(`OpenAI key not configured for tier "${tier}"`)

    // ── Call OpenAI (same shape as the old openai_service.dart chat()) ────
    const lang = language ?? 'Ukrainian'
    const systemPrompt =
      `You are a helpful plant care assistant. The user has already received this plant analysis: ${plantContext ?? ''}. Answer follow-up questions about this plant in ${lang}. Be concise and practical.`

    const openaiRes = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${openaiKey}`,
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        max_tokens: 800,
        messages: [
          { role: 'system', content: systemPrompt },
          ...messages.map((m: { role: string; content: string }) =>
            ({ role: m.role, content: m.content })),
        ],
      }),
    })

    if (!openaiRes.ok) {
      const err = await openaiRes.json()
      throw new Error(err.error?.message ?? `OpenAI error ${openaiRes.status}`)
    }

    const data = await openaiRes.json()
    const reply: string = data.choices[0].message.content

    // ── Increment daily counter (read-modify-write) ───────────────────────
    await supabaseAdmin
      .from('profiles')
      .update({ chat_count: usedToday + 1, chat_count_date: today })
      .eq('id', userId)

    return new Response(JSON.stringify({ reply }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  } catch (error) {
    return new Response(
      JSON.stringify({ error: (error as Error).message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    )
  }
})
