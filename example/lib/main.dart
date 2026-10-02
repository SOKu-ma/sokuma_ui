import 'package:flutter/material.dart';
import 'package:sokuma_ui/sokuma_ui.dart';

void main() => runApp(const ExampleApp());

const _seeds = <String, Color>{
  'Default': AppColors.defaultSeed,
  'Green': Colors.green,
  'Orange': Colors.deepOrange,
};

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  String _seed = 'Default';
  ThemeMode _themeMode = ThemeMode.system;
  String _position = 'FW';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sokuma_ui example',
      theme: buildAppTheme(seedColor: _seeds[_seed]!),
      darkTheme: buildAppTheme(
        seedColor: _seeds[_seed]!,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: Builder(
        builder: (context) {
          final textTheme = Theme.of(context).textTheme;
          return Scaffold(
            appBar: AppBar(title: const Text('sokuma_ui')),
            body: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Text('seedColor', style: textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: [
                    for (final name in _seeds.keys)
                      AppChoiceChip(
                        label: name,
                        selected: _seed == name,
                        onSelected: (_) => setState(() => _seed = name),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('themeMode', style: textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: [
                    for (final mode in ThemeMode.values)
                      AppChoiceChip(
                        label: mode.name,
                        selected: _themeMode == mode,
                        onSelected: (_) => setState(() => _themeMode = mode),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('AppChoiceChip', style: textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
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
                const SizedBox(height: AppSpacing.lg),
                Text('Text styles', style: textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Text('Headline', style: textTheme.headlineSmall),
                Text('Title', style: textTheme.titleMedium),
                Text('Body', style: textTheme.bodyMedium),
                Text('Label', style: textTheme.labelLarge),
                Text('Caption', style: textTheme.bodySmall),
              ],
            ),
          );
        },
      ),
    );
  }
}
