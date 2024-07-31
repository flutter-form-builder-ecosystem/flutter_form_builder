import 'package:flutter/material.dart';
import 'package:flutter_form_builder/src/fields/form_builder_switch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderSwitch -- Off/On/Off', (WidgetTester tester) async {
    const String switchName = 'switch1';
    final FormBuilderSwitch testWidget = FormBuilderSwitch(
      name: switchName,
      title: const Text('Switch 1'),
      initialValue: false,
    );
    final Finder widgetFinder = find.byWidget(testWidget);

    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    expect(formSave(), isTrue);
    expect(formValue(switchName), isFalse);
    await tester.tap(widgetFinder);
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(switchName), isTrue);
    await tester.tap(widgetFinder);
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(switchName), isFalse);
  });
}
