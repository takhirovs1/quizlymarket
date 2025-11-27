import 'package:flutter/material.dart';

@immutable
final class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({required this.white, required this.success, required this.error, required this.transparent});

  final Color white;
  final Color success;
  final Color error;
  final Color transparent;

  static const ThemeColors light = ThemeColors(
    white: Colors.white,
    success: Color(0xFF17B26A),
    error: Color(0xFFF04438),
    transparent: Colors.transparent,
  );

  static const ThemeColors dark = ThemeColors(
    white: Color(0xFF1C1C1E),
    success: Color(0xFF17B26A),
    error: Color(0xFFF04438),
    transparent: Colors.transparent,
  );

  @override
  ThemeExtension<ThemeColors> copyWith({Color? white, Color? success, Color? error, Color? transparent}) => ThemeColors(
    white: white ?? this.white,
    success: success ?? this.success,
    error: error ?? this.error,
    transparent: transparent ?? this.transparent,
  );

  @override
  ThemeExtension<ThemeColors> lerp(ThemeExtension<ThemeColors>? other, double t) => other is! ThemeColors
      ? this
      : ThemeColors(
          white: Color.lerp(white, other.white, t)!,
          success: Color.lerp(success, other.success, t)!,
          error: Color.lerp(error, other.error, t)!,
          transparent: Color.lerp(transparent, other.transparent, t)!,
        );
}
