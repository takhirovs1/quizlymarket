import 'package:flutter/material.dart';
import 'package:local_source/local_source.dart';

import '../../feature/admin/home/presentation/screen/admin_home_screen.dart';
import '../../feature/user/main/data/model/main_tabs_enum.dart';
import '../../feature/user/main/presentation/screen/main_screen.dart';
import '../../feature/user/onboarding/presentation/onboarding_screen.dart';
import '../../feature/user/test/presentation/screen/custom_mode_screen.dart';
import '../../feature/user/test/presentation/screen/test_init_screen.dart';
import '../../feature/user/test/presentation/screen/test_result_screen.dart';
import '../../feature/user/test/presentation/screen/university_mode_screen.dart';
import 'route_arguments.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

RouteFactory buildRouteFactory(LocalSource localSource) =>
    (settings) => _onGenerateRoute(settings, localSource);

Route<dynamic> _onGenerateRoute(RouteSettings settings, LocalSource localSource) => switch (settings.name) {
  Routes.onboarding => _resolveOnboardingOrHome(settings, localSource),
  Routes.home ||
  Routes.cart ||
  Routes.profile => _materialRoute(MainScreen(initialTab: _tabFromRoute(settings.name)), settings),
  Routes.testInit => _materialRoute(const TestInitScreen(), settings),
  Routes.customMode => _materialRoute(const CustomModeScreen(), settings),
  Routes.universityMode => _materialRoute(const UniversityModeScreen(), settings),
  Routes.testResult => _materialRoute(const TestResultScreen(), settings),
  Routes.adminHome => _materialRoute(const AdminHomeScreen(), settings),
  _ => _resolveOnboardingOrHome(settings, localSource),
};

MainTabsEnum _tabFromRoute(String? routeName) => switch (routeName) {
  Routes.cart => MainTabsEnum.cart,
  Routes.profile => MainTabsEnum.profile,
  _ => MainTabsEnum.home,
};

MaterialPageRoute<dynamic> _materialRoute(Widget child, RouteSettings settings) =>
    MaterialPageRoute<dynamic>(settings: settings, builder: (_) => child);

Route<dynamic> _resolveOnboardingOrHome(RouteSettings settings, LocalSource localSource) =>
    localSource.onboardingCompleted
    ? _materialRoute(const MainScreen(initialTab: MainTabsEnum.home), settings)
    : _materialRoute(const OnboardingScreen(), settings);
