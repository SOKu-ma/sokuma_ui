import 'package:flutter/material.dart';

import '../tokens/sk_spacing.dart';
import '../tokens/sk_text_styles.dart';

/// データがまだ無いときの表示。
///
/// アイコン・タイトル・説明・次の行動（ボタン）を縦に中央そろえで並べる。
/// 文言は呼び出し側で多言語化したものを渡す。
class SkEmptyState extends StatelessWidget {
  const SkEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.action,
    this.secondaryAction,
    this.padding = const EdgeInsets.all(SkSpacing.xxl),
  });

  final IconData icon;
  final String title;
  final String? description;

  /// 主な行動。通常は `FilledButton`。
  final Widget? action;

  /// 補助の行動。通常は `TextButton`。
  final Widget? secondaryAction;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: SkSpacing.lg),
          Text(
            title,
            style: SkTextStyles.title.copyWith(color: scheme.onSurface),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const SizedBox(height: SkSpacing.sm),
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: SkSpacing.xl),
            action!,
          ],
          if (secondaryAction != null) ...[
            const SizedBox(height: SkSpacing.xs),
            secondaryAction!,
          ],
        ],
      ),
    );
  }
}
