import 'package:flutter/material.dart';

sealed class Dimension {
  const Dimension._();

  static const _kIsIos = String.fromEnvironment('config.platform', defaultValue: '') == 'ios';

  // Default heights
  static const defaultButtonHeight = 40.0;
  static const defaultInputHeight = 50;
  static const bottomSheetMaxWidth = 700;
  static const profileItemHeight = 50;
  static const localeItemHeight = 52;
  static const defaultSwitchHeight = 32;

  // Dividers
  static const Divider divider = Divider(thickness: 1, height: 0, color: Color(0xFFD6D8DD));

  // Shadows
  static List<BoxShadow> get whiteBlackShadows => [
    const BoxShadow(
      blurRadius: 0,
      spreadRadius: 0,
      blurStyle: BlurStyle.normal,
      offset: Offset(0, -1),
      color: Color.fromARGB(63, 255, 255, 255),
    ),
    const BoxShadow(
      blurRadius: 0,
      spreadRadius: 0,
      offset: Offset(0, 1),
      blurStyle: BlurStyle.normal,
      color: Color.fromARGB(63, 0, 0, 0),
    ),
  ];

  // Spacer
  static const kSpacer = Spacer();

  // Padding
  static const defaultPaddingH = 16.0;
  static const defaultPaddingV = 16.0;

  // All Padding Constants
  static const pAll32 = EdgeInsets.all(32);
  static const pAll42 = EdgeInsets.all(42);
  static const pAll24 = EdgeInsets.all(24);
  static const pAll20 = EdgeInsets.all(20);
  static const pAll16 = EdgeInsets.all(16);
  static const pAll10 = EdgeInsets.all(10);
  static const pAll12 = EdgeInsets.all(12);
  static const pAll14 = EdgeInsets.all(14);
  static const pAll8 = EdgeInsets.all(8);
  static const pAll6 = EdgeInsets.all(6);
  static const pAll4 = EdgeInsets.all(4);
  static const pAll3 = EdgeInsets.all(3);
  static const pAll2 = EdgeInsets.all(2);
  static const pAll1 = EdgeInsets.all(1);
  static const pZero = EdgeInsets.zero;

  static const pBottom2 = EdgeInsets.only(bottom: 2);
  static const pBottom4 = EdgeInsets.only(bottom: 4);
  static const pBottom8 = EdgeInsets.only(bottom: 8);

  static const pTop4Bottom8 = EdgeInsets.only(top: 4, bottom: 8);
  static const pTop18Bottom12 = EdgeInsets.only(bottom: 12, top: 18);

  static const pBottom10 = EdgeInsets.only(bottom: 10);
  static const pBottom12 = EdgeInsets.only(bottom: 12);
  static const pBottom16 = EdgeInsets.only(bottom: 16);
  static const pBottom20 = EdgeInsets.only(bottom: 20);
  static const pBottom24 = EdgeInsets.only(bottom: 24);
  static const pBottom30 = EdgeInsets.only(bottom: 30);
  static const pBottom32 = EdgeInsets.only(bottom: 32);
  static const pBottom40 = EdgeInsets.only(bottom: 40);
  static const pBottom54 = EdgeInsets.only(bottom: 54);
  static const pBottom60 = EdgeInsets.only(bottom: 60);

  // Symmetric Paddings
  static const pV1H4 = EdgeInsets.symmetric(vertical: 1, horizontal: 4);
  static const pV2H4 = EdgeInsets.symmetric(vertical: 2, horizontal: 4);
  static const pV4H8 = EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  static const pV5H10 = EdgeInsets.symmetric(vertical: 5, horizontal: 10);
  static const pV12H4 = EdgeInsets.symmetric(vertical: 12, horizontal: 4);
  static const pV12H16 = EdgeInsets.symmetric(vertical: 12, horizontal: 16);
  static const pV4H12 = EdgeInsets.symmetric(vertical: 4, horizontal: 12);
  static const pV4H16 = EdgeInsets.symmetric(vertical: 4, horizontal: 16);
  static const pV4H20 = EdgeInsets.symmetric(vertical: 4, horizontal: 20);
  static const pV20H16 = EdgeInsets.symmetric(vertical: 20, horizontal: 16);
  static const pV24H20 = EdgeInsets.symmetric(vertical: 24, horizontal: 20);
  static const pV24H32 = EdgeInsets.symmetric(vertical: 24, horizontal: 32);
  static const pV8H16 = EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const pV10H16 = EdgeInsets.symmetric(vertical: 10, horizontal: 16);
  static const pH12V4 = EdgeInsets.symmetric(vertical: 4, horizontal: 12);
  static const pH12V8 = EdgeInsets.symmetric(vertical: 8, horizontal: 12);
  static const pH12V16 = EdgeInsets.symmetric(vertical: 16, horizontal: 12);
  static const pV4Left12Right4 = EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 4);

  static const pH8V10 = EdgeInsets.symmetric(vertical: 10, horizontal: 8);
  static const pV6H12 = EdgeInsets.symmetric(vertical: 6, horizontal: 12);
  static const pV16H20 = EdgeInsets.symmetric(vertical: 16, horizontal: 20);
  static const pV16H14 = EdgeInsets.symmetric(vertical: 16, horizontal: 14);
  static const pV18H16 = EdgeInsets.symmetric(vertical: 18, horizontal: 16);
  static const pV2H8 = EdgeInsets.symmetric(vertical: 3, horizontal: 8);
  static const pV10H12 = EdgeInsets.symmetric(vertical: 10, horizontal: 12);
  static const pV12H20 = EdgeInsets.symmetric(vertical: 12, horizontal: 20);
  static const pV14H16 = EdgeInsets.symmetric(vertical: 14, horizontal: 16);
  static const pV14H20 = EdgeInsets.symmetric(vertical: 14, horizontal: 20);
  static const pV36H16 = EdgeInsets.symmetric(vertical: 36, horizontal: 16);
  static const pV36H24 = EdgeInsets.symmetric(vertical: 36, horizontal: 24);
  static const pV24H16 = EdgeInsets.symmetric(vertical: 24, horizontal: 16);

  static const pV56H16 = EdgeInsets.symmetric(vertical: 56, horizontal: 16);
  static const pH4V2 = EdgeInsets.symmetric(vertical: 2, horizontal: 4);
  static const pH6V2 = EdgeInsets.symmetric(vertical: 2, horizontal: 6);
  static const pH6V4 = EdgeInsets.symmetric(vertical: 4, horizontal: 6);
  static const pH8V2 = EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  static const pH16V2 = EdgeInsets.symmetric(vertical: 2, horizontal: 16);
  static const pH10V4 = EdgeInsets.symmetric(vertical: 4, horizontal: 10);
  static const pH10V6 = EdgeInsets.symmetric(vertical: 6, horizontal: 10);
  static const pH10V12 = EdgeInsets.symmetric(vertical: 12, horizontal: 10);
  static const pH16V4 = EdgeInsets.symmetric(vertical: 4, horizontal: 16);
  static const pH8V4 = EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  static const pH8V3 = EdgeInsets.symmetric(vertical: 3, horizontal: 8);
  static const pH8V6 = EdgeInsets.symmetric(vertical: 6, horizontal: 8);
  static const pH16V8 = EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const pH14V12 = EdgeInsets.symmetric(vertical: 12, horizontal: 14);
  static const pH16V12 = EdgeInsets.symmetric(vertical: 12, horizontal: 16);
  static const pH16V20 = EdgeInsets.symmetric(vertical: 20, horizontal: 16);
  static const pH16V6 = EdgeInsets.symmetric(vertical: 6, horizontal: 16);
  static const pH16V24 = EdgeInsets.symmetric(vertical: 24, horizontal: 16);
  static const pH16V32 = EdgeInsets.symmetric(vertical: 32, horizontal: 16);
  static const pV6 = EdgeInsets.symmetric(vertical: 6);
  static const pV2 = EdgeInsets.symmetric(vertical: 2);
  static const pV4 = EdgeInsets.symmetric(vertical: 4);
  static const pV8 = EdgeInsets.symmetric(vertical: 8);
  static const pV10 = EdgeInsets.symmetric(vertical: 10);
  static const pV12 = EdgeInsets.symmetric(vertical: 12);
  static const pV16 = EdgeInsets.symmetric(vertical: 16);
  static const pV20 = EdgeInsets.symmetric(vertical: 20);
  static const pV24 = EdgeInsets.symmetric(vertical: 24);
  static const pV30 = EdgeInsets.symmetric(vertical: 30);
  static const pV32 = EdgeInsets.symmetric(vertical: 32);
  static const pV40 = EdgeInsets.symmetric(vertical: 40);
  static const pV48 = EdgeInsets.symmetric(vertical: 48);

  static const pH2 = EdgeInsets.symmetric(horizontal: 2);
  static const pH4 = EdgeInsets.symmetric(horizontal: 4);
  static const pH6 = EdgeInsets.symmetric(horizontal: 6);
  static const pH8 = EdgeInsets.symmetric(horizontal: 8);
  static const pH10 = EdgeInsets.symmetric(horizontal: 10);
  static const pH12 = EdgeInsets.symmetric(horizontal: 12);
  static const pH14 = EdgeInsets.symmetric(horizontal: 14);
  static const pH16 = EdgeInsets.symmetric(horizontal: 16);
  static const pH20 = EdgeInsets.symmetric(horizontal: 20);
  static const pH24 = EdgeInsets.symmetric(horizontal: 24);
  static const pH32 = EdgeInsets.symmetric(horizontal: 32);
  static const pH64 = EdgeInsets.symmetric(horizontal: 64);

  static const pTop1 = EdgeInsets.only(top: .1);
  static const pTop4 = EdgeInsets.only(top: 4);
  static const pTop6 = EdgeInsets.only(top: 6);
  static const pTop8 = EdgeInsets.only(top: 8);
  static const pTop12 = EdgeInsets.only(top: 12);
  static const pTop10 = EdgeInsets.only(top: 10);
  static const pTop14 = EdgeInsets.only(top: 14);
  static const pTop16 = EdgeInsets.only(top: 16);
  static const pTop20 = EdgeInsets.only(top: 20);
  static const pTop24 = EdgeInsets.only(top: 24);
  static const pTop30 = EdgeInsets.only(top: 30);
  static const pTop32 = EdgeInsets.only(top: 32);
  static const pTop36 = EdgeInsets.only(top: 36);
  static const pTop40 = EdgeInsets.only(top: 40);
  static const pTop100 = EdgeInsets.only(top: 100);
  static const pTop8Left4 = EdgeInsets.only(top: 8, left: 4);
  static const pTop4Left16 = EdgeInsets.only(top: 4, left: 16);
  static const pTop4Right8 = EdgeInsets.only(top: 4, right: 8);
  static const pTop10Left8 = EdgeInsets.only(top: 10, left: 8);
  static const pTop12Left22 = EdgeInsets.only(top: 12, left: 22);
  static const pTop16Bottom8 = EdgeInsets.only(top: 16, bottom: 8);
  static const pLeft16Right12 = EdgeInsets.only(left: 16, right: 12);
  static const pH16Top12 = EdgeInsets.only(left: 16, right: 16, top: 12);
  static const pH16Top16 = EdgeInsets.only(left: 16, right: 16, top: 16);
  static const pH16Top16Bottom4 = EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4);
  static const pH16Top16Bottom32 = EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32);
  static const pLeft16Right16Bottom8 = EdgeInsets.only(left: 16, right: 16, bottom: 8);
  static const pLeft16Right16Bottom24 = EdgeInsets.only(left: 16, right: 16, bottom: 24);
  static const pTop24Bottom12 = EdgeInsets.only(bottom: 12, top: 24);
  static const pTop24Bottom12H16 = EdgeInsets.only(top: 24, right: 16, left: 16, bottom: 12);
  static const pTop54Bottom12H16 = EdgeInsets.only(top: 54, right: 16, left: 16, bottom: 20);
  static const pTop26H16 = EdgeInsets.only(top: 26, right: 16, left: 16, bottom: 8);
  static const pTop8H8 = EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 10);
  static const pTop30H24 = EdgeInsets.only(top: 30, right: 24, left: 24, bottom: 24);
  static const pBottom16H24 = EdgeInsets.only(bottom: 16, right: 24, left: 24);
  static const pBottom10H8 = EdgeInsets.only(bottom: 10, right: 8, left: 8);
  static const pBottom16H8 = EdgeInsets.only(bottom: 16, right: 8, left: 8);
  static const pBottomLeft12 = EdgeInsets.only(bottom: 12, left: 12);
  static const pBottom16Left16 = EdgeInsets.only(bottom: 16, left: 16);
  static const pBottom16Right8 = EdgeInsets.only(bottom: 16, right: 8);
  static const pH12Bottom12 = EdgeInsets.only(right: 12, left: 12, bottom: 12);
  static const pH16Bottom12 = EdgeInsets.only(right: 16, left: 16, bottom: 12);
  static const pH16Bottom20Top12 = EdgeInsets.only(right: 16, left: 16, bottom: 20, top: 12);
  static const pH16Bottom24Top12 = EdgeInsets.only(right: 16, left: 16, bottom: 24, top: 12);
  static const pH16Bottom20 = EdgeInsets.only(right: 16, left: 16, bottom: 20);
  static const pH16Bottom24 = EdgeInsets.only(right: 16, left: 16, bottom: 24);
  static const pH16Bottom4 = EdgeInsets.only(right: 16, left: 16, bottom: 4);
  static const pH16Bottom16 = EdgeInsets.only(right: 16, left: 16, bottom: 16);
  static const pH16Bottom28 = EdgeInsets.only(right: 16, left: 16, bottom: 28);
  static const pH16Top24Bottom6 = EdgeInsets.only(right: 16, left: 16, bottom: 6, top: 24);
  static const pH16Top8Bottom6 = EdgeInsets.only(right: 16, left: 16, bottom: 6, top: 8);
  static const pTop16H16 = EdgeInsets.only(top: 16, right: 16, left: 16);
  static const pBottom16H16 = EdgeInsets.only(bottom: 16, right: 16, left: 16);

  static const pTop4H24 = EdgeInsets.only(top: 4, right: 24, left: 24);
  static const pTop24H16 = EdgeInsets.only(top: 24, right: 16, left: 16);
  static const pTop20Bottom10 = EdgeInsets.only(top: 20, bottom: 10);
  static const pTop10Bottom20 = EdgeInsets.only(top: 10, bottom: 20);
  static const pTop16Bottom12 = EdgeInsets.only(top: 16, bottom: 12);
  static const pTop32Bottom8 = EdgeInsets.only(top: 32, bottom: 8);
  static const pTop12Bottom32 = EdgeInsets.only(bottom: 32, top: 12);
  static const pTop12Bottom8 = EdgeInsets.only(bottom: 4, top: 12);
  static const pTop8Bottom16 = EdgeInsets.only(bottom: 16, top: 8);
  static const pV14Left16Right8 = EdgeInsets.only(bottom: 14, top: 13.6, left: 16, right: 8);
  static const pTop8Bottom16H16 = EdgeInsets.only(bottom: 16, top: 8, right: 16, left: 16);
  static const pV4Right6 = EdgeInsets.only(bottom: 8, top: 8, right: 8);

  static const pBottom40H24 = EdgeInsets.only(bottom: 40, right: 24, left: 24);

  static const pLeft4 = EdgeInsets.only(left: 4);
  static const pLeft8 = EdgeInsets.only(left: 8);
  static const pLeft12 = EdgeInsets.only(left: 12);
  static const pLeft16 = EdgeInsets.only(left: 16);
  static const pLeft20 = EdgeInsets.only(left: 20);
  static const pLeft32 = EdgeInsets.only(left: 32);
  static const pRight12 = EdgeInsets.only(right: 12);
  static const pRight2 = EdgeInsets.only(right: 2);
  static const pRight4 = EdgeInsets.only(right: 4);
  static const pRight6 = EdgeInsets.only(right: 6);
  static const pRight8 = EdgeInsets.only(right: 8);
  static const pRight16 = EdgeInsets.only(right: 16);
  static const pRight22 = EdgeInsets.only(right: 22);
  static const pRight32 = EdgeInsets.only(right: 32);
  static const pRight56 = EdgeInsets.only(right: 56);
  static const pLeft12Right8 = EdgeInsets.only(left: 12, right: 8);
  static const pLeft8Right16Top16 = EdgeInsets.only(left: 6, right: 16, top: 4);
  static const pLeft16Right4V16 = EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 4);
  static const pLeft24Right12TB18 = EdgeInsets.only(left: 24, top: 18, bottom: 18, right: 12);
  static const pLeft8Right8TB16 = EdgeInsets.only(left: 8, top: 16, bottom: 12, right: 8);

  // Platform-specific Padding
  static EdgeInsets pV16Top16Bottom32iOSx16Android = _kIsIos ? pH16Top16Bottom32 : pAll16;
  static EdgeInsets pTop16Bottom32iOSx16Android = _kIsIos ? const EdgeInsets.only(top: 16, bottom: 32) : pV16;

  static EdgeInsets pH16Top16BottomViewInsets(BuildContext context) =>
      EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.viewInsetsOf(context).bottom + (_kIsIos ? 32 : 16));

  static EdgeInsets pH16Top0BottomViewInsets(BuildContext context) =>
      EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.viewInsetsOf(context).bottom);

  // Vertical Spacings
  static const hBox2 = SizedBox(height: 2);
  static const hBox4 = SizedBox(height: 4);
  static const hBox6 = SizedBox(height: 6);
  static const hBox8 = SizedBox(height: 8);
  static const hBox10 = SizedBox(height: 10);
  static const hBox12 = SizedBox(height: 12);
  static const hBox14 = SizedBox(height: 14);
  static const hBox16 = SizedBox(height: 16);
  static const hBox22 = SizedBox(height: 22);
  static const hBox20 = SizedBox(height: 20);
  static const hBox24 = SizedBox(height: 24);
  static const hBox28 = SizedBox(height: 28);
  static const hBox30 = SizedBox(height: 30);
  static const hBox32 = SizedBox(height: 32);
  static const hBox36 = SizedBox(height: 36);
  static const hBox40 = SizedBox(height: 40);
  static const hBox48 = SizedBox(height: 48);
  static const hBox50 = SizedBox(height: 50);
  static const hBox54 = SizedBox(height: 54);
  static const hBox64 = SizedBox(height: 64);
  static const hBox80 = SizedBox(height: 80);
  static const hBox100 = SizedBox(height: 100);
  static SizedBox hBox16Androidx32iOS = const SizedBox(height: _kIsIos ? 32 : 16);
  static SizedBox hBox8Androidx12iOS = const SizedBox(height: _kIsIos ? 12 : 8);

  // Horizontal Spacings
  static const wBox4 = SizedBox(width: 4);
  static const wBox6 = SizedBox(width: 6);
  static const wBox8 = SizedBox(width: 8);
  static const wBox10 = SizedBox(width: 10);
  static const wBox12 = SizedBox(width: 12);
  static const wBox14 = SizedBox(width: 14);
  static const wBox16 = SizedBox(width: 16);
  static const wBox20 = SizedBox(width: 20);
  static const wBox22 = SizedBox(width: 22);
  static const wBox24 = SizedBox(width: 24);
  static const wBox32 = SizedBox(width: 32);
  static const zeroSpace = SizedBox.shrink();

  // Border Radius
  static const rAll0 = BorderRadius.zero;
  static const rAll2 = BorderRadius.all(Radius.circular(2));
  static const rAll4 = BorderRadius.all(Radius.circular(4));
  static const rAll6 = BorderRadius.all(Radius.circular(6));
  static const rAll8 = BorderRadius.all(Radius.circular(8));
  static const rAll10 = BorderRadius.all(Radius.circular(10));
  static const rAll12 = BorderRadius.all(Radius.circular(12));
  static const rAll18 = BorderRadius.all(Radius.circular(18));
  static const rAll16 = BorderRadius.all(Radius.circular(16));
  static const rAll20 = BorderRadius.all(Radius.circular(20));
  static const rAll24 = BorderRadius.all(Radius.circular(24));
  static const rAll26 = BorderRadius.all(Radius.circular(26));
  static const rAll28 = BorderRadius.all(Radius.circular(28));
  static const rAll32 = BorderRadius.all(Radius.circular(32));
  static const rAll36 = BorderRadius.all(Radius.circular(36));
  static const rAll40 = BorderRadius.all(Radius.circular(40));
  static const rAll44 = BorderRadius.all(Radius.circular(44));
  static const rAll48 = BorderRadius.all(Radius.circular(48));
  static const rAll56 = BorderRadius.all(Radius.circular(56));
  static const rAll64 = BorderRadius.all(Radius.circular(64));

  // Specific Border Radius
  static const rLeft4 = BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4));
  static const rTop2 = BorderRadius.only(topLeft: Radius.circular(2), topRight: Radius.circular(2));
  static const rTop4 = BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4));
  static const rTop8 = BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8));
  static const rTop10 = BorderRadius.vertical(top: Radius.circular(10));
  static const rTop12 = BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12));
  static const rTop16 = BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16));
  static const rTop24 = BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24));
  static const rRight4 = BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4));
  static const rRight8 = BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8));
  static const rLeft8 = BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8));
  static const rRight24 = BorderRadius.only(topRight: Radius.circular(24), bottomRight: Radius.circular(24));
  static const rBottom8 = BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8));
  static const rBottom16 = BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16));
}
