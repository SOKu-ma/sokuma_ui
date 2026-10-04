import 'package:flutter/material.dart';

import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';

/// [AppSegmentedControl] の 1 区画。
class AppSegment<T> {
  const AppSegment({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// 横幅いっぱいに区画を並べる単一選択の切り替え。
///
/// `SegmentedButton` よりも背が低く、選択中の区画をプライマリで塗りつぶす。
/// タブ的な表示切り替え（一覧 / 集計 など）に使う。
class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.height = 38,
  });

  final List<AppSegment<T>> segments;
  final T selected;

  /// null の場合は無効状態になる。
  final ValueChanged<T>? onChanged;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final enabled = onChanged != null;

    return Opacity(
      opacity: enabled ? 1 : 0.38,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: scheme.outlineVariant),
        ),
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: Row(
          children: [
            for (final segment in segments)
              Expanded(
                child: _SegmentButton(
                  segment: segment,
                  selected: segment.value == selected,
                  onTap: enabled ? () => onChanged!(segment.value) : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SegmentButton<T> extends StatelessWidget {
  const _SegmentButton({
    required this.segment,
    required this.selected,
    required this.onTap,
  });

  final AppSegment<T> segment;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final foreground = selected ? scheme.onPrimary : scheme.onSurfaceVariant;
    // 外枠の内側に収まるよう、外枠より余白ぶん小さい角丸にする。
    const radius = BorderRadius.all(
      Radius.circular(AppRadius.md - AppSpacing.xxs),
    );

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? scheme.primary : Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: selected ? null : onTap,
          borderRadius: radius,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (segment.icon != null) ...[
                  Icon(segment.icon, size: 16, color: foreground),
                  const SizedBox(width: AppSpacing.xs),
                ],
                Flexible(
                  child: Text(
                    segment.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: foreground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
