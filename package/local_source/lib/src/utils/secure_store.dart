import 'dart:developer';

import 'package:encrypt/encrypt.dart' as encrypt;

import '../../local_source.dart';

/// {@template secure_storage}
/// A sealed class for secure storage operations using AES encryption.
/// {@endtemplate}
sealed class SecureStorage {
  /// {@macro secure_storage}
  const SecureStorage._();

  /// The key used for encryption and decryption.
  static final _key = encrypt.Key.fromBase64('sl8vq6Kd/q7uaUep6LCg3RKPaSB7dKKZ');

  /// Encrypts the given string value and stores it in SharedPreferences using AES encryption.
  ///
  /// This method uses AES encryption with a randomly generated IV (Initialization Vector)
  /// to encrypt the provided [value] and stores it in the format "IV:ENCRYPTED_DATA".
  ///
  /// Parameters:
  /// - [value]: The string to be encrypted. If empty, an empty string will be stored.
  /// - [entry]: The PreferenceEntry where the encrypted value will be stored.
  ///
  /// The stored format is: "{base64_encoded_iv}:{base64_encoded_encrypted_data}"
  ///
  /// Throws:
  /// - Encryption errors if the key is invalid
  /// - Storage errors if SharedPreferences operations fail
  static Future<void> setUsingEncryption<T extends PreferenceEntry<String>>(String value, {required T entry}) async {
    try {
      if (value.isEmpty) return await entry.set('');

      final iv = encrypt.IV.fromSecureRandom(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(_key));
      final encrypted = encrypter.encrypt(value, iv: iv);

      final storageValue = '${iv.base64}:${encrypted.base64}';
      await entry.set(storageValue);
    } on Object catch (e) {
      final sb = StringBuffer()
        ..writeln('═══════ Encryption Error ═══════')
        ..writeln('Timestamp: ${DateTime.now().toIso8601String()}')
        ..writeln('Entry Key: ${entry.key}')
        ..writeln('Attempted Value Length: ${value.length}')
        ..writeln('Error Details: $e')
        ..writeln('═══════════════════════════════');

      log(sb.toString());
      rethrow;
    }
  }

  /// Retrieves and decrypts a value from SharedPreferences using AES decryption.
  ///
  /// This method expects the stored value to be in the format "IV:ENCRYPTED_DATA",
  /// where both IV and ENCRYPTED_DATA are base64 encoded strings.
  ///
  /// Parameters:
  /// - [entry]: The PreferenceEntry to read the encrypted value from.
  ///
  /// Returns:
  /// - The decrypted string value
  /// - Empty string if:
  ///   * The stored value is empty
  ///   * The stored value is not in the correct format
  ///   * Decryption fails for any reason
  ///
  /// Note: This method handles all errors internally and returns an empty string
  /// instead of throwing exceptions to maintain data access stability.
  static String readUsingDecryption<T extends PreferenceEntry<String>>(T entry) {
    try {
      final storedValue = entry.read() ?? '';
      if (storedValue.isEmpty) return '';

      final parts = storedValue.split(':');
      if (parts.length != 2) {
        _logDecryptionError<T>(
          entry: entry,
          error: 'Invalid storage format',
          details: 'Expected format: "IV:ENCRYPTED_DATA"',
          storedValue: storedValue,
        );
        return '';
      }

      final iv = encrypt.IV.fromBase64(parts[0]);
      final encryptedData = parts[1];
      final encrypter = encrypt.Encrypter(encrypt.AES(_key));

      return encrypter.decrypt64(encryptedData, iv: iv);
    } on FormatException catch (e) {
      _logDecryptionError<T>(entry: entry, error: 'Invalid base64 format', details: e.toString());
      return '';
    } on Object catch (e) {
      _logDecryptionError<T>(entry: entry, error: 'Decryption failed', details: e.toString());

      return '';
    }
  }

  /// Helper method to consistently format decryption error logs
  static void _logDecryptionError<T extends PreferenceEntry<String>>({
    required T entry,
    required String error,
    required String details,
    String? storedValue,
  }) {
    final sb = StringBuffer()
      ..writeln('═══════ Decryption Error ═══════')
      ..writeln('Timestamp: ${DateTime.now().toIso8601String()}')
      ..writeln('Entry Key: ${entry.key}')
      ..writeln('Error Type: $error')
      ..writeln('Error Details: $details');

    if (storedValue != null) {
      sb
        ..writeln('Stored Value: $storedValue')
        ..writeln('Stored Value Length: ${storedValue.length}');
    }

    sb.writeln('═══════════════════════════════');
    log(sb.toString());
  }
}
