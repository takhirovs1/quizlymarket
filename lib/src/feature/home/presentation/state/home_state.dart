import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../../../common/util/logger.dart';
import '../screen/home_screen.dart';

abstract class HomeState extends State<HomeScreen> {
  HomeState();

  late final WebAppUser? telegramUser;

  @override
  void initState() {
    super.initState();
    telegramUser = _resolveTelegramUser();
  }

  WebAppUser? _resolveTelegramUser() {
    if (!kIsWeb) return null;

    try {
      final telegram = TelegramWebApp.instance;
      if (!telegram.isSupported) return null;

      return telegram.initDataUnsafe?.user;
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to read Telegram user data');
      return null;
    }
  }
}
