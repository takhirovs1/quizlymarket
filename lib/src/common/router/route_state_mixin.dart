import 'dart:developer';

import 'package:elixir/elixir.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../extension/context_extension.dart';
import '../util/logger.dart';
import 'route.dart';

mixin RouteStateMixin<T extends StatefulWidget> on State<T> {
  late ElixirNavigationState initialPages;

  late ElixirGuard guards;

  @override
  void initState() {
    super.initState();
    final currentPage = !context.localSource.onboardingCompleted ? const OnboardingPage() : const MainPage();
    log('onboardingCompleted: ${context.localSource.onboardingCompleted}');
    initialPages = [currentPage];

    guards = [
      (context, state) => state.length > 1 ? state : [currentPage],
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeTelegramWebApp());
  }

  void _initializeTelegramWebApp() {
    if (!kIsWeb) return;

    try {
      final telegram = TelegramWebApp.instance;
      if (!telegram.isSupported) return;

      telegram
        ..ready()
        ..expand()
        ..requestFullscreen()
        ..disableVerticalSwipes();
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to initialize Telegram Web App');
    }
  }
}
