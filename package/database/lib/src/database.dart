import 'dart:developer';

import 'package:drift/drift.dart';
// ignore: deprecated_member_use
import 'package:drift/web.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';
part 'tables.dart';

/// {@template database}
/// The drift-managed database for the app.
/// {@endtemplate}
@DriftDatabase(tables: <Type>[])
final class Database extends _$Database {
  // Factory constructor that returns the singleton instance
  factory Database([QueryExecutor? executor]) {
    _instance ??= Database._internal(executor);
    return _instance!;
  }

  // Private constructor
  Database._internal([QueryExecutor? executor]) : super(executor ?? _openConnection());

  // Private static instance
  static Database? _instance;

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    if (kIsWeb) {
      return WebDatabase.withStorage(DriftWebStorage.indexedDb('quizlymarket_db'));
    }

    return driftDatabase(
      name: 'udevs_initial_project.db',
      native: const DriftNativeOptions(databaseDirectory: getApplicationSupportDirectory),
    );
  }

  Future<void> resetDatabase() async {
    try {
      _$log('Starting database reset');
      for (final table in allTables) {
        await delete<Table, Object?>(table).go();
        _$log('Deleted table: ${table.actualTableName}');
      }
      _$log('Database reset completed successfully');
    } on Object catch (e, stackTrace) {
      _$log('Error resetting database: $e');
      _$log(stackTrace.toString());
    }
  }

  // Optional: Method to close and reset the singleton (useful for testing)
  static Future<void> closeSingleton() async {
    if (_instance != null) {
      await _instance!.close();
      _instance = null;
    }
  }
}

void _$log(String message) => log(name: 'AppDatabase', message);
