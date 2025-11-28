import 'package:flutter/material.dart';

@immutable
final class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.white,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.disabled,
    required this.overlay,
    required this.transparent,
    required this.black,
    required this.gray,
  });

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color white;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color disabled;
  final Color overlay;
  final Color transparent;
  final Color black;
  final Color gray;

  static const ThemeColors light = ThemeColors(
    primary: Color(0xFF3772FF),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFE5EBFF),
    onPrimaryContainer: Color(0xFF001244),
    secondary: Color(0xFFFF9F43),
    onSecondary: Color(0xFF241200),
    background: Color(0xFFF7F8FC),
    onBackground: Color(0xFF0C1527),
    surface: Colors.white,
    onSurface: Color(0xFF101623),
    surfaceVariant: Color(0xFFF0F2F7),
    onSurfaceVariant: Color(0xFF566074),
    outline: Color(0xFFD8DCE8),
    outlineVariant: Color(0xFFB9C0D4),
    white: Colors.white,
    success: Color(0xFF17B26A),
    warning: Color(0xFFF79009),
    error: Color(0xFFF04438),
    info: Color(0xFF2E90FA),
    disabled: Color(0xFFC6CBD8),
    overlay: Color(0xAA0C1527),
    transparent: Colors.transparent,
    black: Colors.black,
    gray: Color(0xFF808080),
  );

  static const ThemeColors dark = ThemeColors(
    primary: Color(0xFFA6C4FF),
    onPrimary: Color(0xFF08142C),
    primaryContainer: Color(0xFF21407E),
    onPrimaryContainer: Colors.white,
    secondary: Color(0xFFFFB871),
    onSecondary: Color(0xFF2D1200),
    background: Color(0xFF090F1D),
    onBackground: Color(0xFFF5F6FA),
    surface: Color(0xFF111A2B),
    onSurface: Color(0xFFE8EBF4),
    surfaceVariant: Color(0xFF182338),
    onSurfaceVariant: Color(0xFFA9B4CA),
    outline: Color(0xFF2F3C56),
    outlineVariant: Color(0xFF46526C),
    white: Color(0xFF1C1C1E),
    success: Color(0xFF32D487),
    warning: Color(0xFFF6B458),
    error: Color(0xFFF97066),
    info: Color(0xFF6AB8FF),
    disabled: Color(0xFF4B566E),
    overlay: Color(0xCC040812),
    transparent: Colors.transparent,
    black: Colors.black,
    gray: Color(0xFF808080),
  );

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? white,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? disabled,
    Color? overlay,
    Color? transparent,
    Color? black,
    Color? gray,
  }) => ThemeColors(
    primary: primary ?? this.primary,
    onPrimary: onPrimary ?? this.onPrimary,
    primaryContainer: primaryContainer ?? this.primaryContainer,
    onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
    secondary: secondary ?? this.secondary,
    onSecondary: onSecondary ?? this.onSecondary,
    background: background ?? this.background,
    onBackground: onBackground ?? this.onBackground,
    surface: surface ?? this.surface,
    onSurface: onSurface ?? this.onSurface,
    surfaceVariant: surfaceVariant ?? this.surfaceVariant,
    onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
    outline: outline ?? this.outline,
    outlineVariant: outlineVariant ?? this.outlineVariant,
    white: white ?? this.white,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    error: error ?? this.error,
    info: info ?? this.info,
    disabled: disabled ?? this.disabled,
    overlay: overlay ?? this.overlay,
    transparent: transparent ?? this.transparent,
    black: black ?? this.black,
    gray: gray ?? this.gray,
  );

  @override
  ThemeExtension<ThemeColors> lerp(ThemeExtension<ThemeColors>? other, double t) => other is! ThemeColors
      ? this
      : ThemeColors(
          primary: .lerp(primary, other.primary, t)!,
          onPrimary: .lerp(onPrimary, other.onPrimary, t)!,
          primaryContainer: .lerp(primaryContainer, other.primaryContainer, t)!,
          onPrimaryContainer: .lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
          secondary: .lerp(secondary, other.secondary, t)!,
          onSecondary: .lerp(onSecondary, other.onSecondary, t)!,
          background: .lerp(background, other.background, t)!,
          onBackground: .lerp(onBackground, other.onBackground, t)!,
          surface: .lerp(surface, other.surface, t)!,
          onSurface: .lerp(onSurface, other.onSurface, t)!,
          surfaceVariant: .lerp(surfaceVariant, other.surfaceVariant, t)!,
          onSurfaceVariant: .lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
          outline: .lerp(outline, other.outline, t)!,
          outlineVariant: .lerp(outlineVariant, other.outlineVariant, t)!,
          white: .lerp(white, other.white, t)!,
          success: .lerp(success, other.success, t)!,
          warning: .lerp(warning, other.warning, t)!,
          error: .lerp(error, other.error, t)!,
          info: .lerp(info, other.info, t)!,
          disabled: .lerp(disabled, other.disabled, t)!,
          overlay: .lerp(overlay, other.overlay, t)!,
          transparent: .lerp(transparent, other.transparent, t)!,
          black: .lerp(black, other.black, t)!,
          gray: .lerp(gray, other.gray, t)!,
        );
}
