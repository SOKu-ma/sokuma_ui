import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sokuma_ui/sokuma_ui.dart';

void main() {
  Widget wrap(Widget child, {Brightness brightness = Brightness.light}) =>
      MaterialApp(
        theme: buildAppTheme(
          colorScheme: AppColorSchemes.monochrome(brightness),
        ),
        home: Scaffold(body: Center(child: child)),
      );

  group('AppSectionHeader', () {
    testWidgets('見出しとして読み上げ、trailing を右に置く', (tester) async {
      await tester.pumpWidget(
        wrap(const AppSectionHeader(title: '最近の記録', trailing: Text('すべて'))),
      );
      expect(find.text('最近の記録'), findsOneWidget);
      expect(find.text('すべて'), findsOneWidget);
      expect(
        tester.getSemantics(find.text('最近の記録')).flagsCollection.isHeader,
        isTrue,
      );
    });
  });

  group('AppEmptyState', () {
    testWidgets('説明とボタンは渡したときだけ出す', (tester) async {
      await tester.pumpWidget(
        wrap(const AppEmptyState(icon: Icons.inbox, title: 'まだありません')),
      );
      expect(find.text('まだありません'), findsOneWidget);
      expect(find.byType(FilledButton), findsNothing);

      await tester.pumpWidget(
        wrap(
          AppEmptyState(
            icon: Icons.inbox,
            title: 'まだありません',
            description: '最初の記録を追加しましょう',
            action: FilledButton(onPressed: () {}, child: const Text('追加')),
          ),
        ),
      );
      expect(find.text('最初の記録を追加しましょう'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });
  });

  group('AppPill', () {
    testWidgets('filled のときは塗り色の明暗から文字色を選ぶ', (tester) async {
      await tester.pumpWidget(
        wrap(const AppPill(label: 'PRO', color: Colors.black, filled: true)),
      );
      final text = tester.widget<Text>(find.text('PRO'));
      expect(text.style?.color, Colors.white);
    });

    testWidgets('色指定時は同じ色の文字に薄い面', (tester) async {
      await tester.pumpWidget(
        wrap(const AppPill(label: '済', color: AppColors.success)),
      );
      final text = tester.widget<Text>(find.text('済'));
      expect(text.style?.color, AppColors.success);
    });
  });

  group('AppPanel', () {
    testWidgets('onTap を渡すとタップできる', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        wrap(AppPanel(onTap: () => tapped++, child: const Text('カード'))),
      );
      await tester.tap(find.text('カード'));
      expect(tapped, 1);
    });
  });

  group('AppSettingsTile', () {
    testWidgets('onTap があり trailing が無いとシェブロンを出す', (tester) async {
      await tester.pumpWidget(
        wrap(
          AppSettingsSection(
            title: '表示',
            children: [
              AppSettingsTile(title: 'テーマ', value: 'ダーク', onTap: () {}),
              AppSettingsTile(
                title: '通知',
                trailing: Switch(value: true, onChanged: (_) {}),
              ),
            ],
          ),
        ),
      );
      expect(find.text('ダーク'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('destructive はエラー色', (tester) async {
      await tester.pumpWidget(
        wrap(AppSettingsTile(title: '削除', destructive: true, onTap: () {})),
      );
      final scheme = AppColorSchemes.monochrome(Brightness.light);
      expect(tester.widget<Text>(find.text('削除')).style?.color, scheme.error);
    });
  });

  group('showAppConfirmDialog', () {
    Future<bool?> run(WidgetTester tester, String tapLabel) async {
      bool? result;
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async => result = await showAppConfirmDialog(
                context,
                title: '削除しますか？',
                confirmLabel: '削除',
                destructive: true,
              ),
              child: const Text('open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.text('削除しますか？'), findsOneWidget);
      await tester.tap(find.text(tapLabel));
      await tester.pumpAndSettle();
      return result;
    }

    testWidgets('確定で true', (tester) async {
      expect(await run(tester, '削除'), isTrue);
    });

    testWidgets('キャンセル（既定ラベル）で false', (tester) async {
      expect(await run(tester, 'Cancel'), isFalse);
    });
  });

  group('AppSnackBar', () {
    testWidgets('連続で出しても 1 つだけ表示する', (tester) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) => TextButton(
              onPressed: () {
                AppSnackBar.show(context, '1 件目');
                AppSnackBar.show(context, '2 件目', icon: Icons.check);
              },
              child: const Text('show'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('show'));
      await tester.pumpAndSettle();
      expect(find.text('1 件目'), findsNothing);
      expect(find.text('2 件目'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });

  group('AppSegmentedControl', () {
    testWidgets('未選択の区画をタップすると onChanged', (tester) async {
      String? changed;
      await tester.pumpWidget(
        wrap(
          SizedBox(
            width: 300,
            child: AppSegmentedControl<String>(
              segments: const [
                AppSegment(value: 'list', label: '一覧'),
                AppSegment(value: 'stats', label: '集計'),
              ],
              selected: 'list',
              onChanged: (v) => changed = v,
            ),
          ),
        ),
      );
      await tester.tap(find.text('一覧'));
      expect(changed, isNull);
      await tester.tap(find.text('集計'));
      expect(changed, 'stats');

      final scheme = AppColorSchemes.monochrome(Brightness.light);
      final selectedText = tester.widget<Text>(find.text('一覧'));
      expect(selectedText.style?.color, scheme.onPrimary);
    });
  });

  group('AppMetricTile', () {
    testWidgets('数値は等幅数字', (tester) async {
      await tester.pumpWidget(
        wrap(const AppMetricTile(label: '打率', value: '.312')),
      );
      final rich = tester.widget<RichText>(
        find
            .descendant(
              of: find.byType(AppMetricTile),
              matching: find.byType(RichText),
            )
            .last,
      );
      expect(
        rich.text.style?.fontFeatures,
        contains(const FontFeature.tabularFigures()),
      );
    });
  });

  group('AppLoadingOverlay', () {
    testWidgets('Stack の上に重ねて表示できる', (tester) async {
      await tester.pumpWidget(
        wrap(
          const SizedBox(
            width: 300,
            height: 300,
            child: Stack(children: [AppLoadingOverlay(message: '共有中…')]),
          ),
        ),
      );
      expect(find.text('共有中…'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
