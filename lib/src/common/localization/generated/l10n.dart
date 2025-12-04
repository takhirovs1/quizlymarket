// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class GeneratedLocalization {
  GeneratedLocalization();

  static GeneratedLocalization? _current;

  static GeneratedLocalization get current {
    assert(
      _current != null,
      'No instance of GeneratedLocalization was loaded. Try to initialize the GeneratedLocalization delegate before accessing GeneratedLocalization.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<GeneratedLocalization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = GeneratedLocalization();
      GeneratedLocalization._current = instance;

      return instance;
    });
  }

  static GeneratedLocalization of(BuildContext context) {
    final instance = GeneratedLocalization.maybeOf(context);
    assert(
      instance != null,
      'No instance of GeneratedLocalization present in the widget tree. Did you add GeneratedLocalization.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static GeneratedLocalization? maybeOf(BuildContext context) {
    return Localizations.of<GeneratedLocalization>(
      context,
      GeneratedLocalization,
    );
  }

  /// `Нет интернет соединения`
  String get noInternetConnection {
    return Intl.message(
      'Нет интернет соединения',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста, проверьте ваше интернет соединение и попробуйте снова.`
  String get noInternetConnectionDescription {
    return Intl.message(
      'Пожалуйста, проверьте ваше интернет соединение и попробуйте снова.',
      name: 'noInternetConnectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Обновить`
  String get refresh {
    return Intl.message('Обновить', name: 'refresh', desc: '', args: []);
  }

  /// `Настройка приложения`
  String get appConfiguration {
    return Intl.message(
      'Настройка приложения',
      name: 'appConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Настройте ваши настройки приложения здесь.`
  String get appConfigurationDescription {
    return Intl.message(
      'Настройте ваши настройки приложения здесь.',
      name: 'appConfigurationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get appConfigurationSave {
    return Intl.message(
      'Сохранить',
      name: 'appConfigurationSave',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get appConfigurationCancel {
    return Intl.message(
      'Отмена',
      name: 'appConfigurationCancel',
      desc: '',
      args: [],
    );
  }

  /// `Сбросить`
  String get appConfigurationReset {
    return Intl.message(
      'Сбросить',
      name: 'appConfigurationReset',
      desc: '',
      args: [],
    );
  }

  /// `Сбросьте ваши настройки приложения на defaults.`
  String get appConfigurationResetDescription {
    return Intl.message(
      'Сбросьте ваши настройки приложения на defaults.',
      name: 'appConfigurationResetDescription',
      desc: '',
      args: [],
    );
  }

  /// `Quizly Market`
  String get title {
    return Intl.message('Quizly Market', name: 'title', desc: '', args: []);
  }

  /// `Нажмите еще раз, чтобы выйти`
  String get pressBackAgainToExit {
    return Intl.message(
      'Нажмите еще раз, чтобы выйти',
      name: 'pressBackAgainToExit',
      desc: '',
      args: [],
    );
  }

  /// `Изменить язык`
  String get language {
    return Intl.message('Изменить язык', name: 'language', desc: '', args: []);
  }

  /// `Английский`
  String get english {
    return Intl.message('Английский', name: 'english', desc: '', args: []);
  }

  /// `Русский`
  String get russian {
    return Intl.message('Русский', name: 'russian', desc: '', args: []);
  }

  /// `Узбекский`
  String get uzbek {
    return Intl.message('Узбекский', name: 'uzbek', desc: '', args: []);
  }

  /// `Отчеты`
  String get report {
    return Intl.message('Отчеты', name: 'report', desc: '', args: []);
  }

  /// `Выход`
  String get signOut {
    return Intl.message('Выход', name: 'signOut', desc: '', args: []);
  }

  /// `Вы уверены, что хотите выйти?`
  String get logoutConfirmMessage {
    return Intl.message(
      'Вы уверены, что хотите выйти?',
      name: 'logoutConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Выход`
  String get logoutConfirm {
    return Intl.message('Выход', name: 'logoutConfirm', desc: '', args: []);
  }

  /// `Отмена`
  String get logoutCancel {
    return Intl.message('Отмена', name: 'logoutCancel', desc: '', args: []);
  }

  /// `Купить`
  String get buy {
    return Intl.message('Купить', name: 'buy', desc: '', args: []);
  }

  /// `QuizlyMarket`
  String get appName {
    return Intl.message('QuizlyMarket', name: 'appName', desc: '', args: []);
  }

  /// `Корзина`
  String get cart {
    return Intl.message('Корзина', name: 'cart', desc: '', args: []);
  }

  /// `Тест приобретен`
  String get testPurchased {
    return Intl.message(
      'Тест приобретен',
      name: 'testPurchased',
      desc: '',
      args: [],
    );
  }

  /// `Вы можете начать тест, настроенный под вас.`
  String get personalizedTestDescription {
    return Intl.message(
      'Вы можете начать тест, настроенный под вас.',
      name: 'personalizedTestDescription',
      desc: '',
      args: [],
    );
  }

  /// `Перейти к тесту`
  String get enterTest {
    return Intl.message(
      'Перейти к тесту',
      name: 'enterTest',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancel {
    return Intl.message('Отмена', name: 'cancel', desc: '', args: []);
  }

  /// `Вы можете начать тест, настроенный под вас.`
  String get testPurchasedDescription {
    return Intl.message(
      'Вы можете начать тест, настроенный под вас.',
      name: 'testPurchasedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Тест приобретен!`
  String get testPurchasedTitle {
    return Intl.message(
      'Тест приобретен!',
      name: 'testPurchasedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Тест`
  String get test {
    return Intl.message('Тест', name: 'test', desc: '', args: []);
  }

  /// `Начать тест`
  String get startTest {
    return Intl.message('Начать тест', name: 'startTest', desc: '', args: []);
  }

  /// `Параметры:`
  String get parameters {
    return Intl.message('Параметры:', name: 'parameters', desc: '', args: []);
  }

  /// `Режим теста:`
  String get testModeLabel {
    return Intl.message(
      'Режим теста:',
      name: 'testModeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Индивидуальный`
  String get testModeCustom {
    return Intl.message(
      'Индивидуальный',
      name: 'testModeCustom',
      desc: '',
      args: [],
    );
  }

  /// `Университет`
  String get testModeUniversity {
    return Intl.message(
      'Университет',
      name: 'testModeUniversity',
      desc: '',
      args: [],
    );
  }

  /// `Сколько времени должно занять ответ на каждый вопрос теста?`
  String get testModeQuestionTime {
    return Intl.message(
      'Сколько времени должно занять ответ на каждый вопрос теста?',
      name: 'testModeQuestionTime',
      desc: '',
      args: [],
    );
  }

  /// `Открыть тест`
  String get openTest {
    return Intl.message('Открыть тест', name: 'openTest', desc: '', args: []);
  }

  /// `Следует ли перемешать вопросы и варианты ответов?`
  String get changeQuestionOrAnswer {
    return Intl.message(
      'Следует ли перемешать вопросы и варианты ответов?',
      name: 'changeQuestionOrAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Перемешать всё`
  String get shuffleAll {
    return Intl.message(
      'Перемешать всё',
      name: 'shuffleAll',
      desc: '',
      args: [],
    );
  }

  /// `Не перемешивать`
  String get shuffleNone {
    return Intl.message(
      'Не перемешивать',
      name: 'shuffleNone',
      desc: '',
      args: [],
    );
  }

  /// `Только вопросы`
  String get shuffleQuestions {
    return Intl.message(
      'Только вопросы',
      name: 'shuffleQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Только ответы`
  String get shuffleAnswers {
    return Intl.message(
      'Только ответы',
      name: 'shuffleAnswers',
      desc: '',
      args: [],
    );
  }

  /// `Выберите вопросы по диапазону:`
  String get selectQuestionByRange {
    return Intl.message(
      'Выберите вопросы по диапазону:',
      name: 'selectQuestionByRange',
      desc: '',
      args: [],
    );
  }

  /// `Общее время теста:`
  String get allOfTimeTest {
    return Intl.message(
      'Общее время теста:',
      name: 'allOfTimeTest',
      desc: '',
      args: [],
    );
  }

  /// `Из {count} вопросов {solved} будут перемешиваться.`
  String questionRangeHint(int count, int solved) {
    return Intl.message(
      'Из $count вопросов $solved будут перемешиваться.',
      name: 'questionRangeHint',
      desc: '',
      args: [count, solved],
    );
  }

  /// `{count} шт.`
  String intToCount(int count) {
    return Intl.message(
      '$count шт.',
      name: 'intToCount',
      desc: '',
      args: [count],
    );
  }

  /// `Добавить в домашний экран`
  String get addToHomeScreenApp {
    return Intl.message('Добавить в домашний экран', name: 'addToHomeScreenApp', desc: '', args: []);
  }

  /// `30 минут`
  String get testTotalTime30Min {
    return Intl.message(
      '30 минут',
      name: 'testTotalTime30Min',
      desc: '',
      args: [],
    );
  }

  /// `1 час`
  String get testTotalTime1Hour {
    return Intl.message(
      '1 час',
      name: 'testTotalTime1Hour',
      desc: '',
      args: [],
    );
  }

  /// `Завершить`
  String get finish {
    return Intl.message('Завершить', name: 'finish', desc: '', args: []);
  }

  /// `Вопрос:`
  String get question {
    return Intl.message('Вопрос:', name: 'question', desc: '', args: []);
  }

  /// `Следующий`
  String get next {
    return Intl.message('Следующий', name: 'next', desc: '', args: []);
  }

  /// `Выход`
  String get exit {
    return Intl.message('Выход', name: 'exit', desc: '', args: []);
  }

  /// `Продолжить`
  String get continueAction {
    return Intl.message(
      'Продолжить',
      name: 'continueAction',
      desc: '',
      args: [],
    );
  }

  /// `Правильно`
  String get correct {
    return Intl.message('Правильно', name: 'correct', desc: '', args: []);
  }

  /// `Неправильно`
  String get wrong {
    return Intl.message('Неправильно', name: 'wrong', desc: '', args: []);
  }

  /// `Пропущено`
  String get skipped {
    return Intl.message('Пропущено', name: 'skipped', desc: '', args: []);
  }

  /// `Время`
  String get time {
    return Intl.message('Время', name: 'time', desc: '', args: []);
  }

  /// `Поиск`
  String get search {
    return Intl.message('Поиск', name: 'search', desc: '', args: []);
  }

  /// `Фильтр`
  String get filter {
    return Intl.message('Фильтр', name: 'filter', desc: '', args: []);
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<GeneratedLocalization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<GeneratedLocalization> load(Locale locale) =>
      GeneratedLocalization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
