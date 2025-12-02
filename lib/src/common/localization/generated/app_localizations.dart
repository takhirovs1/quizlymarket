import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('ru'), Locale('uz')];

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @noInternetConnectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get noInternetConnectionDescription;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @appConfiguration.
  ///
  /// In en, this message translates to:
  /// **'App Configuration'**
  String get appConfiguration;

  /// No description provided for @appConfigurationDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure your app settings here.'**
  String get appConfigurationDescription;

  /// No description provided for @appConfigurationSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get appConfigurationSave;

  /// No description provided for @appConfigurationCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get appConfigurationCancel;

  /// No description provided for @appConfigurationReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get appConfigurationReset;

  /// No description provided for @appConfigurationResetDescription.
  ///
  /// In en, this message translates to:
  /// **'Reset your app settings to default.'**
  String get appConfigurationResetDescription;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Quizly Market'**
  String get title;

  /// No description provided for @pressBackAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get pressBackAgainToExit;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @uzbek.
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get uzbek;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get report;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmMessage;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutConfirm;

  /// No description provided for @logoutCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get logoutCancel;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'QuizlyMarket'**
  String get appName;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @testPurchased.
  ///
  /// In en, this message translates to:
  /// **'Test purchased'**
  String get testPurchased;

  /// No description provided for @personalizedTestDescription.
  ///
  /// In en, this message translates to:
  /// **'You can start the test customized for you.'**
  String get personalizedTestDescription;

  /// No description provided for @enterTest.
  ///
  /// In en, this message translates to:
  /// **'Enter test'**
  String get enterTest;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @testPurchasedDescription.
  ///
  /// In en, this message translates to:
  /// **'You can start the test customized for you.'**
  String get testPurchasedDescription;

  /// No description provided for @testPurchasedTitle.
  ///
  /// In en, this message translates to:
  /// **'Test purchased!'**
  String get testPurchasedTitle;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @startTest.
  ///
  /// In en, this message translates to:
  /// **'Start test'**
  String get startTest;

  /// No description provided for @parameters.
  ///
  /// In en, this message translates to:
  /// **'Parameters:'**
  String get parameters;

  /// No description provided for @testModeLabel.
  ///
  /// In en, this message translates to:
  /// **'Test mode:'**
  String get testModeLabel;

  /// No description provided for @testModeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get testModeCustom;

  /// No description provided for @testModeUniversity.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get testModeUniversity;

  /// No description provided for @testModeQuestionTime.
  ///
  /// In en, this message translates to:
  /// **'How long should it take to answer each question on the test?'**
  String get testModeQuestionTime;

  /// No description provided for @openTest.
  ///
  /// In en, this message translates to:
  /// **'Open test'**
  String get openTest;

  /// No description provided for @changeQuestionOrAnswer.
  ///
  /// In en, this message translates to:
  /// **'Should the questions and answer variants be shuffled?'**
  String get changeQuestionOrAnswer;

  /// No description provided for @shuffleAll.
  ///
  /// In en, this message translates to:
  /// **'Shuffle everything'**
  String get shuffleAll;

  /// No description provided for @shuffleNone.
  ///
  /// In en, this message translates to:
  /// **'Do not shuffle'**
  String get shuffleNone;

  /// No description provided for @shuffleQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions only'**
  String get shuffleQuestions;

  /// No description provided for @shuffleAnswers.
  ///
  /// In en, this message translates to:
  /// **'Answers only'**
  String get shuffleAnswers;

  /// No description provided for @selectQuestionByRange.
  ///
  /// In en, this message translates to:
  /// **'Select questions by range:'**
  String get selectQuestionByRange;

  /// No description provided for @allOfTimeTest.
  ///
  /// In en, this message translates to:
  /// **'Total test time:'**
  String get allOfTimeTest;

  /// No description provided for @questionRangeHint.
  ///
  /// In en, this message translates to:
  /// **'{count} questions will rotate out of {count}.'**
  String questionRangeHint(int count);

  /// No description provided for @testTotalTime30Min.
  ///
  /// In en, this message translates to:
  /// **'30 min'**
  String get testTotalTime30Min;

  /// No description provided for @testTotalTime1Hour.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get testTotalTime1Hour;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
