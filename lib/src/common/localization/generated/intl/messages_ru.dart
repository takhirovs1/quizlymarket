// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(count) => "${count} шт.";

  static String m1(count, solved) => "Из ${count} вопросов ${solved} будут перемешиваться.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("Добавить"),
    "addToHomeScreenApp": MessageLookupByLibrary.simpleMessage("Добавить в домашний экран"),
    "admin": MessageLookupByLibrary.simpleMessage("Admin"),
    "allOfTimeTest": MessageLookupByLibrary.simpleMessage("Общее время теста:"),
    "amount": MessageLookupByLibrary.simpleMessage("Сумма"),
    "appConfiguration": MessageLookupByLibrary.simpleMessage("Настройка приложения"),
    "appConfigurationCancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "appConfigurationDescription": MessageLookupByLibrary.simpleMessage("Настройте ваши настройки приложения здесь."),
    "appConfigurationReset": MessageLookupByLibrary.simpleMessage("Сбросить"),
    "appConfigurationResetDescription": MessageLookupByLibrary.simpleMessage(
      "Сбросьте ваши настройки приложения на defaults.",
    ),
    "appConfigurationSave": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "appName": MessageLookupByLibrary.simpleMessage("QuizlyMarket"),
    "buy": MessageLookupByLibrary.simpleMessage("Купить"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cardID": MessageLookupByLibrary.simpleMessage("ID карты"),
    "cart": MessageLookupByLibrary.simpleMessage("Корзина"),
    "changeQuestionOrAnswer": MessageLookupByLibrary.simpleMessage("Следует ли перемешать вопросы и варианты ответов?"),
    "continueAction": MessageLookupByLibrary.simpleMessage("Продолжить"),
    "correct": MessageLookupByLibrary.simpleMessage("Правильно"),
    "english": MessageLookupByLibrary.simpleMessage("Английский"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Сумму введите"),
    "enterTest": MessageLookupByLibrary.simpleMessage("Перейти к тесту"),
    "exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
    "finish": MessageLookupByLibrary.simpleMessage("Завершить"),
    "intToCount": m0,
    "language": MessageLookupByLibrary.simpleMessage("Изменить язык"),
    "logoutCancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage("Выход"),
    "logoutConfirmMessage": MessageLookupByLibrary.simpleMessage("Вы уверены, что хотите выйти?"),
    "next": MessageLookupByLibrary.simpleMessage("Следующий"),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage("Нет интернет соединения"),
    "noInternetConnectionDescription": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, проверьте ваше интернет соединение и попробуйте снова.",
    ),
    "noUsersFound": MessageLookupByLibrary.simpleMessage("Пользователь не найден"),
    "openTest": MessageLookupByLibrary.simpleMessage("Открыть тест"),
    "parameters": MessageLookupByLibrary.simpleMessage("Параметры:"),
    "personalizedTestDescription": MessageLookupByLibrary.simpleMessage("Вы можете начать тест, настроенный под вас."),
    "pressBackAgainToExit": MessageLookupByLibrary.simpleMessage("Нажмите еще раз, чтобы выйти"),
    "question": MessageLookupByLibrary.simpleMessage("Вопрос:"),
    "questionRangeHint": m1,
    "refresh": MessageLookupByLibrary.simpleMessage("Обновить"),
    "report": MessageLookupByLibrary.simpleMessage("Отчеты"),
    "russian": MessageLookupByLibrary.simpleMessage("Русский"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "selectQuestionByRange": MessageLookupByLibrary.simpleMessage("Выберите вопросы по диапазону:"),
    "shuffleAll": MessageLookupByLibrary.simpleMessage("Перемешать всё"),
    "shuffleAnswers": MessageLookupByLibrary.simpleMessage("Только ответы"),
    "shuffleNone": MessageLookupByLibrary.simpleMessage("Не перемешивать"),
    "shuffleQuestions": MessageLookupByLibrary.simpleMessage("Только вопросы"),
    "signOut": MessageLookupByLibrary.simpleMessage("Выход"),
    "skipped": MessageLookupByLibrary.simpleMessage("Пропущено"),
    "startTest": MessageLookupByLibrary.simpleMessage("Начать тест"),
    "statistics": MessageLookupByLibrary.simpleMessage("Статистика"),
    "test": MessageLookupByLibrary.simpleMessage("Тест"),
    "testModeCustom": MessageLookupByLibrary.simpleMessage("Индивидуальный"),
    "testModeLabel": MessageLookupByLibrary.simpleMessage("Режим теста:"),
    "testModeQuestionTime": MessageLookupByLibrary.simpleMessage(
      "Сколько времени должно занять ответ на каждый вопрос теста?",
    ),
    "testModeUniversity": MessageLookupByLibrary.simpleMessage("Университет"),
    "testPurchased": MessageLookupByLibrary.simpleMessage("Тест приобретен"),
    "testPurchasedDescription": MessageLookupByLibrary.simpleMessage("Вы можете начать тест, настроенный под вас."),
    "testPurchasedTitle": MessageLookupByLibrary.simpleMessage("Тест приобретен!"),
    "testTotalTime1Hour": MessageLookupByLibrary.simpleMessage("1 час"),
    "testTotalTime30Min": MessageLookupByLibrary.simpleMessage("30 минут"),
    "time": MessageLookupByLibrary.simpleMessage("Время"),
    "title": MessageLookupByLibrary.simpleMessage("Quizly Market"),
    "topUp": MessageLookupByLibrary.simpleMessage("Пополнить баланс пользователя"),
    "topUpUserBalance": MessageLookupByLibrary.simpleMessage("Пополнить баланс"),
    "unknownError": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "upload": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "user": MessageLookupByLibrary.simpleMessage("Студент"),
    "userList": MessageLookupByLibrary.simpleMessage("Список пользователей"),
    "userRole": MessageLookupByLibrary.simpleMessage("Роль пользователя:"),
    "users": MessageLookupByLibrary.simpleMessage("Пользователи"),
    "uzbek": MessageLookupByLibrary.simpleMessage("Узбекский"),
    "withdraw": MessageLookupByLibrary.simpleMessage("Вывести баланс"),
    "wrong": MessageLookupByLibrary.simpleMessage("Неправильно"),
  };
}
