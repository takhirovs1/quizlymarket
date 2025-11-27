import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dependencies/widget/dependencies_scope.dart';
import '../../../common/extension/context_extension.dart';
import '../bloc/settings_bloc.dart';
import '../models/app_settings.dart';

/// {@template settings_scope}
/// SettingsScope widget.
/// {@endtemplate}
class SettingsScope extends StatefulWidget {
  /// {@macro settings_scope}
  const SettingsScope({required this.child, super.key});

  /// The child widget.
  final Widget child;

  /// Get the [SettingsBloc] instance.
  static SettingsBloc of(BuildContext context, {bool listen = true}) =>
      context.inhOf<_InheritedSettings>(listen: listen).state._settingsBloc;

  /// Get the [AppSettings] instance.
  static AppSettings settingsOf(BuildContext context, {bool listen = true}) =>
      context.inhOf<_InheritedSettings>(listen: listen).settings;

  @override
  State<SettingsScope> createState() => _SettingsScopeState();
}

/// State for widget SettingsScope.
class _SettingsScopeState extends State<SettingsScope> {
  late final SettingsBloc _settingsBloc;

  @override
  void initState() {
    super.initState();
    _settingsBloc = DependenciesScope.of(context).settingsBloc;
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<SettingsBloc, SettingsState>(
    bloc: _settingsBloc,
    builder: (context, state) => _InheritedSettings(settings: state.settings, state: this, child: widget.child),
  );
}

/// {@template inherited_settings}
/// _InheritedSettings widget.
/// {@endtemplate}
class _InheritedSettings extends InheritedWidget {
  /// {@macro inherited_settings}
  const _InheritedSettings({required super.child, required this.state, required this.settings});

  /// _SettingsScopeState instance.
  final _SettingsScopeState state;
  final AppSettings settings;

  @override
  bool updateShouldNotify(covariant _InheritedSettings oldWidget) => settings != oldWidget.settings;
}
