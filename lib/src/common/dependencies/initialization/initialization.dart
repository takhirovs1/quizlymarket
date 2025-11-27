import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'dart:io' as io;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_source/local_source.dart';
import 'package:platform_info/platform_info.dart';

import '../../../feature/settings/bloc/settings_bloc.dart';
import '../../../feature/settings/data/settings_repository.dart';
import '../../../feature/settings/models/app_settings.dart';
import '../../constant/config.dart';
import '../../constant/gen/fonts.gen.dart';
import '../../constant/pubspec.yaml.g.dart';
import '../../theme/theme_data.dart';
import '../../util/error_util.dart';
import '../../util/http_log_interceptor.dart';
import '../../util/logger.dart';
import '../../util/screen_util.dart';
import '../../util/telegram_bot_interceptor.dart';
import '../dio/dio.dart';
import '../model/app_metadata.dart';
import '../model/dependencies.dart';

part 'initialize_dependencies.dart';

/// Ephemerally initializes the app and prepares it for use.
Future<Dependencies>? _$initializeApp;

/// Initializes the app and prepares it for use.
Future<Dependencies> $initializeApp({
  required WidgetsBinding binding,
  bool deferFirstFrame = false,
  List<DeviceOrientation>? orientations,
  void Function(int progress, String message)? onProgress,
  FutureOr<void> Function(Dependencies dependencies)? onSuccess,
  void Function(Object error, StackTrace stackTrace)? onError,
}) => _$initializeApp ??= Future<Dependencies>(() async {
  final stopwatch = Stopwatch()..start();

  try {
    if (deferFirstFrame) binding.deferFirstFrame();

    await _catchExceptions();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));

    await Future.wait<void>([
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]),
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),

      if (orientations != null) SystemChrome.setPreferredOrientations(orientations),
    ]);

    final dependencies = await $initializeDependencies(onProgress: onProgress).timeout(const Duration(minutes: 7));

    await onSuccess?.call(dependencies);

    return dependencies;
  } on Object catch (error, stackTrace) {
    onError?.call(error, stackTrace);
    ErrorUtil.logError(error, stackTrace, hint: 'Failed to initialize app').ignore();

    rethrow;
  } finally {
    stopwatch.stop();

    /// Delay to log the initialization time
    Future<void>.delayed(
      const Duration(milliseconds: 100),
      () => log('Initialization completed in ${stopwatch.elapsed}', name: 'Initialization'),
    );

    binding.addPostFrameCallback((_) {
      // Closes splash screen, and show the app layout.
      if (deferFirstFrame) binding.allowFirstFrame();
      //final context = binding.renderViewElement;
    });

    _$initializeApp = null;
  }
});

Future<void> _catchExceptions() async {
  try {
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      ErrorUtil.logError(error, stackTrace, hint: 'ROOT | ${Error.safeToString(error)}').ignore();

      return true;
    };

    final sourceFlutterError = FlutterError.onError;
    FlutterError.onError = (final details) {
      ErrorUtil.logError(
        details.exception,
        details.stack ?? StackTrace.current,
        hint: 'FLUTTER ERROR\r\n$details',
      ).ignore();

      sourceFlutterError?.call(details);
    };
  } on Object catch (error, stackTrace) {
    ErrorUtil.logError(error, stackTrace).ignore();
  }
}
