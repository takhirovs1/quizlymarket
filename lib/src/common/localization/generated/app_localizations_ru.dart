// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get noInternetConnection => 'Нет интернет соединения';

  @override
  String get noInternetConnectionDescription => 'Пожалуйста, проверьте ваше интернет соединение и попробуйте снова.';

  @override
  String get refresh => 'Обновить';

  @override
  String get appConfiguration => 'Настройка приложения';

  @override
  String get appConfigurationDescription => 'Настройте ваши настройки приложения здесь.';

  @override
  String get appConfigurationSave => 'Сохранить';

  @override
  String get appConfigurationCancel => 'Отмена';

  @override
  String get appConfigurationReset => 'Сбросить';

  @override
  String get appConfigurationResetDescription => 'Сбросьте ваши настройки приложения на defaults.';

  @override
  String get title => 'Declarative Navigation';
}
