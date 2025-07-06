import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../form_builder_tester.dart';

void main() {
  group('FormBuilderFieldDecoration -', () {
    testWidgets('when change the error text then the field should be invalid', (
      WidgetTester tester,
    ) async {
      final decorationFieldKey = GlobalKey<FormBuilderFieldDecorationState>();
      const name = 'testField';
      const errorTextField = 'error text field';
      final widget = FormBuilderFieldDecoration<String>(
        key: decorationFieldKey,
        name: name,
        builder: (FormFieldState<String?> field) {
          return InputDecorator(
            decoration: (field as FormBuilderFieldDecorationState).decoration,
            child: TextField(
              onChanged: (value) {
                field.didChange(value);
              },
            ),
          );
        },
      );

      await tester.pumpWidget(buildTestableFieldWidget(widget));

      // Initially, the field should be valid
      expect(decorationFieldKey.currentState?.isValid, isTrue);

      decorationFieldKey.currentState?.invalidate(errorTextField);

      // The field should be invalid
      expect(decorationFieldKey.currentState?.isValid, isFalse);

      // Clear the error
      decorationFieldKey.currentState?.reset();

      // The field should be valid again
      expect(decorationFieldKey.currentState?.isValid, isTrue);
    });

    testWidgets('when set errorBuilder then show a custom widget on error', (
      widgetTester,
    ) async {
      final decorationFieldKey = GlobalKey<FormBuilderFieldDecorationState>();
      const name = 'testField';
      const errorTextField = 'error text field';
      final errorTextKey = Key('errorTextKey');
      final widget = FormBuilderFieldDecoration<String>(
        key: decorationFieldKey,
        name: name,
        errorBuilder: (context, errorText) {
          return Text(
            errorText,
            key: errorTextKey,
            style: const TextStyle(color: Colors.red),
          );
        },
        builder: (FormFieldState<String?> field) {
          return InputDecorator(
            decoration: (field as FormBuilderFieldDecorationState).decoration,
            child: TextField(
              onChanged: (value) {
                field.didChange(value);
              },
            ),
          );
        },
      );

      await widgetTester.pumpWidget(buildTestableFieldWidget(widget));

      // Initially, the field should be valid
      expect(decorationFieldKey.currentState?.isValid, isTrue);

      decorationFieldKey.currentState?.invalidate(errorTextField);

      // The field should be invalid
      expect(decorationFieldKey.currentState?.isValid, isFalse);

      await widgetTester.pumpAndSettle();

      // Check if the custom error widget is displayed
      expect(find.text(errorTextField), findsOneWidget);
      expect(find.byKey(errorTextKey), findsOneWidget);
    });

    group('decoration enabled -', () {
      testWidgets(
        'when change the error text then the field should be invalid',
        (WidgetTester tester) async {
          final decorationFieldKey =
              GlobalKey<FormBuilderFieldDecorationState>();
          const name = 'testField';
          const errorTextField = 'error text field';
          final widget = FormBuilderFieldDecoration<String>(
            key: decorationFieldKey,
            name: name,
            builder: (FormFieldState<String?> field) {
              return InputDecorator(
                decoration:
                    (field as FormBuilderFieldDecorationState).decoration,
                child: TextField(
                  onChanged: (value) {
                    field.didChange(value);
                  },
                ),
              );
            },
          );

          await tester.pumpWidget(buildTestableFieldWidget(widget));

          // Initially, the field should be valid
          expect(decorationFieldKey.currentState?.isValid, isTrue);

          decorationFieldKey.currentState?.invalidate(errorTextField);

          // The field should be invalid
          expect(decorationFieldKey.currentState?.isValid, isFalse);

          // Clear the error
          decorationFieldKey.currentState?.reset();

          // The field should be valid again
          expect(decorationFieldKey.currentState?.isValid, isTrue);
        },
      );
      test(
        'when enable property on decoration is false and enabled true, then throw an assert',
        () async {
          final decorationFieldKey =
              GlobalKey<FormBuilderFieldDecorationState>();
          const name = 'testField';

          expect(
            () => FormBuilderFieldDecoration<String>(
              key: decorationFieldKey,
              name: name,
              decoration: const InputDecoration(enabled: false),
              builder: (FormFieldState<String?> field) {
                return InputDecorator(
                  decoration:
                      (field as FormBuilderFieldDecorationState).decoration,
                  child: TextField(
                    onChanged: (value) {
                      field.didChange(value);
                    },
                  ),
                );
              },
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'when enable property on decoration is false and enable is false, then build normally',
        () async {
          final decorationFieldKey =
              GlobalKey<FormBuilderFieldDecorationState>();
          const name = 'testField';

          expect(
            () => FormBuilderFieldDecoration<String>(
              key: decorationFieldKey,
              name: name,
              decoration: const InputDecoration(enabled: false),
              enabled: false,
              builder: (FormFieldState<String?> field) {
                return InputDecorator(
                  decoration:
                      (field as FormBuilderFieldDecorationState).decoration,
                  child: TextField(
                    onChanged: (value) {
                      field.didChange(value);
                    },
                  ),
                );
              },
            ),
            returnsNormally,
          );
        },
      );
      test(
        'when decoration is default (enabled: true), then build normally',
        () async {
          final decorationFieldKey =
              GlobalKey<FormBuilderFieldDecorationState>();
          const name = 'testField';

          expect(
            () => FormBuilderFieldDecoration<String>(
              key: decorationFieldKey,
              name: name,
              builder: (FormFieldState<String?> field) {
                return InputDecorator(
                  decoration:
                      (field as FormBuilderFieldDecorationState).decoration,
                  child: TextField(
                    onChanged: (value) {
                      field.didChange(value);
                    },
                  ),
                );
              },
            ),
            returnsNormally,
          );
        },
      );
      test(
        'when decoration is default (enabled: true) and enable false, then build normally',
        () async {
          final decorationFieldKey =
              GlobalKey<FormBuilderFieldDecorationState>();
          const name = 'testField';

          expect(
            () => FormBuilderFieldDecoration<String>(
              key: decorationFieldKey,
              name: name,
              enabled: false,
              builder: (FormFieldState<String?> field) {
                return InputDecorator(
                  decoration:
                      (field as FormBuilderFieldDecorationState).decoration,
                  child: TextField(
                    onChanged: (value) {
                      field.didChange(value);
                    },
                  ),
                );
              },
            ),
            returnsNormally,
          );
        },
      );
    });
  });
}
