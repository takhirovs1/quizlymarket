import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../feature/cart/presentation/screen/cart_screen.dart';
import '../../feature/home/presentation/screen/home_screen.dart';
import '../../feature/main/presentation/screen/main_screen.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';
import '../../feature/profile/presentation/screen/profile_screen.dart';
import 'route_arguments.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
GoRouter router = GoRouter(
  initialLocation: Routes.main,
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.onboarding,
      name: Routes.onboarding,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: Routes.main,
      name: Routes.main,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: Routes.cart,
      name: Routes.cart,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: Routes.profile,
      name: Routes.profile,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: Routes.home,
      name: Routes.home,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
