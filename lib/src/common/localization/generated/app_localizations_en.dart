// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get noInternetConnectionDescription => 'Please check your internet connection and try again.';

  @override
  String get refresh => 'Refresh';

  @override
  String get appConfiguration => 'App Configuration';

  @override
  String get appConfigurationDescription => 'Configure your app settings here.';

  @override
  String get appConfigurationSave => 'Save';

  @override
  String get appConfigurationCancel => 'Cancel';

  @override
  String get appConfigurationReset => 'Reset';

  @override
  String get appConfigurationResetDescription => 'Reset your app settings to default.';

  @override
  String get title => 'Declarative Navigation';
}
