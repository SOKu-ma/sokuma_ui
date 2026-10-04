import 'package:flutter/widgets.dart';

/// 角丸トークン。
///
/// 用途の目安:
/// - [sm] 小さなバッジ、リスト内のタイル
/// - [md] ボタン、入力欄、セグメント
/// - [lg] カード、パネル
/// - [xl] ダイアログ、ボトムシート上端
/// - [full] ピル型（チップ、件数バッジ）
abstract final class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;

  static const double full = 999;

  static const BorderRadius xsAll = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlAll = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius fullAll = BorderRadius.all(Radius.circular(full));

  /// ボトムシートの上端だけを丸める。
  static const BorderRadius sheetTop = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
}
