import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation;

import 'src/common/core_widgets/app.dart';
import 'src/common/dependencies/initialization/initialization.dart';
import 'src/common/dependencies/widget/dependencies_scope.dart';
import 'src/common/dependencies/widget/splash_screen.dart';
import 'src/common/util/helpers.dart';
import 'src/common/util/logger.dart';

@pragma('vm:entry-point')
void main([List<String>? args]) => runZonedGuarded<Future<void>>(() async {
  Future<void> _launchApp() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    final initializationProgress =
        ValueNotifier<({int progress, String message})>((
          progress: 0,
          message: '',
        ));
    final logo = await Helpers.getPlatformSpecificLogo();

    runApp(
      DependenciesScope(
        initialization: $initializeApp(
          binding: binding,
          onProgress: (progress, message) => initializationProgress.value = (
            progress: progress,
            message: message,
          ),
          orientations: [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
        ),
        splashScreen: SplashScreen(
          logo: logo,
          progress: initializationProgress,
        ),
        child: const App(),
      ),
    );
  }

  await _launchApp();
}, severe);
