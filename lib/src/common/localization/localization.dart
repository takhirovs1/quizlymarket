import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'generated/l10n.dart' as generated show AppLocalizationDelegate, GeneratedLocalization;

final class Localization extends generated.GeneratedLocalization {
  Localization._(this.locale);

  final Locale locale;

  String totalTime(int minutes, [int seconds = 0]) {
    final buffer = StringBuffer();

    if (minutes > 0) buffer.write(_minutesLabel(minutes));

    final shouldShowSeconds = seconds > 0 || minutes == 0;
    if (shouldShowSeconds) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(_secondsLabel(seconds));
    }

    return buffer.toString().trim();
  }

  String _minutesLabel(int minutes) {
    final code = locale.languageCode;
    switch (code) {
      case 'ru':
        return Intl.pluralLogic(
          minutes,
          locale: code,
          one: '$minutes минута',
          few: '$minutes минуты',
          many: '$minutes минут',
          other: '$minutes минут',
        );
      case 'uz':
        return Intl.pluralLogic(minutes, locale: code, one: '$minutes daqiqa', other: '$minutes daqiqa');
      default:
        return Intl.pluralLogic(minutes, locale: code, one: '$minutes minute', other: '$minutes minutes');
    }
  }

  String _secondsLabel(int seconds) {
    final code = locale.languageCode;
    switch (code) {
      case 'ru':
        return Intl.pluralLogic(
          seconds,
          locale: code,
          zero: '$seconds секунд',
          one: '$seconds секунда',
          few: '$seconds секунды',
          many: '$seconds секунд',
          other: '$seconds секунд',
        );
      case 'uz':
        return Intl.pluralLogic(
          seconds,
          locale: code,
          zero: '$seconds soniya',
          one: '$seconds soniya',
          other: '$seconds soniya',
        );
      default:
        return Intl.pluralLogic(
          seconds,
          locale: code,
          zero: '$seconds seconds',
          one: '$seconds second',
          other: '$seconds seconds',
        );
    }
  }

  static const LocalizationsDelegate<Localization> delegate = _LocalizationView(generated.AppLocalizationDelegate());

  static Localization get current => _current;
  static late Localization _current;

  static Localization of(BuildContext context) => switch (Localizations.of<Localization>(context, Localization)) {
    final Localization localization => localization,
    _ => throw ArgumentError(
      'Out of scope, not found inherited widget '
          'a Localization of the exact type',
      'out_of_scope',
    ),
  };

  static List<Locale> get supportedLocales => const generated.AppLocalizationDelegate().supportedLocales;

  static List<LocalizationsDelegate<Object?>> get delegates => const <LocalizationsDelegate<Object?>>[
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    Localization.delegate,
  ];
}

class _LocalizationView extends LocalizationsDelegate<Localization> {
  const _LocalizationView(LocalizationsDelegate<generated.GeneratedLocalization> delegate) : _delegate = delegate;

  final LocalizationsDelegate<generated.GeneratedLocalization> _delegate;

  @override
  bool isSupported(Locale locale) => _delegate.isSupported(locale);

  @override
  Future<Localization> load(Locale locale) => generated.GeneratedLocalization.load(
    locale,
  ).then<Localization>((localization) => Localization._current = Localization._(locale));

  @override
  bool shouldReload(covariant _LocalizationView old) => false;
}
