import 'package:elixir/elixir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thunder/thunder.dart';

import '../../feature/profile/presentation/bloc/settings_bloc.dart';
import '../extension/context_extension.dart';
import '../localization/localization.dart';
import '../router/route_state_mixin.dart';
import '../widget/keyboard_dismiss.dart';

/// {@template app}
/// App widget.
/// {@endtemplate}
class App extends StatefulWidget {
  /// {@macro app}
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with RouteStateMixin {
  final GlobalKey<State<StatefulWidget>> _preserveKey = GlobalKey<State<StatefulWidget>>();

  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.dependencies.settingsBloc;

    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      builder: (context, state) => MaterialApp(
        key: _preserveKey,
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'material_app',
        onGenerateTitle: (context) => context.l10n.title,

        /// Locale
        supportedLocales: Localization.supportedLocales,
        localizationsDelegates: Localization.delegates,
        locale: state.settings.localization,

        /// Theme
        theme: state.settings.appTheme,
        builder: (context, _) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: KeyboardDismiss(
            child: Thunder(
              dio: context.dependencies.dio.all,
              color: context.color.success,
              enabled: true,
              child: Elixir.controlled(controller: ValueNotifier(initialPages), guards: guards),
            ),
          ),
        ),
      ),
    );
  }
}
