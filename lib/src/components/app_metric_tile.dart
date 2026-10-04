import 'package:flutter/material.dart';

import '../tokens/app_spacing.dart';
import '../tokens/app_text_styles.dart';

/// 「打率 .312」「平均 58.2」のような、ラベル付きの数値表示。
///
/// 数値は等幅数字で表示するので、横に並べても桁がそろう。
class AppMetricTile extends StatelessWidget {
  const AppMetricTile({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.color,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String label;
  final String value;

  /// 数値の後ろに小さく添える単位（例: 「本」「%」）。
  final String? unit;

  /// 数値の色。省略時は `onSurface`。
  final Color? color;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final valueColor = color ?? scheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text.rich(
          TextSpan(
            text: value,
            children: [
              if (unit != null)
                TextSpan(
                  text: unit,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: valueColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
          style: AppTextStyles.numeric.copyWith(color: valueColor),
          maxLines: 1,
        ),
      ],
    );
  }
}
