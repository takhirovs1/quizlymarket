import 'package:flutter/material.dart';

import '../../feature/main/data/model/main_tabs_enum.dart';
import '../../feature/main/presentation/screen/main_screen.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';
import 'route_arguments.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.onboarding:
      return _materialRoute(const OnboardingScreen(), settings);
    case Routes.home:
    case Routes.cart:
    case Routes.profile:
      final tab = _tabFromRoute(settings.name);
      return _materialRoute(MainScreen(initialTab: tab), settings);
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
