import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation;

import 'src/common/constant/config.dart';
import 'src/common/core_widgets/app.dart';
import 'src/common/core_widgets/configuration_settings_app.dart';
import 'src/common/core_widgets/initialization_failed_app.dart';
import 'src/common/dependencies/initialization/initialization.dart';
import 'src/common/dependencies/widget/dependencies_scope.dart';
import 'src/common/dependencies/widget/splash_screen.dart';
import 'src/common/util/helpers.dart';
import 'src/common/util/logger.dart';
import 'src/feature/settings/screen/settings_scope.dart';

@pragma('vm:entry-point')
void main([List<String>? args]) => runZonedGuarded<Future<void>>(() async {
  Future<void> _launchApp() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    final initializationProgress = ValueNotifier<({int progress, String message})>((progress: 0, message: ''));
    final logo = await Helpers.getPlatformSpecificLogo();

    final isNeedToOpenConfigSettings = switch (Config.current().environment) {
      EnvironmentFlavor.production => false,
      EnvironmentFlavor.staging || EnvironmentFlavor.development => !Config.current().isInitializationDone,
    };

    if (isNeedToOpenConfigSettings) {
      runApp(ConfigurationSettingsApp(launchApp: _launchApp));
      return;
    }

    runApp(
      DependenciesScope(
        initialization: $initializeApp(
          binding: binding,
          onProgress: (progress, message) => initializationProgress.value = (progress: progress, message: message),
          orientations: [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
        ),
        splashScreen: SplashScreen(logo: logo, progress: initializationProgress),
        child: const SettingsScope(child: App()),
        errorBuilder: (error, stackTrace) => InitializationFailedApp(
          key: ValueKey<String>(error.toString()),
          error: error,
          stackTrace: stackTrace ?? StackTrace.current,
          onRetryInitialization: _launchApp,
        ),
      ),
    );
  }

  await _launchApp();
}, severe);
