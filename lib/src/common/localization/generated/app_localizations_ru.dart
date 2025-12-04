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

  @override
  String get cancel => 'Отмена';

  @override
  String get testPurchasedDescription => 'Вы можете начать тест, настроенный под вас.';

  @override
  String get testPurchasedTitle => 'Тест приобретен!';

  @override
  String get test => 'Тест';

  @override
  String get startTest => 'Начать тест';

  @override
  String get parameters => 'Параметры:';

  @override
  String get testModeLabel => 'Режим теста:';

  @override
  String get testModeCustom => 'Индивидуальный';

  @override
  String get testModeUniversity => 'Университет';

  @override
  String get testModeQuestionTime => 'Сколько времени должно занять ответ на каждый вопрос теста?';

  @override
  String get openTest => 'Открыть тест';

  @override
  String get changeQuestionOrAnswer => 'Следует ли перемешать вопросы и варианты ответов?';

  @override
  String get shuffleAll => 'Перемешать всё';

  @override
  String get shuffleNone => 'Не перемешивать';

  @override
  String get shuffleQuestions => 'Только вопросы';

  @override
  String get shuffleAnswers => 'Только ответы';

  @override
  String get selectQuestionByRange => 'Выберите вопросы по диапазону:';

  @override
  String get allOfTimeTest => 'Общее время теста:';

  @override
  String questionRangeHint(int count, int solved) {
    return 'Из $count вопросов $solved будут перемешиваться.';
  }

  @override
  String intToCount(int count) {
    return '$count шт.';
  }

  @override
  String get upload => 'Загрузка';

  @override
  String get statistics => 'Статистика';

  @override
  String get topUp => 'Пополнить баланс пользователя';

  @override
  String get withdraw => 'Вывести баланс';

  @override
  String get userList => 'Список пользователей';

  @override
  String get addToHomeScreenApp => 'Добавить в домашний экран';

  @override
  String get testTotalTime30Min => '30 минут';

  @override
  String get testTotalTime1Hour => '1 час';

  @override
  String get finish => 'Завершить';

  @override
  String get question => 'Вопрос:';

  @override
  String get next => 'Следующий';

  @override
  String get exit => 'Выход';

  @override
  String get correct => 'Правильно';

  @override
  String get wrong => 'Неправильно';

  @override
  String get skipped => 'Пропущено';

  @override
  String get time => 'Время';

  @override
  String get continueAction => 'Продолжить';

  @override
  String get search => 'Поиск';

  @override
  String get filter => 'Фильтр';
}
