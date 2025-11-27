import 'package:flutter/material.dart';
import 'package:local_source/local_source.dart';

import '../../../common/constant/gen/fonts.gen.dart';
import '../../../common/theme/theme_data.dart';
import '../models/app_settings.dart';

/// {@template app_settings_repository}
/// [ISettingsRepository] sets and gets app settings.
/// {@endtemplate}
abstract interface class ISettingsRepository {
  const ISettingsRepository();

  /// Set app settings
  Future<void> setSettings(AppSettings settings);

  /// Load [AppSettings] from the source of truth.
  AppSettings getSettings();
}

/// {@macro app_settings_repository}
final class SettingsRepositoryImpl implements ISettingsRepository {
  /// {@macro app_settings_repository}
  const SettingsRepositoryImpl({required this.localSource});

  /// The instance of [LocalSource] used to read and write values.
  final LocalSource localSource;

  @override
  AppSettings getSettings() {
    final localization = localSource.localization;
    final themeMode = localSource.theme;
    final hapticsEnabled = localSource.hapticsEnabled;

    return AppSettings(
      localization: localization,
      appTheme: switch (themeMode == ThemeMode.light) {
        true => AppThemeData.light(FontFamily.workSans),
        false => AppThemeData.dark(FontFamily.workSans),
      },
      hapticsEnabled: hapticsEnabled,
    );
  }

  @override
  Future<void> setSettings(AppSettings settings) async => await Future.wait<void>([
    localSource.setLocalization(settings.localization),
    localSource.setTheme(settings.appTheme.brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark),
    localSource.setHapticsEnabled(enabled: settings.hapticsEnabled),
  ]);
}
