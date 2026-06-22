import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/plant_analysis.dart';

class StorageService {
  static const String _analysesKey = 'analyses';
  static const String _languageKey = 'app_language';
  static const int freeLimit = 5;

  Future<String> saveImage(File imageFile) async {
    final dir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final saved = await imageFile.copy('${dir.path}/$fileName');
    return saved.path;
  }

  Future<void> saveAnalysis(PlantAnalysis analysis) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_analysesKey) ?? [];
    list.insert(0, jsonEncode(analysis.toJson()));
    await prefs.setStringList(_analysesKey, list);
  }

  Future<List<PlantAnalysis>> loadAnalyses() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_analysesKey) ?? [];
    return list
        .map((s) => PlantAnalysis.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteAnalysis(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final analyses = await loadAnalyses();
    analyses.removeWhere((a) => a.id == id);
    await prefs.setStringList(
      _analysesKey,
      analyses.map((a) => jsonEncode(a.toJson())).toList(),
    );
  }

  // Language preference
  Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  Future<String> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'uk';
  }

  // Watering reminders
  static const String _remindersKey = 'watering_reminders';

  Future<List<Map<String, dynamic>>> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_remindersKey) ?? [];
    return list
        .map((s) => jsonDecode(s) as Map<String, dynamic>)
        .toList();
  }

  Future<void> saveReminder(Map<String, dynamic> reminder) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_remindersKey) ?? [];
    list.removeWhere((s) {
      final r = jsonDecode(s) as Map<String, dynamic>;
      return r['analysisId'] == reminder['analysisId'];
    });
    list.add(jsonEncode(reminder));
    await prefs.setStringList(_remindersKey, list);
  }

  Future<void> deleteReminder(String analysisId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_remindersKey) ?? [];
    list.removeWhere((s) {
      final r = jsonDecode(s) as Map<String, dynamic>;
      return r['analysisId'] == analysisId;
    });
    await prefs.setStringList(_remindersKey, list);
  }

  Future<void> clearAllData() async {
    final analyses = await loadAnalyses();
    for (final a in analyses) {
      final file = File(a.imagePath);
      if (await file.exists()) await file.delete();
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
