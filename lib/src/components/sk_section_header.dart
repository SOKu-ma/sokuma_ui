import 'package:flutter/material.dart';

import '../tokens/sk_spacing.dart';
import '../tokens/sk_text_styles.dart';

/// 画面内のまとまりにつける見出し。
///
/// 右端に「すべて見る」ボタンや件数バッジなどを [trailing] で置ける。
class SkSectionHeader extends StatelessWidget {
  const SkSectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.padding = const EdgeInsets.only(bottom: SkSpacing.sm),
  });

  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(
                title,
                // アプリ側のテーマに依らず、太さと大きさはトークンにそろえる。
                style: SkTextStyles.subtitle.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: SkSpacing.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}
