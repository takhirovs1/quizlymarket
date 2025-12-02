// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get noInternetConnection => 'Internet mavjud emas';

  @override
  String get noInternetConnectionDescription => 'Iltimos, internet ulanishini tekshirib yana urinib ko‘ring.';

  @override
  String get refresh => 'Yangilash';

  @override
  String get appConfiguration => 'Ilova sozlamalari';

  @override
  String get appConfigurationDescription => 'Ilova sozlamalarini shu yerda sozlang.';

  @override
  String get appConfigurationSave => 'Saqlash';

  @override
  String get appConfigurationCancel => 'Bekor qilish';

  @override
  String get appConfigurationReset => 'Tiklash';

  @override
  String get appConfigurationResetDescription => 'Ilova sozlamalarini sukut bo‘yicha tiklang.';

  @override
  String get title => 'Quizly Market';

  @override
  String get pressBackAgainToExit => 'Chiqish uchun yana bir marta bosing';

  @override
  String get language => 'Tilni o‘zgartirish';

  @override
  String get english => 'Ingliz tili';

  @override
  String get russian => 'Rus tili';

  @override
  String get uzbek => 'O‘zbek tili';

  @override
  String get report => 'Hisobotlar';

  @override
  String get signOut => 'Chiqish';

  @override
  String get logoutConfirmMessage => 'Chiqishni tasdiqlaysizmi?';

  @override
  String get logoutConfirm => 'Chiqish';

  @override
  String get logoutCancel => 'Bekor qilish';

  @override
  String get buy => 'Sotib olish';

  @override
  String get appName => 'QuizlyMarket';

  @override
  String get cart => 'Savat';

  @override
  String get testPurchased => 'Test sotib olindi';

  @override
  String get personalizedTestDescription => 'Testni o‘zingizga moslab boshlashingiz mumkin.';

  @override
  String get enterTest => 'Testga kirish';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get testPurchasedDescription => 'Testni o‘zingizga moslab boshlashingiz mumkin.';

  @override
  String get testPurchasedTitle => 'Test sotib olindi!';

  @override
  String get test => 'Test';

  @override
  String get startTest => 'Testni boshlash';

  @override
  String get parameters => 'Parametrlar:';

  @override
  String get testModeLabel => 'Test rejimi:';

  @override
  String get testModeCustom => 'Moslashtirilgan';

  @override
  String get testModeUniversity => 'Universitet';

  @override
  String get testModeQuestionTime => 'Testda har bir savolga javob berish uchun qancha vaqt ketishi kerak?';

  @override
  String get openTest => 'Testga kirish';

  @override
  String get changeQuestionOrAnswer => 'Savollar va javob variantlari aralashtirilsinmi?';

  @override
  String get shuffleAll => 'Barchasini aralashtirish';

  @override
  String get shuffleNone => 'Aralashtirilmasin';

  @override
  String get shuffleQuestions => 'Faqat savollar';

  @override
  String get shuffleAnswers => 'Faqat javoblar';

  @override
  String get selectQuestionByRange => 'Savollarni oraliq bo‘yicha tanlash:';

  @override
  String get allOfTimeTest => 'Testning umumiy vaqti:';

  @override
  String questionRangeHint(int count) {
    return '$count ta savoldan 25 tasi almashib tushadi.';
  }

  @override
  String get testTotalTime30Min => '30 daqiqa';

  @override
  String get testTotalTime1Hour => '1 soat';

  @override
  String get correct => 'Toʻgʻri';

  @override
  String get wrong => 'Xato';

  @override
  String get skipped => 'Tashlab ketilgan';

  @override
  String get time => 'Vaqt';

  @override
  String get continueAction => 'Davom etish';
}
