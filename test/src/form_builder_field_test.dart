import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../form_builder_tester.dart';

void main() {
  group('FormBuilderField -', () {
    testWidgets('Reset custom error from form builder', (tester) async {
      const textFieldName = 'text1';
      const errorTextField = 'error text field';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Set custom error
      formKey.currentState?.fields[textFieldName]?.invalidate(errorTextField);
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsOneWidget);

      // Reset custom error
      formKey.currentState?.reset();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsNothing);
    });
    testWidgets('Reset custom error from form builder field', (tester) async {
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

      // Reset custom error
      textFieldKey.currentState?.reset();
      await tester.pumpAndSettle();
      expect(find.text(errorTextField), findsNothing);
    });
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
}
