import 'package:flutter/material.dart';

import '../tokens/sk_colors.dart';
import '../tokens/sk_radius.dart';
import '../tokens/sk_spacing.dart';
import '../tokens/sk_text_styles.dart';
import 'sk_color_schemes.dart';

/// アプリ共通の [ThemeData] を組み立てる。
///
/// 配色は次のどちらかで決める。
/// - [colorScheme] を渡す（例: `SkColorSchemes.monochrome(brightness)`）
/// - [seedColor] と [brightness] からシード配色を作る
///
/// 部品のテーマ（ボタン・入力欄・カード・シート・スナックバーなど）は
/// どの配色でも同じ形・余白になるようここで揃える。アプリ固有の調整は
/// 戻り値に `copyWith` で重ねる。
ThemeData buildSkTheme({
  Color seedColor = SkColors.defaultSeed,
  Brightness brightness = Brightness.light,
  ColorScheme? colorScheme,
  Color? scaffoldBackgroundColor,
}) {
  final scheme =
      colorScheme ?? SkColorSchemes.seeded(seedColor, brightness: brightness);
  final background = scaffoldBackgroundColor ?? scheme.surfaceContainer;
  final textTheme = _textTheme(scheme);
  const buttonShape = RoundedRectangleBorder(borderRadius: SkRadius.mdAll);
  const buttonPadding = EdgeInsets.symmetric(
    horizontal: SkSpacing.xl,
    vertical: SkSpacing.md,
  );
  final buttonText = SkTextStyles.label.copyWith(fontWeight: FontWeight.w700);

  OutlineInputBorder inputBorder(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: SkRadius.mdAll,
        borderSide: BorderSide(color: color, width: width),
      );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: background,
    canvasColor: background,
    dividerColor: scheme.outlineVariant,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: scheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: SkRadius.lgAll,
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: SkRadius.xlAll),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: scheme.surface,
      modalBackgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      dragHandleColor: scheme.outline,
      shape: const RoundedRectangleBorder(borderRadius: SkRadius.sheetTop),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
        shape: buttonShape,
        padding: buttonPadding,
        textStyle: buttonText,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.onSurface,
        side: BorderSide(color: scheme.outline),
        shape: buttonShape,
        padding: buttonPadding,
        textStyle: buttonText,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: scheme.primary,
        shape: buttonShape,
        textStyle: buttonText,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      shape: const RoundedRectangleBorder(borderRadius: SkRadius.lgAll),
    ),
    // 選択中は塗りで示すので、チェックマークは出さない。
    chipTheme: const ChipThemeData(showCheckmark: false),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: scheme.primary,
        selectedForegroundColor: scheme.onPrimary,
        shape: buttonShape,
        textStyle: buttonText,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: SkSpacing.lg,
        vertical: SkSpacing.md,
      ),
      border: inputBorder(scheme.outlineVariant),
      enabledBorder: inputBorder(scheme.outlineVariant),
      focusedBorder: inputBorder(scheme.primary, 1.5),
      errorBorder: inputBorder(scheme.error),
      focusedErrorBorder: inputBorder(scheme.error, 1.5),
      labelStyle: TextStyle(color: scheme.onSurfaceVariant),
      hintStyle: TextStyle(color: scheme.onSurfaceVariant),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: scheme.secondaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 12,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: scheme.inverseSurface,
      contentTextStyle: SkTextStyles.label.copyWith(
        color: scheme.onInverseSurface,
      ),
      actionTextColor: scheme.inversePrimary,
      shape: const RoundedRectangleBorder(borderRadius: SkRadius.mdAll),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: scheme.onSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: SkSpacing.lg),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: scheme.primary,
      linearTrackColor: scheme.surfaceContainerHighest,
    ),
  );
}

TextTheme _textTheme(ColorScheme scheme) {
  return const TextTheme(
    headlineSmall: SkTextStyles.headline,
    titleMedium: SkTextStyles.title,
    titleSmall: SkTextStyles.subtitle,
    bodyMedium: SkTextStyles.body,
    labelLarge: SkTextStyles.label,
    bodySmall: SkTextStyles.caption,
  ).apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
}
