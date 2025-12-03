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
  String get title => 'Quizly Market';

  @override
  String get pressBackAgainToExit => 'Press back again to exit';

  @override
  String get language => 'Change language';

  @override
  String get english => 'English';

  @override
  String get russian => 'Russian';

  @override
  String get uzbek => 'Uzbek';

  @override
  String get report => 'Reports';

  @override
  String get signOut => 'Sign out';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to logout?';

  @override
  String get logoutConfirm => 'Logout';

  @override
  String get logoutCancel => 'Cancel';

  @override
  String get buy => 'Buy';

  @override
  String get appName => 'QuizlyMarket';

  @override
  String get cart => 'Cart';

  @override
  String get testPurchased => 'Test purchased';

  @override
  String get personalizedTestDescription => 'You can start the test customized for you.';

  @override
  String get enterTest => 'Enter test';

  @override
  String get cancel => 'Cancel';

  @override
  String get testPurchasedDescription => 'You can start the test customized for you.';

  @override
  String get testPurchasedTitle => 'Test purchased!';

  @override
  String get test => 'Test';

  @override
  String get startTest => 'Start test';

  @override
  String get parameters => 'Parameters:';

  @override
  String get testModeLabel => 'Test mode:';

  @override
  String get testModeCustom => 'Custom';

  @override
  String get testModeUniversity => 'University';

  @override
  String get testModeQuestionTime => 'How long should it take to answer each question on the test?';

  @override
  String get openTest => 'Open test';

  @override
  String get changeQuestionOrAnswer => 'Should the questions and answer variants be shuffled?';

  @override
  String get shuffleAll => 'Shuffle everything';

  @override
  String get shuffleNone => 'Do not shuffle';

  @override
  String get shuffleQuestions => 'Questions only';

  @override
  String get shuffleAnswers => 'Answers only';

  @override
  String get selectQuestionByRange => 'Select questions by range:';

  @override
  String get allOfTimeTest => 'Total test time:';

  @override
  String questionRangeHint(int count) {
    return '25 questions will rotate out of $count.';
  }

  @override
  String intToCount(int count) {
    return '$count pcs';
  }

  @override
  String get testTotalTime30Min => '30 min';

  @override
  String get testTotalTime1Hour => '1 hour';

  @override
  String get finish => 'Finish';

  @override
  String get question => 'Question:';

  @override
  String get next => 'Next';

  @override
  String get exit => 'Exit';

  @override
  String get correct => 'Correct';

  @override
  String get wrong => 'Wrong';

  @override
  String get skipped => 'Skipped';

  @override
  String get time => 'Time';

  @override
  String get continueAction => 'Continue';
}
