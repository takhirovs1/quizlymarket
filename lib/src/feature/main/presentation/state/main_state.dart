import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

import '../../../../common/extension/context_extension.dart';
import '../../data/model/main_tabs_enum.dart';
import '../screen/main_screen.dart';

/// {@template main_controller}
/// MainController helper class for [MainScreen].
/// {@endtemplate}
abstract class MainState extends State<MainScreen> {
  /// {@macro main_controller}
  late final PageController pageController;
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
    await _triggerNavigationHaptics();
    final newTab = MainTabsEnum.values[index];

    if (currentTab != newTab) _switchTab(newTab);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    bottomNavigationAnimated = true;
    setState(() {});
  }

  // Change tab
  void _switchTab(MainTabsEnum newTab) {
    if (!mounted || currentTab == newTab) return;
    pageController.animateToPage(newTab.index, duration: const Duration(microseconds: 1), curve: Curves.easeInOut);

    setState(() => currentTab = newTab);
  }

  Future<void> onPopInvokedWithResult(bool didPop, Object? result) async {
    if (currentTab != MainTabsEnum.home) return _switchTab(MainTabsEnum.home);

    if (_canExitApp) return context.pop();

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
    currentTab = widget.initialTab ?? MainTabsEnum.home;
    pageController = PageController(initialPage: currentTab.index);
  }

  Future<void> _triggerNavigationHaptics() async {
    if (kIsWeb) return;

    try {
      await HapticFeedback.selectionClick();
    } on Object catch (_) {}

    if (Platform.isIOS) return;

    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(duration: 25, amplitude: 90);
      } else {
        await HapticFeedback.lightImpact();
      }
    } on Object catch (_) {
      await HapticFeedback.lightImpact();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    _exitTimer?.cancel();
    super.dispose();
  }

  /* #endregion */
}
