import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderTextField -- Hello Planet',
      (WidgetTester tester) async {
    const String newTextValue = 'Hello 🪐';
    const String textFieldName = 'text1';
    final FormBuilderTextField testWidget = FormBuilderTextField(
      name: textFieldName,
    );
    final Finder widgetFinder = find.byWidget(testWidget);

    await tester.pumpWidget(buildTestableFieldWidget(testWidget));
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), isNull);
    await tester.enterText(widgetFinder, newTextValue);
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), equals(newTextValue));
    await tester.enterText(widgetFinder, '');
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), isEmpty);
  });
  testWidgets(
    'FormBuilderTextField without initialValue',
    (WidgetTester tester) => _testFormBuilderTextFieldWithInitialValue(
      tester,
    ),
  );
  testWidgets(
    'FormBuilderTextField has initialValue on Field',
    (WidgetTester tester) => _testFormBuilderTextFieldWithInitialValue(
      tester,
      initialValueOnField: 'ok',
    ),
  );
  testWidgets(
    'FormBuilderTextField has initialValue on Form',
    (WidgetTester tester) => _testFormBuilderTextFieldWithInitialValue(
      tester,
      initialValueOnForm: 'ok',
    ),
  );

  testWidgets(
    'FormBuilderTextField triggers onTapOutside',
    (WidgetTester tester) =>
        _testFormBuilderTextFieldOnTapOutsideCallback(tester),
  );
}

Future<void> _testFormBuilderTextFieldWithInitialValue(
  WidgetTester tester, {
  String? initialValueOnField,
  String? initialValueOnForm,
}) async {
  int changedCount = 0;
  const String newTextValue = 'Hello 🪐';
  const String textFieldName = 'text1';

  FormBuilderTextField testWidget = FormBuilderTextField(
    name: textFieldName,
    initialValue: initialValueOnField,
    onChanged: (String? value) => changedCount++,
  );
  await tester.pumpWidget(buildTestableFieldWidget(
    testWidget,
    initialValue: <String, dynamic>{
      textFieldName: initialValueOnForm,
    },
  ));
  expect(formSave(), isTrue);
  expect(formValue(textFieldName), initialValueOnField ?? initialValueOnForm);
  expect(changedCount, 0);

  await tester.enterText(find.byWidget(testWidget), newTextValue);
  expect(formSave(), isTrue);
  expect(formValue(textFieldName), newTextValue);

  expect(changedCount, 1);
}

Future<void> _testFormBuilderTextFieldOnTapOutsideCallback(
    WidgetTester tester) async {
  const String textFieldName = 'Hello 🪐';
  bool triggered = false;

  FormBuilderTextField testWidget = FormBuilderTextField(
    name: textFieldName,
    onTapOutside: (PointerDownEvent event) => triggered = true,
  );
  await tester.pumpWidget(buildTestableFieldWidget(
    testWidget,
  ));
  final TextField textField =
      tester.firstWidget(find.byType(TextField)) as TextField;
  textField.onTapOutside?.call(const PointerDownEvent());
  expect(triggered, true);
}
