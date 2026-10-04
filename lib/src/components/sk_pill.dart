import 'package:flutter/material.dart';

import '../tokens/sk_radius.dart';
import '../tokens/sk_spacing.dart';

/// 状態や件数を示す小さなラベル（バッジ）。
///
/// - [color] 省略時: グレーの面に補助文字色
/// - [color] 指定時: その色の文字に、同じ色を薄くした面
/// - [filled] が true: その色で塗りつぶし、文字は明暗から自動で白黒を選ぶ
class SkPill extends StatelessWidget {
  const SkPill({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.filled = false,
  });

  final String label;
  final IconData? icon;
  final Color? color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final accent = color;

    final Color background;
    final Color foreground;
    if (accent == null) {
      background = scheme.surfaceContainerHighest;
      foreground = scheme.onSurfaceVariant;
    } else if (filled) {
      background = accent;
      foreground =
          ThemeData.estimateBrightnessForColor(accent) == Brightness.dark
          ? Colors.white
          : Colors.black;
    } else {
      background = accent.withValues(alpha: 0.12);
      foreground = accent;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: SkRadius.fullAll,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SkSpacing.sm,
          vertical: SkSpacing.xxs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: foreground),
              const SizedBox(width: SkSpacing.xs),
            ],
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
