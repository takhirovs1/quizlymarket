import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../data/model/main_tabs_enum.dart';
import '../screen/main_screen.dart';

/// {@template main_controller}
/// MainController helper class for [MainScreen].
/// {@endtemplate}
abstract class MainState extends State<MainScreen> {
  /// {@macro main_controller}
  MainTabsEnum currentTab = MainTabsEnum.home;
  bool bottomNavBarEnabled = true;
  Timer? _exitTimer;
  bool _canExitApp = false;
  bool bottomNavigationAnimated = true;

  /// Whether the app can be popped (closed)
  bool get canPop => _canExitApp;

  // Bottom navigation bar item tapped
  Future<void> onItemTapped(int index) async {
    bottomNavigationAnimated = false;
    if (mounted) setState(() {});
    final newTab = MainTabsEnum.values[index];

    if (currentTab != newTab) _switchTab(newTab);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    bottomNavigationAnimated = true;
    if (mounted) setState(() {});
  }

  // Change tab
  void _switchTab(MainTabsEnum newTab) {
    if (!mounted || currentTab == newTab) return;
    setState(() => currentTab = newTab);
  }

  void onPopInvokedWithResult(bool didPop, Object? result) {
    if (didPop) return;

    if (currentTab != MainTabsEnum.home) {
      _switchTab(MainTabsEnum.home);
      return;
    }

    if (_canExitApp) {
      final navigator = Navigator.of(context);
      if (navigator.canPop()) {
        navigator.pop();
      } else {
        SystemNavigator.pop();
      }
      return;
    }

    _canExitApp = true;

    if (mounted && context.mounted) {
      context.showNotification(message: context.l10n.pressBackAgainToExit, backgroundColor: context.color.success);
    }

    _exitTimer?.cancel();
    _exitTimer = Timer(const Duration(seconds: 2), () {
      if (mounted && context.mounted) _canExitApp = false;
    });
  }

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    currentTab = widget.initialTab;
  }

  @override
  void dispose() {
    _exitTimer?.cancel();
    super.dispose();
  }

  /* #endregion */
}
