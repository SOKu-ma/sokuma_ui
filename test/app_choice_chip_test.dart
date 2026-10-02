import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sokuma_ui/sokuma_ui.dart';

void main() {
  Widget wrap(
    Widget child, {
    Color seed = Colors.teal,
    Brightness brightness = Brightness.light,
  }) => MaterialApp(
    theme: buildAppTheme(seedColor: seed, brightness: brightness),
    home: Scaffold(body: Center(child: child)),
  );

  /// チップが実際に描画している塗りと枠線を取り出す。
  ShapeDecoration chipDecoration(WidgetTester tester) {
    final ink = tester.widget<Ink>(
      find.descendant(of: find.byType(ChoiceChip), matching: find.byType(Ink)),
    );
    return ink.decoration! as ShapeDecoration;
  }

  for (final brightness in Brightness.values) {
    group('${brightness.name} テーマ', () {
      final scheme = buildAppTheme(
        seedColor: Colors.teal,
        brightness: brightness,
      ).colorScheme;

      testWidgets('選択時はプライマリで塗りつぶし、チェックマークは出さない', (tester) async {
        await tester.pumpWidget(
          wrap(
            AppChoiceChip(label: 'A', selected: true, onSelected: (_) {}),
            brightness: brightness,
          ),
        );
        await tester.pumpAndSettle();

        final decoration = chipDecoration(tester);
        expect(decoration.color, scheme.primary);
        expect(find.byIcon(Icons.check), findsNothing);
        expect(
          tester.widget<ChoiceChip>(find.byType(ChoiceChip)).showCheckmark,
          isFalse,
        );
        expect(
          DefaultTextStyle.of(tester.element(find.text('A'))).style.color,
          scheme.onPrimary,
        );
      });

      testWidgets('選択・非選択で枠線の太さは変わらない', (tester) async {
        Future<BorderSide> sideOf({required bool selected}) async {
          await tester.pumpWidget(
            wrap(
              AppChoiceChip(label: 'A', selected: selected, onSelected: (_) {}),
              brightness: brightness,
            ),
          );
          await tester.pumpAndSettle();
          return (chipDecoration(tester).shape as OutlinedBorder).side;
        }

        final unselected = await sideOf(selected: false);
        final selected = await sideOf(selected: true);
        expect(unselected.color, scheme.outline);
        expect(selected.color, scheme.primary);
        expect(selected.width, unselected.width);
      });

      testWidgets('無効状態では選択中でもプライマリで塗らない', (tester) async {
        await tester.pumpWidget(
          wrap(
            const AppChoiceChip(label: 'A', selected: true),
            brightness: brightness,
          ),
        );
        await tester.pumpAndSettle();

        expect(chipDecoration(tester).color, isNot(scheme.primary));
      });
    });
  }

  testWidgets('タップで onSelected が呼ばれる', (tester) async {
    bool? value;
    await tester.pumpWidget(
      wrap(
        AppChoiceChip(
          label: 'A',
          selected: false,
          onSelected: (v) => value = v,
        ),
      ),
    );

    await tester.tap(find.text('A'));
    expect(value, isTrue);
  });

  test('seedColor でプライマリが変わる', () {
    final a = buildAppTheme(seedColor: Colors.red).colorScheme.primary;
    final b = buildAppTheme(seedColor: Colors.blue).colorScheme.primary;
    expect(a, isNot(b));
  });
}
