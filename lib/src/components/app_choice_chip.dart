import 'package:flutter/material.dart';

import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_text_styles.dart';

/// 単一選択用のチップ。
///
/// 選択時はプライマリ色で塗りつぶすだけで、チェックマークは表示しない。
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

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      showCheckmark: false,
      selectedColor: colorScheme.primary,
      labelStyle: AppTextStyles.label.copyWith(
        color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
      ),
      side: selected
          ? BorderSide(color: colorScheme.primary)
          : BorderSide(color: colorScheme.outline),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.fullAll),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    );
  }
}
