import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../form_builder_tester.dart';

void main() {
  group('FormBuilderField -', () {
    group('custom error -', () {
      testWidgets('Should show custom error when invalidate field',
          (tester) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const textFieldName = 'text2';
        const errorTextField = 'error text field';
        final testWidget = FormBuilderTextField(
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

    group('autovalidateMode -', () {
      testWidgets(
          'Should show error when init form and AutovalidateMode is always',
          (tester) async {
        const textFieldName = 'text4';
        const errorTextField = 'error text field';
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          validator: (value) => errorTextField,
        );
        await tester.pumpWidget(
          buildTestableFieldWidget(
            testWidget,
            autovalidateMode: AutovalidateMode.always,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(errorTextField), findsOneWidget);
      });
    });

    group('isDirty - ', () {
      testWidgets('Should not dirty by default', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.isDirty, false);
      });
      testWidgets('Should dirty when update field value by user',
          (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, 'test');

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should dirty when update field value by method',
          (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should dirty when update field with initial value by user',
          (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: 'hi',
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final widgetFinder = find.byWidget(testWidget);
        await tester.enterText(widgetFinder, 'test');

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should dirty when update field with initial value by method',
          (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
          name: textFieldName,
          key: textFieldKey,
          initialValue: 'hi',
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();

        expect(textFieldKey.currentState?.isDirty, true);
      });
      testWidgets('Should not dirty when reset field value', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.isDirty, false);
      });
      testWidgets('Should not dirty when reset field with initial value',
          (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget = FormBuilderTextField(
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
      testWidgets('Should not touched by default', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(textFieldKey.currentState?.isTouched, false);
      });
      testWidgets('Should touched when focus input', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        final widgetFinder = find.byWidget(testWidget);
        await tester.tap(widgetFinder);

        expect(textFieldKey.currentState?.isTouched, true);
      });
    });

    group('reset -', () {
      testWidgets('Should reset to null when call reset', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        final testWidget =
            FormBuilderTextField(name: textFieldName, key: textFieldKey);
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        textFieldKey.currentState?.setValue('test');
        await tester.pumpAndSettle();
        textFieldKey.currentState?.reset();

        expect(textFieldKey.currentState?.value, null);
      });
      testWidgets('Should reset to initial when call reset', (tester) async {
        const textFieldName = 'text';
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const initialValue = 'test';
        final testWidget = FormBuilderTextField(
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
          (tester) async {
        final textFieldKey = GlobalKey<FormBuilderFieldState>();
        const textFieldName = 'text';
        const errorTextField = 'error text field';
        final testWidget = FormBuilderTextField(
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
