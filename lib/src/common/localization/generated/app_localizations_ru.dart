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
  String get title => 'Quizly Market';

  @override
  String get pressBackAgainToExit => 'Нажмите еще раз, чтобы выйти';

  @override
  String get language => 'Изменить язык';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String get uzbek => 'Узбекский';

  @override
  String get report => 'Отчеты';

  @override
  String get signOut => 'Выход';

  @override
  String get logoutConfirmMessage => 'Вы уверены, что хотите выйти?';

  @override
  String get logoutConfirm => 'Выход';

  @override
  String get logoutCancel => 'Отмена';

  @override
  String get buy => 'Купить';

  @override
  String get appName => 'QuizlyMarket';

  @override
  String get cart => 'Корзина';

  @override
  String get testPurchased => 'Тест приобретен';

  @override
  String get personalizedTestDescription => 'Вы можете начать тест, настроенный под вас.';

  @override
  String get enterTest => 'Перейти к тесту';
}
