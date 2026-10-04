import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sokuma_ui/sokuma_ui.dart';

void main() {
  group('AppColorSchemes.monochrome', () {
    test('ライトは黒、ダークは白がプライマリ', () {
      expect(
        AppColorSchemes.monochrome(Brightness.light).primary,
        AppGrays.ink,
      );
      expect(AppColorSchemes.monochrome(Brightness.dark).primary, Colors.white);
    });

    test('brightness が一致する', () {
      for (final b in Brightness.values) {
        expect(AppColorSchemes.monochrome(b).brightness, b);
      }
    });
  });

  group('buildAppTheme', () {
    test('colorScheme を渡すとそれを使う', () {
      final scheme = AppColorSchemes.monochrome(Brightness.dark);
      final theme = buildAppTheme(colorScheme: scheme);
      expect(theme.colorScheme, scheme);
      expect(theme.brightness, Brightness.dark);
      expect(theme.scaffoldBackgroundColor, scheme.surfaceContainer);
    });

    test('scaffoldBackgroundColor を上書きできる', () {
      final theme = buildAppTheme(scaffoldBackgroundColor: Colors.pink);
      expect(theme.scaffoldBackgroundColor, Colors.pink);
    });

    test('部品の形はトークンにそろう', () {
      final theme = buildAppTheme();
      expect(
        theme.dialogTheme.shape,
        const RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      );
      expect(theme.chipTheme.showCheckmark, isFalse);
      expect(theme.snackBarTheme.behavior, SnackBarBehavior.floating);
      expect(theme.cardTheme.elevation, 0);
    });

    test('seeded で primary を固定できる', () {
      const navy = Color(0xFF0C2340);
      final scheme = AppColorSchemes.seeded(navy, primary: navy);
      expect(scheme.primary, navy);
    });
  });
}
