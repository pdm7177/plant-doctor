import 'dart:convert';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/plant_analysis.dart';

class SupabaseService {
  static SupabaseClient get _db => Supabase.instance.client;

  bool get isSignedIn => _db.auth.currentUser != null;
  User? get currentUser => _db.auth.currentUser;

  // Returns how many free analyses remain in the current 30-day window.
  // Falls back to freeLimit if user is not signed in or server is unreachable.
  Future<int> getRemainingAnalyses() async {
    const freeLimit = 5;
    final user = _db.auth.currentUser;
    if (user == null) return freeLimit;

    try {
      final profile = await _db
          .from('profiles')
          .select('registration_date, created_at')
          .eq('id', user.id)
          .maybeSingle();
      if (profile == null) return freeLimit;

      // Use created_at as fallback for existing users with NULL registration_date
      final rawDate =
          (profile['registration_date'] ?? profile['created_at']) as String;
      final regDate = DateTime.parse(rawDate).toLocal();

      final daysSince = DateTime.now().difference(regDate).inDays;
      final periodStart = regDate.add(Duration(days: (daysSince ~/ 30) * 30));

      final rows = await _db
          .from('analysis_history')
          .select('id')
          .eq('user_id', user.id)
          .gte('created_at', periodStart.toUtc().toIso8601String());

      final used = (rows as List).length;
      return (freeLimit - used).clamp(0, freeLimit).toInt();
    } catch (_) {
      return freeLimit; // fail open — allow analysis if server unreachable
    }
  }

  // Returns the user's subscription tier: 'free' | 'monthly' | 'yearly'.
  // Defaults to 'free' for anonymous users or on any error.
  Future<String> getSubscriptionTier() async {
    final user = _db.auth.currentUser;
    if (user == null) return 'free';
    try {
      final profile = await _db
          .from('profiles')
          .select('subscription_tier')
          .eq('id', user.id)
          .maybeSingle();
      return (profile?['subscription_tier'] as String?) ?? 'free';
    } catch (_) {
      return 'free';
    }
  }

  // Runs plant analysis via the analyze-plant Edge Function (owner key chosen
  // server-side by tier). Returns the parsed result JSON in the same shape the
  // app already consumes. The session auth token is attached automatically.
  Future<Map<String, dynamic>> analyzePlant(File image, String language) async {
    final imageBase64 = base64Encode(await image.readAsBytes());
    try {
      final res = await _db.functions.invoke(
        'analyze-plant',
        body: {'imageBase64': imageBase64, 'language': language},
      );
      final data = res.data;
      if (data is! Map) throw Exception('Unexpected analysis response');
      return Map<String, dynamic>.from(data);
    } on FunctionException catch (e) {
      final details = e.details;
      final msg = (details is Map ? details['error'] : null) ??
          e.reasonPhrase ??
          'Analysis failed';
      throw Exception(msg);
    }
  }

  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      serverClientId: '361290088528-crt087lg7kmr66os6fp7ftuaqoagbuma.apps.googleusercontent.com',
    );

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google Sign-In cancelled');

    final googleAuth = await googleUser.authentication;
    final idToken = googleAuth.idToken;
    if (idToken == null) throw Exception('Failed to get idToken from Google');

    await _db.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: googleAuth.accessToken,
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
      'registration_date': DateTime.now().toUtc().toIso8601String(),
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

  Future<void> deleteAnalysisById(String id) async {
    final user = _db.auth.currentUser;
    if (user == null) return;
    await _db.from('analysis_history')
        .delete()
        .eq('id', id)
        .eq('user_id', user.id);
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
