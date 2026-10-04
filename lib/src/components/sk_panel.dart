import 'package:flutter/material.dart';

import '../tokens/sk_radius.dart';
import '../tokens/sk_spacing.dart';

/// 影を使わず、細い枠線で区切る平らなカード。
///
/// [onTap] を渡すとタップできるカードになる（波紋は角丸の内側に収まる）。
class SkPanel extends StatelessWidget {
  const SkPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(SkSpacing.lg),
    this.color,
    this.borderRadius = SkRadius.lgAll,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  /// 省略時は `colorScheme.surface`。
  final Color? color;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final content = Padding(padding: padding, child: child);
    return Material(
      color: color ?? scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
  }
}
