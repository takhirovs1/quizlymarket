import 'dart:developer';

import '../preference_dao/preference_entry.dart';
import 'secure_store.dart';

void _log(Object? message) => log(name: '[LocalSource][PreferenceDaoX]', message.toString());

extension PreferenceDaoX on PreferenceDao {
  /// Reads value from cache and returns it if not null,
  /// otherwise reads from the entry and caches the result.
  T? readFromCache<T>(PreferenceEntry<Object?> entry) {
    try {
      final cached = cache[entry.key] as T?;

      if (cached != null) return cached;

      final localeSaved = entry.read() as T?;
      cache[entry.key] = localeSaved;

      return localeSaved;
    } on Object catch (e) {
      _log('[${entry.key}]. Error reading from cache: $e');
      return null;
    }
  }

  // Read from cache if null, otherwise decrypt and caches the result
  String readCachedOrDecrypted(PreferenceEntry<String> entry) {
    try {
      final cached = cache[entry.key] as String?;

      if (cached != null) return cached;

      final decrypted = SecureStorage.readUsingDecryption<PreferenceEntry<String>>(entry);

      cache[entry.key] = decrypted;

      return decrypted;
    } on Object catch (e) {
      _log('[${entry.key}]. Error reading from encrypted cache: $e');
      return '';
    }
  }
}
