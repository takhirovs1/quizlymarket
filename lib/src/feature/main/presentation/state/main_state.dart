import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/extension/context_extension.dart';
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
    setState(() {});
    final newTab = MainTabsEnum.values[index];

    if (currentTab != newTab) _switchTab(newTab);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    bottomNavigationAnimated = true;
    setState(() {});
  }

  // Change tab
  void _switchTab(MainTabsEnum newTab) {
    if (!mounted || currentTab == newTab) return;
    widget.navigationShell.goBranch(newTab.index);

    setState(() => currentTab = newTab);
  }

  Future<void> onPopInvokedWithResult(bool didPop, Object? result) async {
    if (currentTab != MainTabsEnum.home) return _switchTab(MainTabsEnum.home);

    if (_canExitApp) return context.pop();

    _canExitApp = true;

    if (mounted && context.mounted) {
      context.showNotification(
        message: context.l10n.pressBackAgainToExit,
        backgroundColor: context.color.success,
      );
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
    currentTab = widget.navigationShell.currentIndex == 0
        ? MainTabsEnum.home
        : widget.navigationShell.currentIndex == 1
        ? MainTabsEnum.cart
        : MainTabsEnum.profile;
  }

  @override
  void dispose() {
    _exitTimer?.cancel();
    super.dispose();
  }

  /* #endregion */
}
