import 'package:flutter/material.dart';
import 'package:sokuma_ui/sokuma_ui.dart';

void main() => runApp(const ExampleApp());

/// null はモノクロ配色（AppColorSchemes.monochrome）。
const _schemes = <String, Color?>{
  'Monochrome': null,
  'Navy': Color(0xFF0C2340),
  'Green': Colors.green,
  'Orange': Colors.deepOrange,
};

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  String _scheme = 'Monochrome';
  ThemeMode _themeMode = ThemeMode.system;

  ThemeData _theme(Brightness brightness) {
    final seed = _schemes[_scheme];
    return buildAppTheme(
      colorScheme: seed == null
          ? AppColorSchemes.monochrome(brightness)
          : AppColorSchemes.seeded(seed, brightness: brightness),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sokuma_ui example',
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      themeMode: _themeMode,
      home: _Catalog(
        scheme: _scheme,
        themeMode: _themeMode,
        onSchemeChanged: (v) => setState(() => _scheme = v),
        onThemeModeChanged: (v) => setState(() => _themeMode = v),
      ),
    );
  }
}

class _Catalog extends StatefulWidget {
  const _Catalog({
    required this.scheme,
    required this.themeMode,
    required this.onSchemeChanged,
    required this.onThemeModeChanged,
  });

  final String scheme;
  final ThemeMode themeMode;
  final ValueChanged<String> onSchemeChanged;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<_Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<_Catalog> {
  String _position = 'FW';
  String _view = 'list';
  bool _notify = true;
  bool _loading = false;

  Future<void> _showLoading() async {
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const gap = SizedBox(height: AppSpacing.xxl);

    return Scaffold(
      appBar: AppBar(title: const Text('sokuma_ui')),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const AppSectionHeader(title: 'ColorScheme'),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final name in _schemes.keys)
                    AppChoiceChip(
                      label: name,
                      selected: widget.scheme == name,
                      onSelected: (_) => widget.onSchemeChanged(name),
                    ),
                ],
              ),
              gap,
              const AppSectionHeader(title: 'themeMode'),
              AppSegmentedControl<ThemeMode>(
                segments: const [
                  AppSegment(value: ThemeMode.system, label: 'system'),
                  AppSegment(
                    value: ThemeMode.light,
                    label: 'light',
                    icon: Icons.light_mode,
                  ),
                  AppSegment(
                    value: ThemeMode.dark,
                    label: 'dark',
                    icon: Icons.dark_mode,
                  ),
                ],
                selected: widget.themeMode,
                onChanged: widget.onThemeModeChanged,
              ),
              gap,
              const AppSectionHeader(title: 'AppChoiceChip'),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final p in const ['GK', 'DF', 'MF', 'FW'])
                    AppChoiceChip(
                      label: p,
                      selected: _position == p,
                      onSelected: (_) => setState(() => _position = p),
                    ),
                  const AppChoiceChip(label: '無効', selected: false),
                  const AppChoiceChip(label: '無効（選択中）', selected: true),
                ],
              ),
              gap,
              const AppSectionHeader(title: 'AppSegmentedControl'),
              AppSegmentedControl<String>(
                segments: const [
                  AppSegment(value: 'list', label: '一覧'),
                  AppSegment(value: 'stats', label: '集計'),
                  AppSegment(value: 'chart', label: 'グラフ'),
                ],
                selected: _view,
                onChanged: (v) => setState(() => _view = v),
              ),
              gap,
              AppSectionHeader(
                title: 'AppPanel / AppMetricTile',
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('すべて'),
                ),
              ),
              const AppPanel(
                child: Row(
                  children: [
                    Expanded(
                      child: AppMetricTile(label: '打率', value: '.312'),
                    ),
                    Expanded(
                      child: AppMetricTile(
                        label: '本塁打',
                        value: '12',
                        unit: '本',
                      ),
                    ),
                    Expanded(
                      child: AppMetricTile(
                        label: '出塁率',
                        value: '.405',
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              gap,
              const AppSectionHeader(title: 'AppPill'),
              const Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  AppPill(label: '下書き'),
                  AppPill(label: '完了', color: AppColors.success),
                  AppPill(label: '要確認', color: AppColors.warning),
                  AppPill(
                    label: 'PRO',
                    icon: Icons.workspace_premium,
                    color: AppColors.premiumGoldDeep,
                    filled: true,
                  ),
                ],
              ),
              gap,
              AppSettingsSection(
                title: 'AppSettingsSection',
                footer: '設定行は AppSettingsTile で並べます。',
                children: [
                  AppSettingsTile(
                    icon: Icons.palette_outlined,
                    title: 'テーマ',
                    value: widget.themeMode.name,
                    onTap: () {},
                  ),
                  AppSettingsTile(
                    icon: Icons.notifications_outlined,
                    iconColor: AppColors.warning,
                    title: '通知',
                    subtitle: '練習のリマインダー',
                    trailing: Switch(
                      value: _notify,
                      onChanged: (v) => setState(() => _notify = v),
                    ),
                  ),
                  AppSettingsTile(
                    icon: Icons.delete_outline,
                    title: 'データを削除',
                    destructive: true,
                    onTap: () async {
                      final ok = await showAppConfirmDialog(
                        context,
                        title: 'すべてのデータを削除しますか？',
                        message: 'この操作は取り消せません。',
                        confirmLabel: '削除',
                        destructive: true,
                      );
                      if (ok && context.mounted) {
                        AppSnackBar.show(
                          context,
                          '削除しました',
                          icon: Icons.check_circle_outline,
                        );
                      }
                    },
                  ),
                ],
              ),
              gap,
              const AppSectionHeader(title: 'AppEmptyState'),
              AppPanel(
                padding: EdgeInsets.zero,
                child: AppEmptyState(
                  icon: Icons.sports_baseball_outlined,
                  title: 'まだ記録がありません',
                  description: '最初の試合を追加しましょう。',
                  action: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('試合を追加'),
                  ),
                  secondaryAction: TextButton(
                    onPressed: () {},
                    child: const Text('データを読み込む'),
                  ),
                ),
              ),
              gap,
              const AppSectionHeader(title: 'シート / スナックバー / ローディング'),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  OutlinedButton(
                    onPressed: () => showAppBottomSheet<void>(
                      context: context,
                      builder: (context) => const Padding(
                        padding: EdgeInsets.fromLTRB(
                          AppSpacing.xl,
                          0,
                          AppSpacing.xl,
                          AppSpacing.xxl,
                        ),
                        child: AppSectionHeader(title: 'showAppBottomSheet'),
                      ),
                    ),
                    child: const Text('シート'),
                  ),
                  OutlinedButton(
                    onPressed: () => AppSnackBar.show(
                      context,
                      '保存しました',
                      action: SnackBarAction(label: '元に戻す', onPressed: () {}),
                    ),
                    child: const Text('スナックバー'),
                  ),
                  OutlinedButton(
                    onPressed: _showLoading,
                    child: const Text('ローディング'),
                  ),
                ],
              ),
              gap,
              const AppSectionHeader(title: 'Text styles'),
              Text('Headline', style: textTheme.headlineSmall),
              Text('Title', style: textTheme.titleMedium),
              Text('Subtitle', style: textTheme.titleSmall),
              Text('Body', style: textTheme.bodyMedium),
              Text('Label', style: textTheme.labelLarge),
              Text('Caption', style: textTheme.bodySmall),
              const Text('1234.56', style: AppTextStyles.numeric),
            ],
          ),
          if (_loading) const AppLoadingOverlay(message: '処理中…'),
        ],
      ),
    );
  }
}
