import 'package:elixir/elixir.dart';
import 'package:flutter/material.dart';

import '../../feature/home/presentation/screen/home_screen.dart';
import '../../feature/main/presentation/screen/main_screen.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';
import '../../feature/profile/presentation/screen/profile_screen.dart';
import 'custom_material_route.dart';

/// Type definition for the page.
@immutable
sealed class AppPage extends ElixirPage {
  const AppPage({required super.name, required super.child, super.arguments, super.key});

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppPage && key == other.key;

  @override
  String toString() => '/$name${arguments.isEmpty ? '' : '~$arguments'}';
}

final class MainPage extends AppPage {
  const MainPage() : super(child: const MainScreen(), name: 'main');

  @override
  Set<String> get tags => {'main'};
}

final class OnboardingPage extends AppPage {
  const OnboardingPage() : super(child: const OnboardingScreen(), name: 'onboarding');

  @override
  Set<String> get tags => {'onboarding'};
}

final class HomePage extends AppPage {
  const HomePage() : super(child: const HomeScreen(), name: 'home');

  @override
  Set<String> get tags => {'home'};
}

final class SettingsPage extends AppPage {
  SettingsPage({required final String data})
    : super(
        child: ProfileScreen(data: data),
        name: 'settings', 
      );

  @override
  Route<void> createRoute(BuildContext context) => CustomMaterialRoute(page: this);

  @override
  Set<String> get tags => {'settings'};
}
