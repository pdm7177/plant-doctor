import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class OpenAIService {
  static const String _url = 'https://api.openai.com/v1/chat/completions';

  static String buildPrompt(String language) {
    return '''You are an expert botanist and houseplant care specialist. Carefully examine the photo and respond ONLY in valid JSON format with no extra text before or after. Your entire response must be in $language.

Rules for identifying the plant:
- Give the exact name: common name in $language + Latin name in parentheses
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
    "watering": "[specific frequency, volume, method — in $language, no label prefix]",
    "light": "[specific location, hours of light, sun protection — in $language, no label prefix]",
    "temperature": "[range day and night, draft tolerance — in $language, no label prefix]",
    "fertilizer": "[what, how often, which season, dosage — in $language, no label prefix]",
    "additional": "[repotting, pruning, humidity or other important points — in $language, no label prefix]"
  },
  "care_tips": [
    "Care tip specific to this species — what is especially important to know"
  ],
  "toxicity": {
    "is_toxic": true or false,
    "toxic_to": ["cats", "dogs", "children"],  // use these exact English codes
    "details": "Brief explanation: which parts are toxic and what is the real risk"
  },
  "watering_interval_days": 7
}

If the plant is healthy — leave problems as empty array [], but in care_tips give 3-4 useful tips for optimal care of this specific plant.
If there are problems — fill problems with specific causes, and make recommendations as practical as possible for fixing the situation.
Always fill ALL recommendation fields in the recommendations object (watering, light, temperature, fertilizer, additional). Each value is plain text in $language with no label prefix.
toxicity field: always fill it — if not toxic, set is_toxic = false and toxic_to = [].
watering_interval_days: integer number of days between waterings, e.g. 7 means once a week.''';
  }

  Future<Map<String, dynamic>> analyzePlant(
      File imageFile, String apiKey, String language) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http
        .post(
          Uri.parse(_url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: jsonEncode({
            'model': 'gpt-4o',
            'max_tokens': 2000,
            'messages': [
              {
                'role': 'user',
                'content': [
                  {'type': 'text', 'text': buildPrompt(language)},
                  {
                    'type': 'image_url',
                    'image_url': {
                      'url': 'data:image/jpeg;base64,$base64Image',
                    },
                  },
                ],
              },
            ],
          }),
        )
        .timeout(const Duration(seconds: 60));

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body) as Map<String, dynamic>;
      final message =
          (error['error'] as Map?)?['message'] ?? 'API error ${response.statusCode}';
      throw Exception(message);
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final content =
        (data['choices'] as List).first['message']['content'] as String;

    final jsonMatch = RegExp(r'\{[\s\S]*\}').firstMatch(content);
    if (jsonMatch == null) throw Exception('Could not parse AI response');

    return jsonDecode(jsonMatch.group(0)!) as Map<String, dynamic>;
  }

  Future<String> chat({
    required String apiKey,
    required String plantContext,
    required List<Map<String, String>> messages,
    required String language,
  }) async {
    final systemPrompt =
        'You are a helpful plant care assistant. The user has already received this plant analysis: $plantContext. Answer follow-up questions about this plant in $language. Be concise and practical.';

    final response = await http
        .post(
          Uri.parse(_url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: jsonEncode({
            'model': 'gpt-4o',
            'max_tokens': 800,
            'messages': [
              {'role': 'system', 'content': systemPrompt},
              ...messages.map((m) => {'role': m['role']!, 'content': m['content']!}),
            ],
          }),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body) as Map<String, dynamic>;
      final message =
          (error['error'] as Map?)?['message'] ?? 'API error ${response.statusCode}';
      throw Exception(message);
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['choices'] as List).first['message']['content'] as String;
  }
}
