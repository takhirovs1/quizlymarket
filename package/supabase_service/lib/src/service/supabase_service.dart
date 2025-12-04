import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_service/src/constants/tables.dart';

class SupabaseService with SupabaseHelpersMixin {
  final Supabase? _supabase;

  const SupabaseService(this._supabase);

  static SupabaseService? _instance;
  static SupabaseService get instance {
    assert(_instance != null, 'SupabaseService not initialized');
    return _instance!;
  }

  static Future<SupabaseService> initialize({required String url, required String anonKey}) async {
    final supabase = await Supabase.initialize(url: url, anonKey: anonKey);
    _instance = SupabaseService(supabase);
    return _instance!;
  }

  Future<Map<String, Object?>> login({required String telegramID}) async {
    final response = await _supabase?.client.auth.signInWithPassword(email: getEmail(telegramID), password: telegramID);
    log('response id in login: ${response?.user?.id}');
    final profile = await _supabase?.client
        .from(Tables.profiles)
        .select()
        .eq('telegram_id', int.parse(telegramID))
        .limit(1)
        .single();
    log('profile in login: $profile');
    return profile?.cast<String, Object?>() ?? {};
  }

  Future<Map<String, Object?>> signUp({
    required String telegramID,
    required String name,
    required String telegramUsername,
  }) async {
    final response = await _supabase?.client.auth.signUp(email: getEmail(telegramID), password: telegramID);
    log('response id in signUp: ${response?.user?.id}');
    final id = response?.user?.id;
    final profile = await _supabase?.client.from(Tables.profiles).upsert({
      'user_id': id,
      'telegram_id': telegramID,
      'telegram_username': telegramUsername,
      'full_name': name,
    }).select();
    log('profile in signUp: $profile');
    return profile?.first.cast<String, Object?>() ?? {};
  }

  Future<List<Map<String, Object?>>> getAllUsers(Map<String, Object?> query) async {
    final client = _supabase?.client;
    if (client == null) {
      return [];
    }

    try {
      const reservedKeys = {'limit', 'order', 'ascending'};
      dynamic builder = client.from(Tables.profiles).select();

      query.forEach((key, value) {
        if (value == null || reservedKeys.contains(key)) {
          return;
        }
        builder = builder.ilike(key, '%$value%');
      });

      final orderBy = query['order'];
      if (orderBy is String && orderBy.isNotEmpty) {
        final ascending = query['ascending'];
        builder = builder.order(orderBy, ascending: ascending is bool ? ascending : true);
      }

      final limit = query['limit'];
      if (limit is int && limit > 0) {
        builder = builder.limit(limit);
      }

      final result = await builder;
      if (result is! List) {
        return [];
      }

      return result.whereType<Map<String, dynamic>>().map((row) => row.cast<String, Object?>()).toList();
    } catch (error, stackTrace) {
      log('Failed to fetch users', error: error, stackTrace: stackTrace);
      return [];
    }
  }

  Future<void> dispose() async => await _supabase?.dispose();
}

mixin SupabaseHelpersMixin {
  String getEmail(String telegramID) => '$telegramID@quizlymarket.fake';
}
