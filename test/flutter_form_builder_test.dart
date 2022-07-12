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

  testWidgets(
    'FormBuilder Dynamic Field -- keeping value',
    (WidgetTester tester) async {
      const String testWidgetName = 'test_widget_name';

      await tester.pumpWidget(
        buildTestableFieldWidget(
          _DynamicFormFields(
            name: testWidgetName,
            valueTransformer: (value) {
              return value is String ? int.tryParse(value) : null;
            },
          ),
          // the value is kept
          clearValueOnUnregister: false,
        ),
      );

      // Write an input and test the transformer
      formFieldDidChange(testWidgetName, '1');
      expect(int, formInstantValue(testWidgetName).runtimeType);
      expect(1, formInstantValue(testWidgetName));

      // Remove the dynamic field from the widget tree
      final _DynamicFormFieldsState dynamicFieldState =
          tester.state(find.byType(_DynamicFormFields));
      dynamicFieldState.show = false;

      // Pump the next frame, disposing the field's state
      await tester.pump();

      // With the field unregistered, the form does not have its transformer
      // but it still has its value, now recovered as type String
      expect(String, formInstantValue(testWidgetName).runtimeType);
      expect('1', formInstantValue(testWidgetName));

      // Show and recreate the field's state
      dynamicFieldState.show = true;
      await tester.pump();

      // The transformer is registered again and with the internal value that
      // was kept, it's expected an int of value 1
      expect(int, formInstantValue(testWidgetName).runtimeType);
      expect(1, formInstantValue(testWidgetName));
    },
  );

  testWidgets(
    'FormBuilder Dynamic Field -- clearing value',
    (WidgetTester tester) async {
      const String testWidgetName = 'test_widget_name';

      await tester.pumpWidget(
        buildTestableFieldWidget(
          _DynamicFormFields(
            name: testWidgetName,
            valueTransformer: (value) {
              return value is String ? int.tryParse(value) : null;
            },
          ),
          // the value is cleared
          clearValueOnUnregister: true,
        ),
      );

      // Write an input and test the transformer
      formFieldDidChange(testWidgetName, '1');
      await tester.pump();
      expect(int, formInstantValue(testWidgetName).runtimeType);
      expect(1, formInstantValue(testWidgetName));

      // Remove the dynamic field from the widget tree
      final _DynamicFormFieldsState dynamicFieldState =
          tester.state(find.byType(_DynamicFormFields));
      dynamicFieldState.show = false;

      // Pump the next frame, disposing the field's state
      await tester.pump();

      // With the field unregistered, the form does not have its transformer,
      // and since the value was cleared, neither its value
      expect(Null, formInstantValue(testWidgetName).runtimeType);
      expect(null, formInstantValue(testWidgetName));

      // Show and recreate the field's state
      dynamicFieldState.show = true;
      await tester.pump();

      // A new input is needed to get another value
      formFieldDidChange(testWidgetName, '2');
      await tester.pump();
      expect(int, formInstantValue(testWidgetName).runtimeType);
      expect(2, formInstantValue(testWidgetName));
    },
  );
}

// simple stateful widget that can hide and show its child with the intent of
// disposing it from the tree
class _DynamicFormFields extends StatefulWidget {
  const _DynamicFormFields({
    Key? key,
    required this.name,
    this.valueTransformer,
  }) : super(key: key);

  final String name;
  final ValueTransformer? valueTransformer;

  @override
  State<_DynamicFormFields> createState() => _DynamicFormFieldsState();
}

class _DynamicFormFieldsState extends State<_DynamicFormFields> {
  bool _show = true;

  bool get show => _show;

  set show(bool value) => setState(() => _show = value);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _show,
      maintainState: false,
      child: FormBuilderField(
        name: widget.name,
        valueTransformer: widget.valueTransformer,
        builder: (FormFieldState<String?> field) {
          return TextField(
            onChanged: (value) => field.didChange(value),
          );
        },
      ),
    );
  }
}
