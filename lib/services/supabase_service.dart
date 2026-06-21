import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/plant_analysis.dart';

class SupabaseService {
  static SupabaseClient get _db => Supabase.instance.client;

  bool get isSignedIn => _db.auth.currentUser != null;

  // Saves analysis to cloud. No-op if not signed in — activates automatically in Task 2.
  Future<void> saveAnalysis(PlantAnalysis analysis, String language) async {
    final user = _db.auth.currentUser;
    if (user == null) return;

    await _db.from('analysis_history').upsert({
      'id': analysis.id,
      'user_id': user.id,
      'plant_name': analysis.plantName,
      'health_status': analysis.healthStatus,
      'health_description': analysis.healthDescription,
      'problems': analysis.problems,
      'recommendations': analysis.recommendations,
      'care_tips': analysis.careTips,
      'is_toxic': analysis.isToxic,
      'toxic_to': analysis.toxicTo,
      'toxicity_details': analysis.toxicityDetails,
      'watering_interval_days': analysis.wateringIntervalDays,
      'language': language,
      'created_at': analysis.date.toIso8601String(),
    });
  }

  // Deletes all cloud data for the current user.
  Future<void> deleteAllUserData() async {
    final user = _db.auth.currentUser;
    if (user == null) return;

    await _db.from('analysis_history').delete().eq('user_id', user.id);
    await _db.from('profiles').delete().eq('id', user.id);
    await _db.auth.signOut();
  }
}
