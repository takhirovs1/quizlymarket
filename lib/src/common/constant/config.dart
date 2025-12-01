import 'dart:developer';

import 'package:meta/meta.dart';

/// Config for app.
@immutable
final class Config {
  const Config._({
    required this.environment,
    required this.apiBaseUrl,
    required this.isInitializationDone,
    required this.thunderEnabled,
    required this.octopusToolsEnabled,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  });
  // --- INITIALIZATION --- //
  factory Config._initialize({
    String environment = const String.fromEnvironment('ENVIRONMENT', defaultValue: 'development'),
    String apiBaseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: ''),
    bool isInitializationDone = false,
    bool thunderEnabled = false,
    bool octopusToolsEnabled = false,
    String supabaseUrl = const String.fromEnvironment('SUPABASE_URL', defaultValue: ''),
    String supabaseAnonKey = const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: ''),
  }) {
    final config = Config._(
      environment: EnvironmentFlavor.from(environment),
      apiBaseUrl: apiBaseUrl,
      isInitializationDone: isInitializationDone,
      thunderEnabled: thunderEnabled,
      octopusToolsEnabled: octopusToolsEnabled,
      supabaseUrl: supabaseUrl,
      supabaseAnonKey: supabaseAnonKey,
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
    String? supabaseUrl,
    String? supabaseAnonKey,
  }) {
    final config = Config._(
      environment: environment ?? (_currentConfig?.environment ?? EnvironmentFlavor.development),
      apiBaseUrl: apiBaseUrl ?? (_currentConfig?.apiBaseUrl ?? ''),
      isInitializationDone: isInitializationDone ?? (_currentConfig?.isInitializationDone ?? false),
      thunderEnabled: thunderEnabled ?? (_currentConfig?.thunderEnabled ?? false),
      octopusToolsEnabled: octopusToolsEnabled ?? (_currentConfig?.octopusToolsEnabled ?? false),
      supabaseUrl: supabaseUrl ?? (_currentConfig?.supabaseUrl ?? ''),
      supabaseAnonKey: supabaseAnonKey ?? (_currentConfig?.supabaseAnonKey ?? ''),
    );

    log('Config.copyWith: $config', name: 'Config');

    _currentConfig = config;

    return config;
  }

  // ignore: prefer_constructors_over_static_methods
  static Config get current => _currentConfig ?? Config._initialize();

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

  // --- SUPABASE --- //
  final String supabaseUrl;
  final String supabaseAnonKey;

  // --- EQUALITY & TO STRING --- //
  @override
  bool operator ==(Object other) {
    if (other is Config) {
      return environment == other.environment &&
          apiBaseUrl == other.apiBaseUrl &&
          thunderEnabled == other.thunderEnabled &&
          octopusToolsEnabled == other.octopusToolsEnabled &&
          isInitializationDone == other.isInitializationDone &&
          supabaseUrl == other.supabaseUrl &&
          supabaseAnonKey == other.supabaseAnonKey;
    }
    return false;
  }

  @override
  int get hashCode =>
      environment.hashCode ^
      apiBaseUrl.hashCode ^
      thunderEnabled.hashCode ^
      octopusToolsEnabled.hashCode ^
      isInitializationDone.hashCode ^
      supabaseUrl.hashCode ^
      supabaseAnonKey.hashCode;

  @override
  String toString() =>
      '''Config(environment: $environment, apiBaseUrl: $apiBaseUrl, thunderEnabled: $thunderEnabled, octopusToolsEnabled: $octopusToolsEnabled,isInitializationDone: $isInitializationDone, supabaseUrl: $supabaseUrl, supabaseAnonKey: $supabaseAnonKey)''';
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
