import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderCheckbox -- Off/On/Off', (WidgetTester tester) async {
    const checkboxName = 'cb1';
    final testWidget = FormBuilderCheckbox(
      name: checkboxName,
      title: const Text('Checkbox 1'),
      initialValue: false,
    );
    final widgetFinder = find.byWidget(testWidget);

    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    expect(formSave(), isTrue);
    expect(formValue(checkboxName), isFalse);
    await tester.tap(widgetFinder);
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(checkboxName), isTrue);
    await tester.tap(widgetFinder);
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(checkboxName), isFalse);
  });
}
