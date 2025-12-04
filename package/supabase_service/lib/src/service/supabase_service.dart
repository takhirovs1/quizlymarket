import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_service/src/constants/tables.dart';

/// High-level facade around the Supabase Flutter client tailored to the Quizly
/// profile workflows.
class SupabaseService with SupabaseHelpersMixin {
  SupabaseService(this._supabase);

  final Supabase _supabase;

  SupabaseClient get _client => _supabase.client;

  static SupabaseService? _instance;

  static SupabaseService get instance {
    assert(_instance != null, 'SupabaseService not initialized');
    return _instance!;
  }

  /// Initializes the Supabase Flutter SDK and wires it into the singleton.
  static Future<SupabaseService> initialize({required String url, required String anonKey}) async {
    final supabase = await Supabase.initialize(url: url, anonKey: anonKey);
    _instance = SupabaseService(supabase);
    return _instance!;
  }

  static const Set<String> _reservedQueryKeys = {'limit', 'order', 'ascending'};

  /// Signs a user in via their Telegram credentials and fetches their profile.
  Future<Map<String, Object?>> login({required String telegramID}) async {
    final email = getEmail(telegramID);
    final telegramNumericId = int.tryParse(telegramID);
    if (telegramNumericId == null) {
      log('Invalid telegram id provided for login: $telegramID');
      return const <String, Object?>{};
    }

    try {
      final response = await _client.auth.signInWithPassword(email: email, password: telegramID);
      log('login() userId=${response.user?.id}');

      final profile = await _client
          .from(Tables.profiles)
          .select()
          .eq('telegram_id', telegramNumericId)
          .limit(1)
          .single();

      final mappedProfile = _castSingleRow(profile);
      log('login() profileId=${mappedProfile['id']}');
      return mappedProfile;
    } catch (error, stackTrace) {
      log('Failed to login user $telegramID', error: error, stackTrace: stackTrace);
      return const <String, Object?>{};
    }
  }

  /// Creates a Supabase auth user, upserts the related profile, and returns it.
  Future<Map<String, Object?>> signUp({
    required String telegramID,
    required String name,
    required String telegramUsername,
  }) async {
    final email = getEmail(telegramID);
    final telegramNumericId = int.tryParse(telegramID);
    if (telegramNumericId == null) {
      log('Invalid telegram id provided for signUp: $telegramID');
      return const <String, Object?>{};
    }

    try {
      final response = await _client.auth.signUp(email: email, password: telegramID);
      final userId = response.user?.id;
      log('signUp() userId=$userId');

      if (userId == null) {
        log('signUp() missing user id for telegram $telegramID');
        return const <String, Object?>{};
      }

      final profile = await _client.from(Tables.profiles).upsert({
        'user_id': userId,
        'telegram_id': telegramNumericId,
        'telegram_username': telegramUsername.trim(),
        'full_name': name.trim(),
      }).select();

      final mappedProfile = _castSingleRow(profile);
      log('signUp() profileId=${mappedProfile['id']}');
      return mappedProfile;
    } catch (error, stackTrace) {
      log('Failed to sign up user $telegramID', error: error, stackTrace: stackTrace);
      return const <String, Object?>{};
    }
  }

  /// Performs a best-effort filtered fetch for profile rows.
  Future<List<Map<String, Object?>>> getAllUsers(Map<String, Object?> query) async {
    try {
      dynamic builder = _client.from(Tables.profiles).select();

      query.forEach((key, value) {
        if (value == null || _reservedQueryKeys.contains(key)) {
          return;
        }
        builder = builder.ilike(key, '%$value%');
      });

      final orderBy = query['order'];
      if (orderBy is String && orderBy.trim().isNotEmpty) {
        final ascending = query['ascending'];
        builder = builder.order(orderBy, ascending: ascending is bool ? ascending : true);
      }

      final limit = query['limit'];
      if (limit is int && limit > 0) {
        builder = builder.limit(limit);
      }

      final result = await builder;
      return _castRows(result);
    } catch (error, stackTrace) {
      log('Failed to fetch users', error: error, stackTrace: stackTrace);
      return const <Map<String, Object?>>[];
    }
  }

  Future<List<Map<String, Object?>>> getTests() async {
    try {
      final res = await _client
          .from('tests')
          .select('''
      id,
      subject_id,
      title,
      price,
      question_count,
      academic_year,
      semester,
      subject:subjects(
        id,
        name,
        direction:directions(
          id,
          name,
          course:courses(
            id,
            name,
            faculty:faculties(
              id,
              name,
              university:universities(
                id,
                name
              )
            )
          )
        )
      )
    ''')
          .eq('is_active', true);
      log('getTests() res=$res');

      return _castRows(res);
    } catch (error, stackTrace) {
      log('Failed to fetch tests', error: error, stackTrace: stackTrace);
      return const <Map<String, Object?>>[];
    }
  }

  /// Tears down the Supabase client and clears the cached singleton.
  Future<void> dispose() async {
    await _supabase.dispose();
    if (identical(_instance, this)) {
      _instance = null;
    }
  }

  Map<String, Object?> _castSingleRow(dynamic result) {
    if (result is Map<String, dynamic>) {
      return result.cast<String, Object?>();
    }
    final rows = _castRows(result);
    return rows.isEmpty ? const <String, Object?>{} : rows.first;
  }

  List<Map<String, Object?>> _castRows(dynamic result) {
    if (result is List) {
      return result.whereType<Map<String, dynamic>>().map((row) => row.cast<String, Object?>()).toList(growable: false);
    }
    return const <Map<String, Object?>>[];
  }
}

mixin SupabaseHelpersMixin {
  static const String _emailDomain = 'quizlymarket.fake';

  /// Builds a deterministic fake email that Supabase auth can work with.
  String getEmail(String telegramID) => '$telegramID@$_emailDomain';
}
