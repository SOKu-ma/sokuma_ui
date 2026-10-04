import 'package:flutter/material.dart';

/// 色トークン。
///
/// プライマリ系はアプリごとに `buildAppTheme` で決まるため、
/// ここにはアプリ間で共通にしたい意味色だけを置く。
abstract final class AppColors {
  /// seedColor を指定しない場合の既定シード色。
  static const Color defaultSeed = Color(0xFF3F51B5);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color error = Color(0xFFD32F2F);

  /// 有料機能の CTA・バッジに使うゴールド。
  static const Color premiumGoldLight = Color(0xFFE2C16C);
  static const Color premiumGoldDeep = Color(0xFFC49A42);

  /// ゴールドの上に載せる文字色。
  static const Color onPremiumGold = Color(0xFF14263D);

  static const LinearGradient premiumGoldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [premiumGoldLight, premiumGoldDeep],
  );
}

/// iOS のシステムグレーに合わせたグレースケール。
///
/// モノクロ基調のアプリ（[AppColorSchemes.monochrome]）の土台になる。
/// 数字が小さいほど背景側（ライトでは明るく、ダークでは暗い）。
abstract final class AppGrays {
  /// ライトでの最も濃い文字色。
  static const Color ink = Color(0xFF1C1C1E);

  /// ライトでの補助文字色（iOS の secondaryLabel 相当）。
  static const Color inkMuted = Color(0xFF636366);

  static const Color gray6 = Color(0xFFF2F2F7);
  static const Color gray5 = Color(0xFFE5E5EA);
  static const Color gray4 = Color(0xFFD1D1D6);
  static const Color gray3 = Color(0xFFC7C7CC);
  static const Color gray2 = Color(0xFFAEAEB2);
  static const Color gray = Color(0xFF8E8E93);

  static const Color darkGray6 = Color(0xFF1C1C1E);
  static const Color darkGray5 = Color(0xFF2C2C2E);
  static const Color darkGray4 = Color(0xFF3A3A3C);
  static const Color darkGray3 = Color(0xFF48484A);
  static const Color darkGray2 = Color(0xFF636366);

  /// ダークでの区切り線。
  static const Color darkSeparator = Color(0xFF545458);
}
