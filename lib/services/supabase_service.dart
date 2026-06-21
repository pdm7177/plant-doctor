import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/plant_analysis.dart';

class SupabaseService {
  static SupabaseClient get _db => Supabase.instance.client;

  bool get isSignedIn => _db.auth.currentUser != null;
  User? get currentUser => _db.auth.currentUser;

  Future<void> signInWithGoogle() async {
    await _db.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'com.example.plant_doctor://login-callback/',
    );
  }

  Future<void> signOut() async {
    await _db.auth.signOut();
  }

  // Creates profile row on first sign-in. Safe to call multiple times.
  Future<void> ensureProfileExists() async {
    final user = _db.auth.currentUser;
    if (user == null) return;

    final existing = await _db
        .from('profiles')
        .select('id')
        .eq('id', user.id)
        .maybeSingle();
    if (existing != null) return;

    await _db.from('profiles').insert({
      'id': user.id,
      'email': user.email,
      'display_name': user.userMetadata?['full_name'] ??
          user.email?.split('@').first,
      'avatar_url': user.userMetadata?['avatar_url'],
    });
  }

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
