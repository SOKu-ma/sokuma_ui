import 'package:flutter/material.dart';

import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import 'app_panel.dart';
import 'app_section_header.dart';

/// 設定画面のグループ。見出しの下に、区切り線入りのパネルで行を並べる。
class AppSettingsSection extends StatelessWidget {
  const AppSettingsSection({
    super.key,
    this.title,
    required this.children,
    this.footer,
  });

  final String? title;
  final List<Widget> children;

  /// パネルの下に出す補足説明。
  final String? footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          AppSectionHeader(
            title: title!,
            padding: const EdgeInsets.only(
              left: AppSpacing.xs,
              bottom: AppSpacing.sm,
            ),
          ),
        AppPanel(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const Divider(height: 1, indent: AppSpacing.lg),
                children[i],
              ],
            ],
          ),
        ),
        if (footer != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xs,
              AppSpacing.sm,
              AppSpacing.xs,
              0,
            ),
            child: Text(footer!, style: theme.textTheme.bodySmall),
          ),
      ],
    );
  }
}

/// 設定画面の 1 行。
///
/// 右端は [trailing]（スイッチなど）か、[value] の文字列＋シェブロン。
class AppSettingsTile extends StatelessWidget {
  const AppSettingsTile({
    super.key,
    required this.title,
    this.icon,
    this.iconColor,
    this.subtitle,
    this.value,
    this.trailing,
    this.onTap,
    this.showChevron,
    this.destructive = false,
  });

  final String title;
  final IconData? icon;

  /// アイコンの色。省略時は補助文字色。アイコンの下地はこの色を薄くしたもの。
  final Color? iconColor;
  final String? subtitle;

  /// 現在の設定値（例: 「ダーク」）。
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;

  /// 省略時は [onTap] があり [trailing] が無いときだけ表示する。
  final bool? showChevron;

  /// 削除など取り消せない操作の行。文字とアイコンをエラー色にする。
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final accent = destructive
        ? scheme.error
        : iconColor ?? scheme.onSurfaceVariant;
    final chevron = showChevron ?? (onTap != null && trailing == null);

    return ListTile(
      onTap: onTap,
      leading: icon == null
          ? null
          : Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: AppRadius.smAll,
              ),
              child: Icon(icon, size: 18, color: accent),
            ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: destructive ? scheme.error : null,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, style: theme.textTheme.bodySmall),
      trailing:
          trailing ??
          (value == null && !chevron
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (value != null)
                      Text(
                        value!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    if (chevron)
                      Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
                  ],
                )),
    );
  }
}
