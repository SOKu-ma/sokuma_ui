import 'package:flutter/material.dart';

/// 色トークン。
///
/// プライマリ系はアプリごとに `buildAppTheme(seedColor:)` で決まるため、
/// ここにはアプリ間で共通にしたい色だけを置く。
abstract final class AppColors {
  /// seedColor を指定しない場合の既定シード色。
  static const Color defaultSeed = Color(0xFF3F51B5);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color error = Color(0xFFD32F2F);
}
