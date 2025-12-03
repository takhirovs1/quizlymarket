import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_source/local_source.dart';

import '../../feature/admin/home/presentation/screen/admin_home_screen.dart';
import '../../feature/admin/main/presentation/screen/admin_main_screen.dart';
import '../../feature/auth/model/user_model.dart';
import '../../feature/user/main/data/model/main_tabs_enum.dart';
import '../../feature/user/main/presentation/screen/main_screen.dart';
import '../../feature/user/onboarding/presentation/onboarding_screen.dart';
import '../../feature/user/test/presentation/bloc/test_bloc.dart';
import '../../feature/user/test/presentation/screen/custom_mode_screen.dart';
import '../../feature/user/test/presentation/screen/test_init_screen.dart';
import '../../feature/user/test/presentation/screen/test_result_screen.dart';
import '../../feature/user/test/presentation/screen/university_mode_screen.dart';
import 'route_arguments.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

RouteFactory buildRouteFactory(LocalSource localSource, UserRole? role) =>
    (settings) => _onGenerateRoute(settings, localSource, role);

Route<dynamic> _onGenerateRoute(RouteSettings settings, LocalSource localSource, UserRole? role) {
  // TODO: Shu joydan userga qarab page'ga ajratish kerak
  final userRole = role ?? MockUsers.activeRole;
  return switch (settings.name) {
    Routes.onboarding => _resolveOnboardingOrHome(settings, localSource),
    Routes.home ||
    Routes.cart ||
    Routes.profile => _materialRoute(_homeScreenForRole(userRole, settings.name), settings),
    Routes.testInit => _materialRoute(const TestInitScreen(), settings),
    Routes.customMode => _materialRoute(
      BlocProvider(create: (context) => TestBloc(), child: const CustomModeScreen()),
      settings,
    ),
    Routes.universityMode => _materialRoute(
      BlocProvider(create: (context) => TestBloc(), child: const UniversityModeScreen()),
      settings,
    ),
    Routes.testResult => _materialRoute(const TestResultScreen(), settings),
    Routes.adminHome => _materialRoute(const AdminHomeScreen(), settings),
    _ => _resolveOnboardingOrHome(settings, localSource),
  };
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
    ? _materialRoute(_homeScreenForRole(MockUsers.activeRole, Routes.home), settings)
    : _materialRoute(const OnboardingScreen(), settings);

Widget _homeScreenForRole(UserRole role, String? routeName) =>
    role == UserRole.admin ? const AdminMainScreen() : MainScreen(initialTab: _tabFromRoute(routeName));
