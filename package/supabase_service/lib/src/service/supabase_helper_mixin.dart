mixin SupabaseHelpersMixin {
  static const String _emailDomain = 'quizlymarket.fake';

  /// Builds a deterministic fake email that Supabase auth can work with.
  String getEmail(String telegramID) => '$telegramID@$_emailDomain';

  /// Casts a single row to a map of strings to objects.
  Map<String, Object?> castSingleRow(dynamic result) {
    if (result is Map<String, dynamic>) {
      return result.cast<String, Object?>();
    }
    final rows = castRows(result);
    return rows.isEmpty ? const <String, Object?>{} : rows.first;
  }

  /// Casts a list of rows to a list of maps of strings to objects.
  List<Map<String, Object?>> castRows(dynamic result) {
    if (result is List) {
      return result.whereType<Map<String, dynamic>>().map((row) => row.cast<String, Object?>()).toList(growable: false);
    }
    return const <Map<String, Object?>>[];
  }
}
