import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../form_builder_tester.dart';

void main() {
  group('custom error -', () {
    testWidgets('Should show custom error when invalidate field',
        (WidgetTester tester) async {
      const String textFieldName = 'text1';
      const String errorTextField = 'error text field';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
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
              valueTransformer: (dynamic value) {
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
              valueTransformer: (dynamic value) {
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

  group('isValid -', () {
    testWidgets('Should invalid when set custom error',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      const String errorTextField = 'error text field';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Set custom error
      formKey.currentState?.fields[textFieldName]?.invalidate(errorTextField);
      await tester.pumpAndSettle();

      expect(formKey.currentState?.isValid, isFalse);
    });
    testWidgets('Should valid when no has error and autovalidateMode is always',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      const String errorTextField = 'error text field';
      final FormBuilderTextField testWidget = FormBuilderTextField(
        name: textFieldName,
        validator: (String? value) =>
            value == null || value.isEmpty ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        autovalidateMode: AutovalidateMode.always,
      ));

      expect(formKey.currentState?.isValid, isFalse);

      final Finder widgetFinder = find.byWidget(testWidget);
      await tester.enterText(widgetFinder, 'test');
      await tester.pumpAndSettle();

      expect(formKey.currentState?.isValid, isTrue);
    });
    testWidgets('Should invalid when has error and autovalidateMode is always',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      const String errorTextField = 'error text field';
      final FormBuilderTextField testWidget = FormBuilderTextField(
        name: textFieldName,
        validator: (String? value) =>
            value == null || value.length < 10 ? errorTextField : null,
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        autovalidateMode: AutovalidateMode.always,
      ));

      expect(formKey.currentState?.isValid, isFalse);

      final Finder widgetFinder = find.byWidget(testWidget);
      await tester.enterText(widgetFinder, 'test');
      await tester.pumpAndSettle();

      expect(formKey.currentState?.isValid, isFalse);
    });
  });

  group('skipDisabled -', () {
    testWidgets(
        'Should not show error when field is not enabled and skipDisabled is true',
        (WidgetTester tester) async {
      const String textFieldName = 'text3';
      const String errorTextField = 'error text field';
      final FormBuilderTextField testWidget = FormBuilderTextField(
        name: textFieldName,
        enabled: false,
        validator: (String? value) => errorTextField,
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
        (WidgetTester tester) async {
      const String textFieldName = 'text4';
      const String errorTextField = 'error text field';
      final FormBuilderTextField testWidget = FormBuilderTextField(
        name: textFieldName,
        enabled: false,
        validator: (String? value) => errorTextField,
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
        (WidgetTester tester) async {
      const String textFieldName = 'text4';
      const String errorTextField = 'error text field';
      final FormBuilderTextField testWidget = FormBuilderTextField(
        name: textFieldName,
        validator: (String? value) => errorTextField,
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        autovalidateMode: AutovalidateMode.always,
      ));
      await tester.pumpAndSettle();

      expect(find.text(errorTextField), findsOneWidget);
    });
  });

  group('isDirty - ', () {
    testWidgets('Should not dirty by default', (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formKey.currentState?.isDirty, false);
    });
    testWidgets('Should dirty when update field value by user',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      final Finder widgetFinder = find.byWidget(testWidget);
      await tester.enterText(widgetFinder, 'test');

      expect(formKey.currentState?.isDirty, true);
    });
    testWidgets('Should dirty when update field value by method',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formKey.currentState
          ?.patchValue(<String, dynamic>{textFieldName: 'test'});
      await tester.pumpAndSettle();

      expect(formKey.currentState?.isDirty, true);
    });
    testWidgets('Should dirty when update field with initial value by user',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        initialValue: <String, dynamic>{textFieldName: 'hi'},
      ));

      final Finder widgetFinder = find.byWidget(testWidget);
      await tester.enterText(widgetFinder, 'test');

      expect(formKey.currentState?.isDirty, true);
    });
    testWidgets('Should dirty when update field with initial value by method',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        initialValue: <String, dynamic>{textFieldName: 'hi'},
      ));

      formKey.currentState
          ?.patchValue(<String, dynamic>{textFieldName: 'test'});
      await tester.pumpAndSettle();

      expect(formKey.currentState?.isDirty, true);
    });
    testWidgets('Should not dirty when reset field value',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formKey.currentState
          ?.patchValue(<String, dynamic>{textFieldName: 'test'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.isDirty, false);
    });
    testWidgets('Should not dirty when reset field with initial value',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        initialValue: <String, dynamic>{textFieldName: 'hi'},
      ));

      formKey.currentState
          ?.patchValue(<String, dynamic>{textFieldName: 'test'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.isDirty, false);
    });
  });

  group('isTouched - ', () {
    testWidgets('Should not touched by default', (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formKey.currentState?.isTouched, false);
    });
    testWidgets('Should touched when focus input', (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      final Finder widgetFinder = find.byWidget(testWidget);
      await tester.tap(widgetFinder);

      expect(formKey.currentState?.isTouched, true);
    });
  });

  group('reset -', () {
    testWidgets('Should reset to null when call reset',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formKey.currentState
          ?.patchValue(<String, dynamic>{textFieldName: 'test'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.instantValue,
          <String, Null>{textFieldName: null});
    });
    testWidgets('Should reset to initial when call reset',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      const Map<String, String> initialValue = <String, String>{
        textFieldName: 'test'
      };
      final FormBuilderTextField testWidget = FormBuilderTextField(
        name: textFieldName,
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        initialValue: initialValue,
      ));

      formKey.currentState
          ?.patchValue(<String, dynamic>{textFieldName: 'hello'});
      await tester.pumpAndSettle();
      formKey.currentState?.reset();

      expect(formKey.currentState?.instantValue, equals(initialValue));
    });
    testWidgets(
        'Should reset custom error when invalidate field and then reset',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      const String errorTextField = 'error text field';
      final FormBuilderTextField testWidget =
          FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      formKey.currentState?.fields[textFieldName]?.invalidate(errorTextField);
      await tester.pumpAndSettle();

      // Reset custom error
      formKey.currentState?.reset();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsNothing);
    });
  });

  group('errors -', () {
    testWidgets('Should get errors when more than one fields are invalid',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      const String checkboxName = 'checkbox';
      const String textFieldError = 'error text';
      const String checkboxError = 'error checkbox';
      final FormBuilderTextField testTextField = FormBuilderTextField(
        name: textFieldName,
        validator: (String? value) => textFieldError,
      );
      final FormBuilderCheckbox testCheckbox = FormBuilderCheckbox(
        title: const Text('title'),
        name: checkboxName,
        validator: (bool? value) => checkboxError,
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        Column(children: <Widget>[testTextField, testCheckbox]),
        autovalidateMode: AutovalidateMode.always,
      ));

      expect(
        formKey.currentState?.errors,
        equals(<String, String>{
          textFieldName: textFieldError,
          checkboxName: checkboxError,
        }),
      );
    });
    testWidgets('Should get errors when one field are invalid',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      const String textFieldError = 'error text';
      final FormBuilderTextField testTextField = FormBuilderTextField(
        name: textFieldName,
        validator: (String? value) => textFieldError,
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        testTextField,
        autovalidateMode: AutovalidateMode.always,
      ));

      expect(
        formKey.currentState?.errors,
        equals(<String, String>{textFieldName: textFieldError}),
      );
    });
    testWidgets('Should not get errors when all fields are valid',
        (WidgetTester tester) async {
      const String textFieldName = 'text';
      final FormBuilderTextField testTextField = FormBuilderTextField(
        name: textFieldName,
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        testTextField,
        autovalidateMode: AutovalidateMode.always,
      ));

      expect(formKey.currentState?.errors, equals(<String, String>{}));
    });
  });
}

// simple stateful widget that can hide and show its child with the intent of
// disposing it from the tree
class _DynamicFormFields extends StatefulWidget {
  const _DynamicFormFields({
    required this.name,
    this.valueTransformer,
  });

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
      child: FormBuilderField<String?>(
        name: widget.name,
        valueTransformer: widget.valueTransformer,
        builder: (FormFieldState<String?> field) {
          return TextField(
            onChanged: (String value) => field.didChange(value),
          );
        },
      ),
    );
  }
}
