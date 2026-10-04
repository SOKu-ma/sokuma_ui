import 'package:flutter/material.dart';

import '../tokens/sk_radius.dart';
import '../tokens/sk_spacing.dart';

/// 画面全体を覆って操作を止め、処理中であることを示す。
///
/// `Stack` の最前面に置く。[message] は多言語化済みの文言を渡す。
class SkLoadingOverlay extends StatelessWidget {
  const SkLoadingOverlay({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Positioned.fill(
      child: ColoredBox(
        color: scheme.scrim.withValues(alpha: 0.26),
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: SkRadius.lgAll,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SkSpacing.xl,
                vertical: SkSpacing.lg,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.4),
                  ),
                  if (message != null) ...[
                    const SizedBox(width: SkSpacing.md),
                    Text(message!, style: theme.textTheme.labelLarge),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
