import 'package:flutter/widgets.dart';

/// 角丸トークン。
abstract final class AppRadius {
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 16;

  /// ピル型（チップなど）。
  static const double full = 999;

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius fullAll = BorderRadius.all(Radius.circular(full));
}
