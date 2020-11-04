import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderTouchSpin -- 1/2/1', (WidgetTester tester) async {
    const widgetName = 'ts1';
    final testWidget = FormBuilderTouchSpin(
      name: widgetName,
      initialValue: 1,
      addIcon: const Icon(Icons.add),
      subtractIcon: const Icon(Icons.remove),
    );

    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(1));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(2));
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(1));
  });
}
