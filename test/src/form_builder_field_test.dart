import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../form_builder_tester.dart';

void main() {
  group('FormBuilderField -', () {
    group('custom error -', () {
      testWidgets('Should show custom error when invalidate field',
          (WidgetTester tester) async {
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String textFieldName = 'text2';
        const String errorTextField = 'error text field';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        // Set custom error
        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();
        expect(find.text(errorTextField), findsOneWidget);
      });
    });

    group('isValid -', () {
      testWidgets('Should invalid when set custom error',
          (WidgetTester tester) async {
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String textFieldName = 'text';
        const String errorTextField = 'error text field';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        // Set custom error
        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.isValid, isFalse);
      });
      testWidgets(
          'Should valid when no has error and autovalidateMode is always',
          (WidgetTester tester) async {
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String textFieldName = 'text';
        const String errorTextField = 'error text field';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          autovalidateMode: AutovalidateMode.always,
          validator: (String? value) =>
              value == null || value.isEmpty ? errorTextField : null,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.isValid, isFalse);

        final Finder widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, 'test');
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.isValid, isTrue);
      });
      testWidgets(
          'Should invalid when has error and autovalidateMode is always',
          (WidgetTester tester) async {
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String textFieldName = 'text';
        const String errorTextField = 'error text field';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          autovalidateMode: AutovalidateMode.always,
          validator: (String? value) =>
              value == null || value.length < 10 ? errorTextField : null,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.isValid, isFalse);

        final Finder widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, 'test');
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.isValid, isFalse);
      });
    });

    group('hasErrors -', () {
      testWidgets('Should has errors when set custom error',
          (WidgetTester tester) async {
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String textFieldName = 'text';
        const String errorTextField = 'error text field';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        // Set custom error
        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.hasError, isTrue);
      });
      testWidgets('Should no has errors when is empty and no has validators',
          (WidgetTester tester) async {
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String textFieldName = 'text';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        // Set custom error
        textFieldKey.currentState?.validate();
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.hasError, isFalse);
      });
    });

    group('valueIsValid -', () {
      testWidgets(
          'Should value is valid when validator passes, despite set custom error',
          (WidgetTester tester) async {
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String textFieldName = 'text';
        const String errorTextField = 'error text field';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        // Set custom error
        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.valueIsValid, isTrue);
      });
    });

    group('valueHasError -', () {
      testWidgets('Should value is invalid when validator passes',
          (WidgetTester tester) async {
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String textFieldName = 'text';
        const String invalidValue = 'invalid';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: invalidValue,
          validator: (String? value) =>
              (value == invalidValue) ? 'error' : null,
          autovalidateMode: AutovalidateMode.always,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.valueHasError, isTrue);
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
          validator: (String? value) =>
              value == null || value.isEmpty ? errorTextField : null,
          autovalidateMode: AutovalidateMode.always,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));
        await tester.pumpAndSettle();

        expect(find.text(errorTextField), findsOneWidget);
      });
      testWidgets(
          'Should show error when AutovalidateMode is onUserInteraction and change field',
          (WidgetTester tester) async {
        const String textFieldName = 'text4';
        const String errorTextField = 'error text field';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) => errorTextField,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));
        expect(find.text(errorTextField), findsNothing);

        await tester.enterText(find.byWidget(testWidget), 'hola');
        await tester.pumpAndSettle();

        expect(find.text(errorTextField), findsOneWidget);
      });
    });

    group('isDirty - ', () {
      testWidgets('Should not dirty by default', (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.isDirty, false);
      });
      testWidgets('Should dirty when update field value by user',
          (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final Finder widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, 'test');

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should dirty when update field value by method',
          (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should dirty when update field with initial value by user',
          (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: 'hi',
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final Finder widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, 'test');

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should dirty when update field with initial value by method',
          (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: 'hi',
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should not dirty when reset field value',
          (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.isDirty, false);
      });
      testWidgets('Should not dirty when reset field with initial value',
          (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: 'hi',
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.isDirty, false);
      });
    });

    group('isTouched - ', () {
      testWidgets('Should not touched by default', (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.isTouched, false);
      });
      testWidgets('Should touched when focus input',
          (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final Finder widgetFinder = find.byWidget(testWidget);
        await tester.tap(widgetFinder);

        expect(textFieldKey.currentState?.isTouched, true);
      });
    });

    group('reset -', () {
      testWidgets('Should reset to null when call reset',
          (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        final FormBuilderTextField testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.value, null);
      });
      testWidgets('Should reset to initial when call reset',
          (WidgetTester tester) async {
        const String textFieldName = 'text';
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String initialValue = 'test';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: initialValue,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('hello');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.value, equals(initialValue));
      });
      testWidgets(
          'Should reset custom error when invalidate field and then reset',
          (WidgetTester tester) async {
        final GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>
            textFieldKey = GlobalKey<
                FormBuilderFieldState<FormBuilderField<String>, dynamic>>();
        const String textFieldName = 'text';
        const String errorTextField = 'error text field';
        final FormBuilderTextField testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.invalidate(errorTextField);
        await tester.pumpAndSettle();

        // Reset custom error
        textFieldKey.currentState?.reset();
        await tester.pumpAndSettle();
        expect(find.text(errorTextField), findsNothing);
      });
    });
  });
}
