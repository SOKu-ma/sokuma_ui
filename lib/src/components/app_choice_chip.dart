import 'package:flutter/material.dart';

import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_text_styles.dart';

/// 単一選択用のチップ。
///
/// 選択時はプライマリ色で塗りつぶすだけで、チェックマークは表示せず、
/// 枠線の太さも選択状態で変えない。色はすべて [ColorScheme] から取るため、
/// ライト / ダークどちらのテーマでもそのまま使える。
class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
  });

  final String label;
  final bool selected;

  /// null の場合は無効状態になる。
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final enabled = onSelected != null;
    // 無効状態のラベルは Chip 側で半透明になるので、ここでは色だけ決める。
    final filled = selected && enabled;
    final disabledFill = colorScheme.onSurface.withValues(alpha: 0.12);

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      showCheckmark: false,
      color: WidgetStateProperty.resolveWith((states) {
        if (!states.contains(WidgetState.selected)) return Colors.transparent;
        return states.contains(WidgetState.disabled)
            ? disabledFill
            : colorScheme.primary;
      }),
      labelStyle: AppTextStyles.label.copyWith(
        color: filled ? colorScheme.onPrimary : colorScheme.onSurface,
      ),
      side: BorderSide(
        color: !enabled
            ? disabledFill
            : selected
            ? colorScheme.primary
            : colorScheme.outline,
      ),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.fullAll),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    );
  }
}
