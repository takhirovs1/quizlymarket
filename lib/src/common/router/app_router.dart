import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/cart/presentation/screen/cart_screen.dart';
import '../../feature/home/presentation/screen/home_screen.dart';
import '../../feature/main/presentation/screen/main_screen.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';
import '../../feature/profile/presentation/screen/profile_screen.dart';
import '../extension/context_extension.dart';
import 'route_arguments.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/',
  redirect: (context, state) {
    final isOnboardingCompleted = context.localSource.onboardingCompleted;

    // Hozirgi URL path (query va hash'larsiz)
    final rawLocation = state.uri.path; // masalan: "/", "/home", "/onboarding"

    // Agar path umuman "/" bilan boshlanmasa (g'alati holat) — onboarding/home ga yuboramiz
    if (!rawLocation.startsWith('/')) {
      return isOnboardingCompleted ? Routes.home : Routes.onboarding;
    }

    // Agar path aynan "/" bo'lsa — onboarding flag bo'yicha tanlaymiz
    if (rawLocation == '/' || rawLocation.isEmpty) {
      return isOnboardingCompleted ? Routes.home : Routes.onboarding;
    }

    // matchedLocation bo'sh bo'lsa ham rawLocation'dan foydalanamiz
    final loc = state.matchedLocation.isEmpty
        ? rawLocation
        : state.matchedLocation;

    final goingToOnboarding = loc == Routes.onboarding;

    // Onboarding tugamagan bo'lsa va boshqa ekranga ketayotgan bo'lsa => /onboarding
    if (!isOnboardingCompleted && !goingToOnboarding) {
      return Routes.onboarding;
    }

    // Onboarding tugagan bo'lsa va user /onboarding ga ketayotgan bo'lsa => /home
    if (isOnboardingCompleted && goingToOnboarding) {
      return Routes.home;
    }

    // Aks holda redirect yo'q
    return null;
  },
  routes: [
    GoRoute(
      path: Routes.onboarding,
      name: Routes.onboarding,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const OnboardingScreen(),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state, navigationShell) =>
          MainScreen(key: state.pageKey, navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          initialLocation: Routes.home,
          routes: [
            GoRoute(
              path: Routes.home,
              name: Routes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.cart,
          routes: [
            GoRoute(
              path: Routes.cart,
              name: Routes.cart,
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.profile,
          routes: [
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
