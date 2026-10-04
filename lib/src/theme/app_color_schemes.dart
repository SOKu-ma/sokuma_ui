import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';

/// アプリで使う [ColorScheme] のプリセット。
abstract final class AppColorSchemes {
  /// iOS のシステムグレーを土台にしたモノクロ配色。
  ///
  /// プライマリは黒（ダークでは白）で、色味は意味色やアプリ固有の
  /// アクセントだけに使う前提。
  static ColorScheme monochrome(Brightness brightness) {
    return brightness == Brightness.light ? _light : _dark;
  }

  /// シード色から作る配色。[primary] を渡すとプライマリだけ固定できる。
  static ColorScheme seeded(
    Color seedColor, {
    Brightness brightness = Brightness.light,
    Color? primary,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
      error: AppColors.error,
    );
    return primary == null ? scheme : scheme.copyWith(primary: primary);
  }

  static const ColorScheme _light = ColorScheme(
    brightness: Brightness.light,
    primary: AppGrays.ink,
    onPrimary: Colors.white,
    primaryContainer: AppGrays.gray5,
    onPrimaryContainer: AppGrays.ink,
    secondary: AppGrays.inkMuted,
    onSecondary: Colors.white,
    secondaryContainer: AppGrays.gray5,
    onSecondaryContainer: AppGrays.ink,
    tertiary: AppGrays.darkGray3,
    onTertiary: Colors.white,
    tertiaryContainer: AppGrays.gray4,
    onTertiaryContainer: AppGrays.ink,
    error: Color(0xFFFF3B30),
    onError: Colors.white,
    errorContainer: Color(0xFFFFE5E2),
    onErrorContainer: Color(0xFF5C1B16),
    surface: Colors.white,
    onSurface: AppGrays.ink,
    surfaceContainerLowest: Colors.white,
    surfaceContainerLow: Color(0xFFFAFAFC),
    surfaceContainer: AppGrays.gray6,
    surfaceContainerHigh: AppGrays.gray5,
    surfaceContainerHighest: AppGrays.gray4,
    onSurfaceVariant: AppGrays.inkMuted,
    outline: AppGrays.gray3,
    outlineVariant: AppGrays.gray4,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: AppGrays.ink,
    onInverseSurface: AppGrays.gray6,
    inversePrimary: Colors.white,
    surfaceTint: Colors.transparent,
  );

  static const ColorScheme _dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.white,
    onPrimary: Colors.black,
    primaryContainer: AppGrays.darkGray4,
    onPrimaryContainer: AppGrays.gray6,
    secondary: AppGrays.gray2,
    onSecondary: Colors.black,
    secondaryContainer: AppGrays.darkGray4,
    onSecondaryContainer: AppGrays.gray6,
    tertiary: AppGrays.gray,
    onTertiary: Colors.black,
    tertiaryContainer: AppGrays.darkGray3,
    onTertiaryContainer: AppGrays.gray6,
    error: Color(0xFFFF453A),
    onError: Colors.black,
    errorContainer: Color(0xFF5C1E1B),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Colors.black,
    onSurface: AppGrays.gray6,
    surfaceContainerLowest: Colors.black,
    surfaceContainerLow: AppGrays.darkGray6,
    surfaceContainer: AppGrays.darkGray6,
    surfaceContainerHigh: AppGrays.darkGray5,
    surfaceContainerHighest: AppGrays.darkGray4,
    onSurfaceVariant: AppGrays.gray2,
    outline: AppGrays.darkSeparator,
    outlineVariant: Color(0xFF38383A),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: AppGrays.gray6,
    onInverseSurface: AppGrays.ink,
    inversePrimary: AppGrays.ink,
    surfaceTint: Colors.transparent,
  );
}
