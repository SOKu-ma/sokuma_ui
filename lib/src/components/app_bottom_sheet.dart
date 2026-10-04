import 'package:flutter/material.dart';

import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';

/// 自前でレイアウトするシートの上端に置く取っ手。
///
/// `showModalBottomSheet(showDragHandle: true)` を使える場合はそちらでよい。
class AppSheetHandle extends StatelessWidget {
  const AppSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outline,
            borderRadius: AppRadius.fullAll,
          ),
        ),
      ),
    );
  }
}

/// アプリ共通の設定でモーダルボトムシートを開く。
///
/// 取っ手を表示し、セーフエリアを避け、内容に合わせて高さを伸ばせる。
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: builder,
    showDragHandle: true,
    useSafeArea: true,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
  );
}
