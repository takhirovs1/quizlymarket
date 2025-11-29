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
