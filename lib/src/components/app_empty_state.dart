import 'package:flutter/material.dart';

import '../tokens/app_spacing.dart';
import '../tokens/app_text_styles.dart';

/// データがまだ無いときの表示。
///
/// アイコン・タイトル・説明・次の行動（ボタン）を縦に中央そろえで並べる。
/// 文言は呼び出し側で多言語化したものを渡す。
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.action,
    this.secondaryAction,
    this.padding = const EdgeInsets.all(AppSpacing.xxl),
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
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            style: AppTextStyles.title.copyWith(color: scheme.onSurface),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: AppSpacing.xl),
            action!,
          ],
          if (secondaryAction != null) ...[
            const SizedBox(height: AppSpacing.xs),
            secondaryAction!,
          ],
        ],
      ),
    );
  }
}
