import 'package:flutter/widgets.dart';

/// 文字スタイルトークン。
///
/// 色は持たない（テーマの ColorScheme から付与される）。
abstract final class AppTextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    height: 1.3,
    letterSpacing: -0.3,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  /// セクション見出しなど、本文より一段強い小見出し。
  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// 成績・スコアなどの数値。桁がそろうよう等幅数字にする。
  static const TextStyle numeric = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    height: 1.2,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}
