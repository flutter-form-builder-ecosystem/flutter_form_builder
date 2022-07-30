import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../form_builder_tester.dart';

void main() {
  group('Form Builder Field -', () {
    testWidgets('Reset custom error from form builder', (tester) async {
      const textFieldName = 'text1';
      const errorTextField = 'error text field';
      final testWidget = FormBuilderTextField(name: textFieldName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Set custom error
      formKey.currentState
          ?.invalidateField(name: textFieldName, errorText: errorTextField);
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
  });
}
