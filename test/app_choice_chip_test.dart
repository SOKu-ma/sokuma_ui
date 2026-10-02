import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sokuma_ui/sokuma_ui.dart';

void main() {
  Widget wrap(Widget child, {Color seed = Colors.teal}) => MaterialApp(
    theme: buildAppTheme(seedColor: seed),
    home: Scaffold(body: Center(child: child)),
  );

  testWidgets('選択時はプライマリで塗りつぶし、チェックマークは出さない', (tester) async {
    await tester.pumpWidget(
      wrap(AppChoiceChip(label: 'A', selected: true, onSelected: (_) {})),
    );

    final chip = tester.widget<ChoiceChip>(find.byType(ChoiceChip));
    final primary = buildAppTheme(seedColor: Colors.teal).colorScheme.primary;
    expect(chip.showCheckmark, isFalse);
    expect(chip.selectedColor, primary);
    expect(find.byIcon(Icons.check), findsNothing);
  });

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
