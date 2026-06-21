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
    // ── Auth (Task 2 activates this) ──────────────────────────────────────
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
    // ─────────────────────────────────────────────────────────────────────

    const { imageBase64, language } = await req.json()
    if (!imageBase64) throw new Error('imageBase64 is required')

    const openaiKey = Deno.env.get('OPENAI_API_KEY')
    if (!openaiKey) throw new Error('OpenAI API key not configured on server')

    // ── Rate limit (Task 3 will add 30-day rolling check here) ───────────
    // ─────────────────────────────────────────────────────────────────────

    const lang = language ?? 'Ukrainian'
    const openaiRes = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${openaiKey}`,
      },
      body: JSON.stringify({
        model: 'gpt-4o',
        max_tokens: 2000,
        messages: [{
          role: 'user',
          content: [
            { type: 'text', text: buildPrompt(lang) },
            { type: 'image_url', image_url: { url: `data:image/jpeg;base64,${imageBase64}` } },
          ],
        }],
      }),
    })

    if (!openaiRes.ok) {
      const err = await openaiRes.json()
      throw new Error(err.error?.message ?? `OpenAI error ${openaiRes.status}`)
    }

    const data = await openaiRes.json()
    const content: string = data.choices[0].message.content
    const jsonMatch = content.match(/\{[\s\S]*\}/)
    if (!jsonMatch) throw new Error('Could not parse AI response')
    const result = JSON.parse(jsonMatch[0])

    // ── Save to DB if signed in ───────────────────────────────────────────
    if (userId) {
      const supabaseAdmin = createClient(
        Deno.env.get('SUPABASE_URL') ?? '',
        Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
      )
      await supabaseAdmin.from('analysis_history').insert({
        id: crypto.randomUUID(),
        user_id: userId,
        plant_name: result.plant_name ?? 'Unknown plant',
        health_status: result.health_status ?? 'needs_attention',
        health_description: result.health_description ?? '',
        problems: result.problems ?? [],
        recommendations: result.recommendations ?? {},
        care_tips: result.care_tips ?? [],
        is_toxic: result.toxicity?.is_toxic ?? false,
        toxic_to: result.toxicity?.toxic_to ?? [],
        toxicity_details: result.toxicity?.details ?? '',
        watering_interval_days: result.watering_interval_days ?? null,
        language: lang,
      })
    }
    // ─────────────────────────────────────────────────────────────────────

    return new Response(JSON.stringify(result), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  } catch (error) {
    return new Response(
      JSON.stringify({ error: (error as Error).message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    )
  }
})

function buildPrompt(language: string): string {
  return `You are an expert botanist and houseplant care specialist. Carefully examine the photo and respond ONLY in valid JSON format with no extra text before or after. Your entire response must be in ${language}.

Rules for identifying the plant:
- Give the exact name: common name in ${language} + Latin name in parentheses
- If you see a specific variety or cultivar — specify it
- If it is clearly a geranium, ficus, monstera, spathiphyllum, etc. — name it specifically, do not write "Unknown plant"

Response structure:
{
  "plant_name": "Common name (Latin name)",
  "health_status": "healthy" or "needs_attention",
  "health_description": "Detailed assessment of the plant's condition: describe leaf color and turgor, stem condition, root zone if visible, overall appearance. At least 3-4 sentences.",
  "problems": [
    "SYMPTOM: [what exactly is visible in the photo]. CAUSE: [why it happens — specific mechanism]. CONSEQUENCES: [what will happen if not addressed]"
  ],
  "recommendations": {
    "watering": "[specific frequency, volume, method — in ${language}, no label prefix]",
    "light": "[specific location, hours of light, sun protection — in ${language}, no label prefix]",
    "temperature": "[range day and night, draft tolerance — in ${language}, no label prefix]",
    "fertilizer": "[what, how often, which season, dosage — in ${language}, no label prefix]",
    "additional": "[repotting, pruning, humidity or other important points — in ${language}, no label prefix]"
  },
  "care_tips": [
    "Care tip specific to this species — what is especially important to know"
  ],
  "toxicity": {
    "is_toxic": true or false,
    "toxic_to": ["cats", "dogs", "children"],
    "details": "Brief explanation: which parts are toxic and what is the real risk"
  },
  "watering_interval_days": 7
}

If the plant is healthy — leave problems as empty array [], but in care_tips give 3-4 useful tips for optimal care of this specific plant.
If there are problems — fill problems with specific causes, and make recommendations as practical as possible for fixing the situation.
Always fill ALL recommendation fields in the recommendations object (watering, light, temperature, fertilizer, additional). Each value is plain text in ${language} with no label prefix.
toxicity field: always fill it — if not toxic, set is_toxic = false and toxic_to = [].
watering_interval_days: integer number of days between waterings, e.g. 7 means once a week.`
}
