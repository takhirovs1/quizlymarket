import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart' as generated show GeneratedLocalization, AppLocalizationDelegate;

final class Localization extends generated.GeneratedLocalization {
  Localization._(this.locale);

  final Locale locale;

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
