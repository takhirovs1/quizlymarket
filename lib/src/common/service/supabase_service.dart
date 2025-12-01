import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../constant/config.dart';

sealed class SupabaseService {
  static const String _profiles = 'profiles';

  static Supabase? _supabase;

  static WebAppUser? get telegramUser {
    if (!kIsWeb) return null;

    try {
      final telegram = TelegramWebApp.instance;
      if (!telegram.isSupported) return null;

      return telegram.initDataUnsafe?.user;
    } on Object catch (_) {
      return null;
    }
  }

  static Future<void> initialize() async {
    if (telegramUser == null) throw Exception('Telegram user is null');
    _supabase = await Supabase.initialize(url: Config.current.supabaseUrl, anonKey: Config.current.supabaseAnonKey);
    await login();
  }

  static SupabaseClient get client {
    assert(_supabase != null, 'Supabase not initialized. Call [SupabaseService.initialize] first.');
    return _supabase!.client;
  }

  static Future<void> getUsers() async {
    final data = await client.from(_profiles).select();
    log('data: $data');
  }

  static Future<String> getProfile() async {
    // await client.auth.refreshSession();
    if (client.auth.currentUser == null) return '';
    final id = client.auth.currentUser?.id;
    log('id: $id');
    if (id == null) return '';
    final data = await client.from(_profiles).select();
    log('dataw: $data');
    return data.firstOrNull?.toString() ?? '';
  }

  static Future<String> login() async {
    log('client.auth.currentUser: ${client.auth.currentUser}');
    if (client.auth.currentUser != null) return getProfile();

    final telegramID = telegramUser?.id.toString();
    if (telegramID == null) throw Exception('Telegram ID is null');

    final email = '$telegramID@quizlymarket.fake';
    try {
      log('signInWithPassword: $email, $telegramID');
      await client.auth.signInWithPassword(email: email, password: telegramID);
      return getProfile();
    } catch (_) {
      log('signUp: $email, $telegramID');
      final response = await client.auth.signUp(email: email, password: telegramID);
      final id = response.user?.id;
      if (id == null) throw Exception('User ID is null');
      final user = await client.from(_profiles).upsert(<String, dynamic>{
        'first_name': telegramUser?.firstName,
        'last_name': telegramUser?.lastName,
        'telegram_id': telegramID,
        'telegram_username': telegramUser?.username,
        'photo_url': telegramUser?.photoUrl,
      });
      log(user.toString());
      return getProfile();
    }
  }

  static Future<void> dispose() async {
    if (_supabase != null) {
      await _supabase!.dispose();
      _supabase = null;
    }
  }
}
