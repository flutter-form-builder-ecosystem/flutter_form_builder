import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../form_builder_tester.dart';

void main() {
  group('custom error -', () {
    testWidgets('Should show custom error when invalidate field',
        (tester) async {
      const textFieldName = 'text1';
      const errorTextField = 'error text field';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Set custom error
      formKey.currentState?.fields[textFieldName]?.invalidate(errorTextField);
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsOneWidget);
    });
  });

  group('dynamic fields', () {
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
  });

  group('skipDisabled -', () {
    testWidgets(
        'Should not show error when field is not enabled and skipDisabled is true',
        (tester) async {
      const textFieldName = 'text3';
      const errorTextField = 'error text field';
      final testWidget = FormBuilderTextField(
        name: textFieldName,
        enabled: false,
        validator: (value) => errorTextField,
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        skipDisabled: true,
      ));

      formKey.currentState?.validate();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsNothing);

      formKey.currentState?.fields[textFieldName]?.validate();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsNothing);
    });
    testWidgets(
        'Should show error when field is not enabled and skipDisabled is false',
        (tester) async {
      const textFieldName = 'text4';
      const errorTextField = 'error text field';
      final testWidget = FormBuilderTextField(
        name: textFieldName,
        enabled: false,
        validator: (value) => errorTextField,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formKey.currentState?.validate();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsOneWidget);

      formKey.currentState?.reset();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsNothing);

      formKey.currentState?.fields[textFieldName]?.validate();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsOneWidget);
    });
  });

  group('autovalidateMode -', () {
    testWidgets(
        'Should show error when init form and AutovalidateMode is always',
        (tester) async {
      const textFieldName = 'text4';
      const errorTextField = 'error text field';
      final testWidget = FormBuilderTextField(
        name: textFieldName,
        validator: (value) => errorTextField,
        autovalidateMode: AutovalidateMode.always,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);
    });
  });

  group('isDirty - ', () {
    testWidgets('Should not dirty by default', (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formKey.currentState?.isDirty, false);
    });
    testWidgets('Should dirty when update field value by user', (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      final widgetFinder = find.byWidget(testWidget);
      await tester.enterText(widgetFinder, 'test');

      expect(formKey.currentState?.isDirty, true);
    });
    testWidgets('Should dirty when update field value by method',
        (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formKey.currentState?.patchValue({textFieldName: 'test'});
      await tester.pumpAndSettle();

      expect(formKey.currentState?.isDirty, true);
    });
    testWidgets('Should dirty when update field with initial value by user',
        (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        initialValue: {textFieldName: 'hi'},
      ));

      final widgetFinder = find.byWidget(testWidget);
      await tester.enterText(widgetFinder, 'test');

      expect(formKey.currentState?.isDirty, true);
    });
    testWidgets('Should dirty when update field with initial value by method',
        (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        initialValue: {textFieldName: 'hi'},
      ));

      formKey.currentState?.patchValue({textFieldName: 'test'});
      await tester.pumpAndSettle();

      expect(formKey.currentState?.isDirty, true);
    });
    testWidgets('Should not dirty when reset field value', (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formKey.currentState?.patchValue({textFieldName: 'test'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.isDirty, false);
    });
    testWidgets('Should not dirty when reset field with initial value',
        (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        initialValue: {textFieldName: 'hi'},
      ));

      formKey.currentState?.patchValue({textFieldName: 'test'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.isDirty, false);
    });
  });

  group('isTouched - ', () {
    testWidgets('Should not touched by default', (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formKey.currentState?.isTouched, false);
    });
    testWidgets('Should touched when focus input', (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      final widgetFinder = find.byWidget(testWidget);
      await tester.tap(widgetFinder);

      expect(formKey.currentState?.isTouched, true);
    });
  });

  group('reset -', () {
    testWidgets('Should reset to null when call reset', (tester) async {
      const textFieldName = 'text';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formKey.currentState?.patchValue({textFieldName: 'test'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.instantValue, {textFieldName: null});
    });
    testWidgets('Should reset to initial when call reset', (tester) async {
      const textFieldName = 'text';
      const initialValue = {textFieldName: 'test'};
      final testWidget = FormBuilderTextField(
        name: textFieldName,
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        initialValue: initialValue,
      ));

      formKey.currentState?.patchValue({textFieldName: 'hello'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.instantValue, equals(initialValue));
    });
    testWidgets(
        'Should reset custom error when invalidate field and then reset',
        (tester) async {
      const textFieldName = 'text';
      const errorTextField = 'error text field';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formKey.currentState?.fields[textFieldName]?.invalidate(errorTextField);
      await tester.pumpAndSettle();

      // Reset custom error
      formKey.currentState?.reset();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsNothing);
    });
  });
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
