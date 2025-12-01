import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/logger.dart';
import '../screen/test_init_screen.dart';

abstract class TestInitState extends State<TestInitScreen> {
  void _setupTelegramBackButton() {
    if (!kIsWeb) return;

    try {
      final telegram = TelegramWebApp.instance;
      if (!telegram.isSupported) return;

      telegram.backButton
        ..onClick(_handleTelegramBackButtonPressed)
        ..show();
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to show Telegram back button');
    }
  }

  void _teardownTelegramBackButton() {
    if (!kIsWeb) return;

    try {
      final telegram = TelegramWebApp.instance;
      if (!telegram.isSupported) return;

      telegram.backButton
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
    _teardownTelegramBackButton();
    super.dispose();
  }
}
