import 'package:flutter/material.dart';

import '../tokens/sk_colors.dart';

/// アプリで使う [ColorScheme] のプリセット。
abstract final class SkColorSchemes {
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
      error: SkColors.error,
    );
    return primary == null ? scheme : scheme.copyWith(primary: primary);
  }

  static const ColorScheme _light = ColorScheme(
    brightness: Brightness.light,
    primary: SkGrays.ink,
    onPrimary: Colors.white,
    primaryContainer: SkGrays.gray5,
    onPrimaryContainer: SkGrays.ink,
    secondary: SkGrays.inkMuted,
    onSecondary: Colors.white,
    secondaryContainer: SkGrays.gray5,
    onSecondaryContainer: SkGrays.ink,
    tertiary: SkGrays.darkGray3,
    onTertiary: Colors.white,
    tertiaryContainer: SkGrays.gray4,
    onTertiaryContainer: SkGrays.ink,
    error: Color(0xFFFF3B30),
    onError: Colors.white,
    errorContainer: Color(0xFFFFE5E2),
    onErrorContainer: Color(0xFF5C1B16),
    surface: Colors.white,
    onSurface: SkGrays.ink,
    surfaceContainerLowest: Colors.white,
    surfaceContainerLow: Color(0xFFFAFAFC),
    surfaceContainer: SkGrays.gray6,
    surfaceContainerHigh: SkGrays.gray5,
    surfaceContainerHighest: SkGrays.gray4,
    onSurfaceVariant: SkGrays.inkMuted,
    outline: SkGrays.gray3,
    outlineVariant: SkGrays.gray4,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: SkGrays.ink,
    onInverseSurface: SkGrays.gray6,
    inversePrimary: Colors.white,
    surfaceTint: Colors.transparent,
  );

  static const ColorScheme _dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.white,
    onPrimary: Colors.black,
    primaryContainer: SkGrays.darkGray4,
    onPrimaryContainer: SkGrays.gray6,
    secondary: SkGrays.gray2,
    onSecondary: Colors.black,
    secondaryContainer: SkGrays.darkGray4,
    onSecondaryContainer: SkGrays.gray6,
    tertiary: SkGrays.gray,
    onTertiary: Colors.black,
    tertiaryContainer: SkGrays.darkGray3,
    onTertiaryContainer: SkGrays.gray6,
    error: Color(0xFFFF453A),
    onError: Colors.black,
    errorContainer: Color(0xFF5C1E1B),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Colors.black,
    onSurface: SkGrays.gray6,
    surfaceContainerLowest: Colors.black,
    surfaceContainerLow: SkGrays.darkGray6,
    surfaceContainer: SkGrays.darkGray6,
    surfaceContainerHigh: SkGrays.darkGray5,
    surfaceContainerHighest: SkGrays.darkGray4,
    onSurfaceVariant: SkGrays.gray2,
    outline: SkGrays.darkSeparator,
    outlineVariant: Color(0xFF38383A),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: SkGrays.gray6,
    onInverseSurface: SkGrays.ink,
    inversePrimary: SkGrays.ink,
    surfaceTint: Colors.transparent,
  );
}
