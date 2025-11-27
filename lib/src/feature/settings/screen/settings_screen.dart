import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/extension/context_extension.dart';
import '../state/settings_state.dart';

/// {@template settings_screen}
/// SettingsScreen widget.
/// {@endtemplate}
class SettingsScreen extends StatefulWidget {
  /// {@macro settings_screen}
  const SettingsScreen({required this.data, super.key});

  final String data;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _SettingsScreenState? maybeOf(BuildContext context) => context.findAncestorStateOfType<_SettingsScreenState>();

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

/// State for widget SettingsScreen.
class _SettingsScreenState extends SettingsState {
  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: context.dependencies.settingsBloc,
    child: const Scaffold(body: Center(child: Text('Settings screen'))),
  );
}
