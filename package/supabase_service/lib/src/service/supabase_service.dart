import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Supabase? _supabase;

  static Future<void> initialize({required String url, required String anonKey}) async {
    _supabase = await Supabase.initialize(url: url, anonKey: anonKey);
    log('Supabase Initialized with url: $url and anonKey: $anonKey', name: 'SupabaseService');
  }

  Future<Map<String, Object?>> login({required String telegramID}) async {
    final email = '$telegramID@quizlymarket.fake';
    final response = await _supabase?.client.auth.signInWithPassword(email: email, password: telegramID);
    log('response id: ${response?.user?.id}');
    return {};
  }

  Future<Map<String, Object?>> signUp({required String telegramID, required String name}) async {
    return {};
  }

  Future<void> dispose() async {
    await _supabase?.dispose();
    _supabase = null;
  }
}
