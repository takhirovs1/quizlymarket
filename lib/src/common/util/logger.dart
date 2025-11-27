import 'dart:developer' as developer show log;

import 'package:flutter/foundation.dart' show kReleaseMode;

import '../extension/string_extension.dart';

/// Tracing information
final void Function(Object? message) fine = _logAll('FINE', 500);

/// Static configuration messages
final void Function(Object? message) config = _logAll('CONF', 700);

/// Informational messages
final void Function(Object? message) info = _logAll('INFO', 800);

/// Potential problems
final void Function(Object exception, [StackTrace? stackTrace, String? reason]) warning = _logAll('WARN', 900);

/// Serious failures
final void Function(Object error, [StackTrace stackTrace, String? reason]) severe = _logAll('ERR!', 1000);

void Function(Object? message, [StackTrace? stackTrace, String? reason]) _logAll(String prefix, int level) =>
    (message, [stackTrace, reason]) {
      if (kReleaseMode) return;

      final coloredPrefix = AnsiColor.defaultLevelColors[level]!;

      /// log message with corners and file location
      // final buffer =
      //     StringBuffer('[${coloredPrefix.call(_timeFormat(DateTime.now()))}] ${coloredPrefix.call('─' * 150)}\n')
      //       ..writeln('${reason ?? message}')
      //       ..writeln(_getFileLocation(stackTrace: stackTrace ?? StackTrace.current))
      //       ..write("${'\t' * 120}${coloredPrefix.call('─' * 168)}");

      /// log message - simple
      final buffer = StringBuffer('[${coloredPrefix.call(_timeFormat(DateTime.now()))}] ')
        ..write('${'${reason ?? message}'.ellipsisOrSpace(80)} | ')
        ..write(_getLastLocation(location: _getFileLocation(stackTrace: stackTrace ?? StackTrace.current)));

      developer.log(
        buffer.toString(),
        level: level,
        name: coloredPrefix.call(prefix),
        error: message is Exception || message is Error ? message : null,
        stackTrace: stackTrace,
      );
    };

class AnsiColor {
  const AnsiColor({this.c});

  final int? c;

  static const ansiEsc = '\x1B[';

  static const ansiDefault = '${ansiEsc}0m';

  static int grey(double level) => 232 + (level.clamp(0.0, 1.0) * 23).round();

  static final Map<int, AnsiColor> defaultLevelColors = {
    100: const AnsiColor(c: 4),
    500: AnsiColor(c: AnsiColor.grey(0.5)),
    700: const AnsiColor(c: 2),
    800: const AnsiColor(c: 12),
    900: const AnsiColor(c: 208),
    1000: const AnsiColor(c: 196),
    1200: const AnsiColor(c: 199),
  };

  String call(String msg) => '$this$msg$ansiDefault';

  @override
  String toString() => c != null ? '${ansiEsc}38;5;${c}m' : '';
}

/// Formats the time
String _timeFormat(DateTime time) =>
    '${time.hour}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';

/// Returns the file location
String _getFileLocation({required StackTrace stackTrace}) {
  final fileLocation =
      (stackTrace).toString().split('\n').where((e) => e.contains('package')).skip(1).firstOrNull ?? '';

  final start = fileLocation.indexOf('(') + 1;
  final end = fileLocation.indexOf(')');

  if (start == -1 || end == -1 || fileLocation.isEmpty) {
    return 'Unknown location';
  }

  return fileLocation.substring(fileLocation.indexOf('(') + 1, fileLocation.indexOf(')')).trim();
}

String _getLastLocation({required String location}) => location.split('/').lastOrNull ?? '';
