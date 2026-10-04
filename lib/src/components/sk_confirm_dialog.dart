import 'package:flutter/material.dart';

/// 「はい / いいえ」で確認するダイアログを出し、確定したら true を返す。
///
/// ボタンの文言を省略すると Material の多言語ラベル（OK / キャンセル）を使う。
/// [destructive] が true のときは確定ボタンをエラー色にする。
Future<bool> showSkConfirmDialog(
  BuildContext context, {
  required String title,
  String? message,
  String? confirmLabel,
  String? cancelLabel,
  bool destructive = false,
}) async {
  final localizations = MaterialLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      final scheme = Theme.of(context).colorScheme;
      return AlertDialog(
        title: Text(title),
        content: message == null ? null : Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelLabel ?? localizations.cancelButtonLabel),
          ),
          FilledButton(
            style: destructive
                ? FilledButton.styleFrom(
                    backgroundColor: scheme.error,
                    foregroundColor: scheme.onError,
                  )
                : null,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmLabel ?? localizations.okButtonLabel),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
