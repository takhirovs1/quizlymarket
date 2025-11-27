import 'dart:developer';

import 'package:meta/meta.dart';

/// Config for app.
@immutable
final class Config {
  // --- INITIALIZATION --- //
  factory Config._initialize({
    String environment = const String.fromEnvironment('ENVIRONMENT', defaultValue: 'development'),
    String apiBaseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: ''),
    bool isInitializationDone = false,
    bool thunderEnabled = false,
    bool octopusToolsEnabled = false,
  }) {
    final config = Config._(
      environment: EnvironmentFlavor.from(environment),
      apiBaseUrl: apiBaseUrl,
      isInitializationDone: isInitializationDone,
      thunderEnabled: thunderEnabled,
      octopusToolsEnabled: octopusToolsEnabled,
    );

    _currentConfig = config;

    return config;
  }

  factory Config.copyWith({
    EnvironmentFlavor? environment,
    String? apiBaseUrl,
    bool? isInitializationDone,
    bool? thunderEnabled,
    bool? octopusToolsEnabled,
  }) {
    final config = Config._(
      environment: environment ?? (_currentConfig?.environment ?? EnvironmentFlavor.development),
      apiBaseUrl: apiBaseUrl ?? (_currentConfig?.apiBaseUrl ?? ''),
      isInitializationDone: isInitializationDone ?? (_currentConfig?.isInitializationDone ?? false),
      thunderEnabled: thunderEnabled ?? (_currentConfig?.thunderEnabled ?? false),
      octopusToolsEnabled: octopusToolsEnabled ?? (_currentConfig?.octopusToolsEnabled ?? false),
    );

    log('Config.copyWith: $config', name: 'Config');

    _currentConfig = config;

    return config;
  }

  factory Config.current() => _currentConfig ?? Config._initialize();

  const Config._({
    required this.environment,
    required this.apiBaseUrl,
    required this.isInitializationDone,
    required this.thunderEnabled,
    required this.octopusToolsEnabled,
  });

  static Config? _currentConfig;
  // --- *END INITIALIZATION* --- //

  // --- ENVIRONMENT --- //
  final EnvironmentFlavor environment;

  // --- API --- //
  final String apiBaseUrl;

  // --- THUNDER --- //
  final bool thunderEnabled;

  // --- OCTOPUS TOOLS --- //
  final bool octopusToolsEnabled;

  // --- INITIALIZATION CHECK --- //
  final bool isInitializationDone;

  // --- EQUALITY & TO STRING --- //
  @override
  bool operator ==(Object other) {
    if (other is Config) {
      return environment == other.environment &&
          apiBaseUrl == other.apiBaseUrl &&
          thunderEnabled == other.thunderEnabled &&
          octopusToolsEnabled == other.octopusToolsEnabled &&
          isInitializationDone == other.isInitializationDone;
    }
    return false;
  }

  @override
  int get hashCode =>
      environment.hashCode ^
      apiBaseUrl.hashCode ^
      thunderEnabled.hashCode ^
      octopusToolsEnabled.hashCode ^
      isInitializationDone.hashCode;

  @override
  String toString() =>
      '''Config(environment: $environment, apiBaseUrl: $apiBaseUrl, thunderEnabled: $thunderEnabled, octopusToolsEnabled: $octopusToolsEnabled,isInitializationDone: $isInitializationDone)''';
}

/// Environment flavor.
/// e.g. development, staging, production
enum EnvironmentFlavor {
  /// Development
  development('development'),

  /// Staging
  staging('staging'),

  /// Production
  production('production');

  /// Create environment flavor.
  const EnvironmentFlavor(this.value);

  /// Create environment flavor from string.
  factory EnvironmentFlavor.from(String? value) => switch (value?.trim().toLowerCase()) {
    'development' || 'debug' || 'develop' || 'dev' => development,
    'staging' || 'profile' || 'stage' || 'stg' => staging,
    'production' || 'release' || 'prod' || 'prd' => production,
    _ => const bool.fromEnvironment('dart.vm.product') ? production : development,
  };

  /// development, staging, production
  final String value;

  /// Whether the environment is development.
  bool get isDevelopment => this == development;

  /// Whether the environment is staging.
  bool get isStaging => this == staging;

  /// Whether the environment is production.
  bool get isProduction => this == production;
}
