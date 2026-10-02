import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_text_styles.dart';

/// アプリ共通の [ThemeData] を組み立てる。
///
/// [seedColor] でアプリごとにプライマリ系の色を差し替える。
ThemeData buildAppTheme({
  Color seedColor = AppColors.defaultSeed,
  Brightness brightness = Brightness.light,
}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
    error: AppColors.error,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme:
        const TextTheme(
          headlineSmall: AppTextStyles.headline,
          titleMedium: AppTextStyles.title,
          bodyMedium: AppTextStyles.body,
          labelLarge: AppTextStyles.label,
          bodySmall: AppTextStyles.caption,
        ).apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
  );
}
