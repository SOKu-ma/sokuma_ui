import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sokuma_ui/sokuma_ui.dart';

void main() {
  Widget wrap(Widget child, {Brightness brightness = Brightness.light}) =>
      MaterialApp(
        theme: buildSkTheme(colorScheme: SkColorSchemes.monochrome(brightness)),
        home: Scaffold(body: Center(child: child)),
      );

  group('SkSectionHeader', () {
    testWidgets('見出しとして読み上げ、trailing を右に置く', (tester) async {
      await tester.pumpWidget(
        wrap(const SkSectionHeader(title: '最近の記録', trailing: Text('すべて'))),
      );
      expect(find.text('最近の記録'), findsOneWidget);
      expect(find.text('すべて'), findsOneWidget);
      expect(
        tester.getSemantics(find.text('最近の記録')).flagsCollection.isHeader,
        isTrue,
      );
    });
  });

  testWidgets('SkSectionHeader はアプリのテーマに依らずトークンの太さ', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(),
        home: const Scaffold(body: SkSectionHeader(title: '見出し')),
      ),
    );
    final style = tester.widget<Text>(find.text('見出し')).style!;
    expect(style.fontWeight, SkTextStyles.subtitle.fontWeight);
    expect(style.fontSize, SkTextStyles.subtitle.fontSize);
  });

  group('SkEmptyState', () {
    testWidgets('説明とボタンは渡したときだけ出す', (tester) async {
      await tester.pumpWidget(
        wrap(const SkEmptyState(icon: Icons.inbox, title: 'まだありません')),
      );
      expect(find.text('まだありません'), findsOneWidget);
      expect(find.byType(FilledButton), findsNothing);

      await tester.pumpWidget(
        wrap(
          SkEmptyState(
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

  group('SkPill', () {
    testWidgets('filled のときは塗り色の明暗から文字色を選ぶ', (tester) async {
      await tester.pumpWidget(
        wrap(const SkPill(label: 'PRO', color: Colors.black, filled: true)),
      );
      final text = tester.widget<Text>(find.text('PRO'));
      expect(text.style?.color, Colors.white);
    });

    testWidgets('色指定時は同じ色の文字に薄い面', (tester) async {
      await tester.pumpWidget(
        wrap(const SkPill(label: '済', color: SkColors.success)),
      );
      final text = tester.widget<Text>(find.text('済'));
      expect(text.style?.color, SkColors.success);
    });
  });

  group('SkPanel', () {
    testWidgets('onTap を渡すとタップできる', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        wrap(SkPanel(onTap: () => tapped++, child: const Text('カード'))),
      );
      await tester.tap(find.text('カード'));
      expect(tapped, 1);
    });
  });

  group('SkSettingsTile', () {
    testWidgets('onTap があり trailing が無いとシェブロンを出す', (tester) async {
      await tester.pumpWidget(
        wrap(
          SkSettingsSection(
            title: '表示',
            children: [
              SkSettingsTile(title: 'テーマ', value: 'ダーク', onTap: () {}),
              SkSettingsTile(
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
        wrap(SkSettingsTile(title: '削除', destructive: true, onTap: () {})),
      );
      final scheme = SkColorSchemes.monochrome(Brightness.light);
      expect(tester.widget<Text>(find.text('削除')).style?.color, scheme.error);
    });
  });

  group('showSkConfirmDialog', () {
    Future<bool?> run(WidgetTester tester, String tapLabel) async {
      bool? result;
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async => result = await showSkConfirmDialog(
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

  group('SkSnackBar', () {
    testWidgets('連続で出しても 1 つだけ表示する', (tester) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) => TextButton(
              onPressed: () {
                SkSnackBar.show(context, '1 件目');
                SkSnackBar.show(context, '2 件目', icon: Icons.check);
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

  group('SkSegmentedControl', () {
    testWidgets('未選択の区画をタップすると onChanged', (tester) async {
      String? changed;
      await tester.pumpWidget(
        wrap(
          SizedBox(
            width: 300,
            child: SkSegmentedControl<String>(
              segments: const [
                SkSegment(value: 'list', label: '一覧'),
                SkSegment(value: 'stats', label: '集計'),
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

      final scheme = SkColorSchemes.monochrome(Brightness.light);
      final selectedText = tester.widget<Text>(find.text('一覧'));
      expect(selectedText.style?.color, scheme.onPrimary);
    });
  });

  group('SkMetricTile', () {
    testWidgets('数値は等幅数字', (tester) async {
      await tester.pumpWidget(
        wrap(const SkMetricTile(label: '打率', value: '.312')),
      );
      final rich = tester.widget<RichText>(
        find
            .descendant(
              of: find.byType(SkMetricTile),
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

  group('SkLoadingOverlay', () {
    testWidgets('Stack の上に重ねて表示できる', (tester) async {
      await tester.pumpWidget(
        wrap(
          const SizedBox(
            width: 300,
            height: 300,
            child: Stack(children: [SkLoadingOverlay(message: '共有中…')]),
          ),
        ),
      );
      expect(find.text('共有中…'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
