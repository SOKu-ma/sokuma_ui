import 'package:flutter/material.dart';

import '../tokens/sk_spacing.dart';

/// アプリ共通のスナックバー。
///
/// 見た目は `buildSkTheme` の snackBarTheme に従う。表示中のものは
/// 消してから出すので、連続で呼んでも積み上がらない。
abstract final class SkSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context,
    String message, {
    IconData? icon,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    return showWithMessenger(
      ScaffoldMessenger.of(context),
      message,
      icon: icon,
      action: action,
      duration: duration,
    );
  }

  /// `context` が使えない場面（非同期処理の後など）向け。
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showWithMessenger(
    ScaffoldMessengerState messenger,
    String message, {
    IconData? icon,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    messenger.clearSnackBars();
    return messenger.showSnackBar(
      SnackBar(
        content: icon == null
            ? Text(message)
            : Row(
                children: [
                  Icon(icon, size: 20, color: _foreground(messenger.context)),
                  const SizedBox(width: SkSpacing.md),
                  Expanded(child: Text(message)),
                ],
              ),
        action: action,
        duration: duration,
      ),
    );
  }

  static Color? _foreground(BuildContext context) {
    final theme = Theme.of(context);
    return theme.snackBarTheme.contentTextStyle?.color ??
        theme.colorScheme.onInverseSurface;
  }
}
