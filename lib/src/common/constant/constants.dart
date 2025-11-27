import 'dart:io' show Platform;

sealed class Constants {
  const Constants._();

  static final appLink = Platform.isIOS ? 'https://www.apple.com/app-store/' : 'https://play.google.com/store/';
  static const packageName = '';

  static const defaultPageSize = 30;

  static const loremIpsum =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

  static const loremShort = 'Lorem ipsum dolor sit amet.';
}
