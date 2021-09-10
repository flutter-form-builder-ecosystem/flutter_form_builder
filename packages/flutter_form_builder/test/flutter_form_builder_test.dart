import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderTextField -- Hello Planet',
      (WidgetTester tester) async {
    const newTextValue = 'Hello 🪐';
    const textFieldName = 'text1';
    final testWidget = FormBuilderField(
      name: textFieldName,
      builder: (FormFieldState<String?> field) {
        return InputDecorator(
          decoration: const InputDecoration(),
          child: TextField(
            onChanged: (value) => field.didChange(value),
          ),
        );
      },
    );
    final widgetFinder = find.byWidget(testWidget);

    await tester.pumpWidget(buildTestableFieldWidget(testWidget));
    expect(formSave(), isTrue);
    // TODO Confirm that this should not be isEmpty
    expect(formValue(textFieldName), isNull);
    await tester.enterText(widgetFinder, newTextValue);
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), equals(newTextValue));
    await tester.enterText(widgetFinder, '');
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), isEmpty);
  });
}
