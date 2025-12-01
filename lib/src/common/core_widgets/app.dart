import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:thunder/thunder.dart';

import '../../feature/profile/presentation/state/settings_scope.dart';
import '../extension/context_extension.dart';
import '../localization/localization.dart';
import '../router/app_router.dart';
import '../util/logger.dart';
import '../widget/keyboard_dismiss.dart';

/// {@template app}
/// App widget.
/// {@endtemplate}
class App extends StatefulWidget {
  /// {@macro app}
  const App({super.key});

  static final ValueNotifier<bool> thunderEnabledNotifier = ValueNotifier<bool>(
    false,
  );

  /// Accessing [_AppState]
  static _AppState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>();
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _configureTelegramShell();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Quizly Market',
        restorationScopeId: 'material_app',
        onGenerateTitle: (context) => context.l10n.title,
        routerConfig: router,
        supportedLocales: Localization.supportedLocales,
        localizationsDelegates: Localization.delegates,
        locale: SettingsScope.settingsOf(context).localization,
        theme: SettingsScope.settingsOf(context).appTheme,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: KeyboardDismiss(
            child: ValueListenableBuilder<bool>(
              valueListenable: App.thunderEnabledNotifier,
              builder: (context, thunderEnabled, _) => Thunder(
                dio: context.dependencies.dio.all,
                color: context.color.success,
                enabled: true,
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          ),
        ),
      );

  void _configureTelegramShell() {
    if (!kIsWeb) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final telegram = TelegramWebApp.instance;
        if (!telegram.isSupported) return;

        telegram
          ..ready()
          ..expand()
          ..disableVerticalSwipes()
          ..requestFullscreen();
      } on Object catch (error, stackTrace) {
        warning(error, stackTrace, 'Telegram Web App configuration failed');
      }
    });
  }
}
