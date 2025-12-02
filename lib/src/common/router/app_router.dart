import 'package:flutter/material.dart';

import '../../feature/main/data/model/main_tabs_enum.dart';
import '../../feature/main/presentation/screen/main_screen.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';
import '../../feature/test/presentation/screen/custom_mode_screen.dart';
import '../../feature/test/presentation/screen/test_init_screen.dart';
import '../../feature/test/presentation/screen/university_mode_screen.dart';
import '../extension/context_extension.dart';
import 'route_arguments.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.onboarding:
      {
        if (!rootNavigatorKey.currentContext!.localSource.onboardingCompleted) {
          return _materialRoute(const OnboardingScreen(), settings);
        }
        return _materialRoute(const MainScreen(initialTab: MainTabsEnum.home), settings);
      }

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
    default:
      return _materialRoute(const OnboardingScreen(), settings);
  }
}

MainTabsEnum _tabFromRoute(String? routeName) => switch (routeName) {
  Routes.cart => MainTabsEnum.cart,
  Routes.profile => MainTabsEnum.profile,
  _ => MainTabsEnum.home,
};

MaterialPageRoute<dynamic> _materialRoute(Widget child, RouteSettings settings) =>
    MaterialPageRoute<dynamic>(settings: settings, builder: (_) => child);
