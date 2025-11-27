import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/config.dart';
import '../util/dimension.dart';

/// {@template configuration_settings_app}
/// A widget that launches the configuration settings app.
/// {@endtemplate}
class ConfigurationSettingsApp extends StatelessWidget {
  /// {@macro configuration_settings_app}
  const ConfigurationSettingsApp({required this.launchApp, super.key});

  final void Function() launchApp;

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'configuration_settings_app',
    home: _ConfigurationSettingsScreen(launchApp: launchApp),
  );
}

/// {@template configuration_settings_screen}
/// A widget that launches the configuration settings app.
/// {@endtemplate}
class _ConfigurationSettingsScreen extends StatefulWidget {
  /// {@macro configuration_settings_screen}
  const _ConfigurationSettingsScreen({required this.launchApp});

  final void Function() launchApp;

  @override
  State<_ConfigurationSettingsScreen> createState() => _ConfigurationSettingsScreenState();
}

class _ConfigurationSettingsScreenState extends State<_ConfigurationSettingsScreen> {
  bool _thunderEnabled = true;
  bool _octopusToolsEnabled = true;

  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  late final ValueNotifier<bool> _isSaveButtonEnabled;

  void onSaveTap() {
    final text = _controller.text;
    if (!_saveButtonValid) return;

    Config.copyWith(
      apiBaseUrl: text,
      isInitializationDone: true,
      thunderEnabled: _thunderEnabled,
      octopusToolsEnabled: _octopusToolsEnabled,
    );

    widget.launchApp();
  }

  bool get _saveButtonValid => _controller.text.isNotEmpty && _controller.text.startsWith('http');

  String get _configLabel => switch (Config.current().environment) {
    EnvironmentFlavor.development => 'Development API base URL',
    EnvironmentFlavor.staging => 'Staging API base URL',
    EnvironmentFlavor.production => 'Production API base URL',
  };

  Future<void> _prefillBaseUrlFromBundledConfig() async {
    final environment = Config.current().environment;
    final assetPath = 'config/${environment.value}.json';

    try {
      final raw = await rootBundle.loadString(assetPath);
      final payload = jsonDecode(raw) as Map<String, dynamic>;
      final url = (payload['API_BASE_URL'] as String?)?.trim();
      if (url == null || url.isEmpty || !mounted) return;

      _controller
        ..text = url
        ..selection = TextSelection.collapsed(offset: url.length);
      _isSaveButtonEnabled.value = _saveButtonValid;
    } catch (error) {
      debugPrint('Failed to prefill api url from $assetPath: $error');
    }
  }

  /* region lifecycle */
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));

    _controller = TextEditingController(text: Config.current().apiBaseUrl);
    _focusNode = FocusNode();
    _isSaveButtonEnabled = ValueNotifier(_controller.text.isNotEmpty);

    unawaited(_prefillBaseUrlFromBundledConfig());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNode.canRequestFocus) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _isSaveButtonEnabled.dispose();
    super.dispose();
  }

  /* end region lifecycle */

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: _focusNode.unfocus,
    child: Scaffold(
      /// App bar
      appBar: AppBar(
        title: const Text(
          'App Configuration',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blueAccent,
      ),

      /// Body
      body: Padding(
        padding: Dimension.pH16,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                focusNode: _focusNode,
                controller: _controller,
                onChanged: (_) => _isSaveButtonEnabled.value = _saveButtonValid,
                decoration: InputDecoration(
                  labelText: _configLabel,
                  border: const OutlineInputBorder(
                    borderRadius: Dimension.rAll10,
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: Dimension.rAll10,
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: Dimension.rAll10,
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                ),
              ),
              Dimension.hBox12,

              Row(
                children: [
                  /// Thunder toggle button
                  _ConfigButton(
                    onTap: () => setState(() => _thunderEnabled = !_thunderEnabled),
                    title: 'Thunder',
                    value: _thunderEnabled,
                  ),
                  Dimension.wBox8,

                  /// Octopus tools toggle button
                  _ConfigButton(
                    onTap: () => setState(() => _octopusToolsEnabled = !_octopusToolsEnabled),
                    title: 'Octopus tools',
                    value: _octopusToolsEnabled,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      /// Save button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isSaveButtonEnabled,
        builder: (context, enabled, child) => Padding(
          padding: Dimension.pH16,
          child: CupertinoButton(
            onPressed: enabled ? onSaveTap : null,
            color: Colors.blue,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Dimension.wBox4,
                Icon(Icons.check, color: Colors.white, size: 24),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

/// {@template config_button}
/// A button that toggles a boolean value.
/// {@endtemplate}
class _ConfigButton extends StatelessWidget {
  /// {@macro config_button}
  const _ConfigButton({required this.onTap, required this.title, required this.value});

  final void Function() onTap;
  final String title;
  final bool value;

  @override
  Widget build(BuildContext context) => Expanded(
    child: InkWell(
      onTap: onTap,
      borderRadius: Dimension.rAll8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1.5),
          borderRadius: Dimension.rAll8,
        ),
        child: Row(
          children: [
            Checkbox(value: value, onChanged: (_) => onTap(), activeColor: Colors.blueAccent),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          ],
        ),
      ),
    ),
  );
}
