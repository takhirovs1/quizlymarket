import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/router/route_arguments.dart';
import '../../../../../common/util/logger.dart';
import '../../data/model/test_init_enum.dart';
import '../../data/model/test_init_model.dart';
import '../screen/test_init_screen.dart';

abstract class TestInitState extends State<TestInitScreen> {
  final ValueNotifier<CustomTestSettings> testSettings = ValueNotifier(CustomTestSettings(testMode: TestMode.custom));
  final ValueNotifier<TestMode> selectedTestMode = ValueNotifier(TestMode.custom);

  void updateTestMode(TestMode mode) {
    if (selectedTestMode.value == mode) return;
    selectedTestMode.value = mode;
    testSettings.value = testSettings.value.copyWith(testMode: mode);
  }

  void onOpenTestScreen() => switch (testSettings.value.testMode) {
    TestMode.custom => context.goReplacementNamed(Routes.customMode, arguments: testSettings.value),
    TestMode.university => context.goReplacementNamed(Routes.universityMode, arguments: testSettings.value),
  };

  void _setupTelegramBackButton() {
    if (!kIsWeb) return;

    try {
      if (!context.telegramWebApp.isSupported) return;

      context.telegramWebApp.backButton
        ..onClick(_handleTelegramBackButtonPressed)
        ..show();
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to show Telegram back button');
    }
  }

  void _teardownTelegramBackButton() {
    if (!kIsWeb) return;

    try {
      if (!context.telegramWebApp.isSupported) return;

      context.telegramWebApp.backButton
        ..offClick(_handleTelegramBackButtonPressed)
        ..hide();
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to hide Telegram back button');
    }
  }

  void _handleTelegramBackButtonPressed() {
    if (!mounted) return;

    context.pop();
  }

  @override
  void initState() {
    super.initState();
    _setupTelegramBackButton();
  }

  @override
  void dispose() {
    selectedTestMode.dispose();
    testSettings.dispose();
    _teardownTelegramBackButton();
    super.dispose();
  }
}
