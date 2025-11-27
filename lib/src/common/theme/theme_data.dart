import 'package:flutter/material.dart';

import '../constant/gen/fonts.gen.dart';
import '../widget/cupertino_back/cupertino_back_gesture.dart';
import 'theme_colors.dart';
import 'theme_text_style.dart';

/// {@template theme}
/// App theme data.
/// {@endtemplate}
extension type AppThemeData._(ThemeData data) implements ThemeData {
  /// {@macro theme}
  factory AppThemeData.light(String fontFamily) => AppThemeData._(_appLightTheme(fontFamily));

  /// {@macro theme}
  factory AppThemeData.dark(String fontFamily) => AppThemeData._(_appDarkTheme(fontFamily));
}

/// Extension on [ThemeData] to provide App theme data.
extension AutoThemeExtension on ThemeData {
  /// Returns the App theme colors.
  ThemeColors get appColors =>
      extension<ThemeColors>() ??
      switch (brightness) {
        Brightness.light => ThemeColors.light,
        Brightness.dark => ThemeColors.dark,
      };

  ThemeTextStyles get appTextStyles =>
      extension<ThemeTextStyles>() ??
      switch (brightness) {
        Brightness.light => ThemeTextStyles.light,
        Brightness.dark => ThemeTextStyles.dark,
      };
}

// --- Light Theme --- //

/// Light theme data for the App.
ThemeData _appLightTheme(String fontFamily) => ThemeData(
  fontFamily: fontFamily,
  brightness: Brightness.light,
  useMaterial3: true,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFFD83A88),
    selectionColor: Color.fromARGB(94, 216, 58, 137),
    selectionHandleColor: Color(0xFFD83A88),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
    },
  ),

  scaffoldBackgroundColor: const Color(0xFFFAFAFA),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    surfaceTintColor: Colors.transparent,
    backgroundColor: Color(0xFF03172E),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.black,
      fontFamily: FontFamily.workSans,
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(dragHandleColor: Colors.white, dragHandleSize: Size(40, 4)),
).copyWith(extensions: const <ThemeExtension<Object?>>{ThemeColors.light, ThemeTextStyles.light});

// --- Dark Theme --- //

/// Dark theme data for the App.
ThemeData _appDarkTheme(String fontFamily) => ThemeData(
  fontFamily: fontFamily,
  brightness: Brightness.dark,
  useMaterial3: true,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
    },
  ),
  // pageTransitionsTheme: PageTransitionsTheme(
  //   builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
  //     TargetPlatform.values,
  //     value: (_) => const OpenUpwardsPageTransitionsBuilder(),
  //   ),
  // ),
).copyWith(extensions: const <ThemeExtension<Object?>>{ThemeColors.dark, ThemeTextStyles.dark});
