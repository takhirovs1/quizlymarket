import 'package:flutter/material.dart';
import 'package:local_source/local_source.dart';

import '../../feature/main/data/model/main_tabs_enum.dart';
import '../../feature/main/presentation/screen/main_screen.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';
import '../../feature/test/presentation/screen/custom_mode_screen.dart';
import '../../feature/test/presentation/screen/test_init_screen.dart';
import '../../feature/test/presentation/screen/test_result_screen.dart';
import '../../feature/test/presentation/screen/university_mode_screen.dart';
import 'route_arguments.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

RouteFactory buildRouteFactory(LocalSource localSource) =>
    (settings) => _onGenerateRoute(settings, localSource);

Route<dynamic> _onGenerateRoute(RouteSettings settings, LocalSource localSource) {
  switch (settings.name) {
    case Routes.onboarding:
      return _resolveOnboardingOrHome(settings, localSource);
    case Routes.home:
    case Routes.cart:
    case Routes.profile:
      final tab = _tabFromRoute(settings.name);
      return _materialRoute(MainScreen(initialTab: tab), settings);
    case Routes.testInit:
      return _materialRoute(const TestInitScreen(), settings);
    case Routes.customMode:
      return _materialRoute(const CustomModeScreen(), settings);
    case Routes.universityMode:
      return _materialRoute(const UniversityModeScreen(), settings);
    case Routes.testResult:
      return _materialRoute(const TestResultScreen(), settings);
    default:
      return _resolveOnboardingOrHome(settings, localSource);
  }
}

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
