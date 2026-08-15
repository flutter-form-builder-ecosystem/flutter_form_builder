import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../form_builder_tester.dart';

void main() {
  group('FormBuilderCheckbox -', () {
    testWidgets('Off/On/Off', (WidgetTester tester) async {
      const widgetName = 'cb1';
      final testWidget = FormBuilderCheckbox(
        name: widgetName,
        title: const Text('Checkbox 1'),
        initialValue: false,
      );
      final widgetFinder = find.byWidget(testWidget);

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(formValue(widgetName), isFalse);
      await tester.tap(widgetFinder);
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), isTrue);
      await tester.tap(widgetFinder);
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), isFalse);
    });
    testWidgets('error state reaches the checkbox', (
      WidgetTester tester,
    ) async {
      const widgetName = 'cb_error';
      final testWidget = FormBuilderCheckbox(
        name: widgetName,
        title: const Text('Accept terms'),
        initialValue: false,
        validator: (value) => value == true ? null : 'required',
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      CheckboxListTile tile() =>
          tester.widget<CheckboxListTile>(find.byType(CheckboxListTile));

      expect(tile().isError, isFalse);

      expect(formSave(), isFalse);
      await tester.pumpAndSettle();
      expect(tile().isError, isTrue);

      await tester.tap(find.byType(CheckboxListTile));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      await tester.pumpAndSettle();
      expect(tile().isError, isFalse);
    });
    testWidgets('When press tab, field will be focused', (
      WidgetTester tester,
    ) async {
      const widgetName = 'cb1';
      final testWidget = FormBuilderCheckbox(
        name: widgetName,
        title: const Text('Checkbox 1'),
        initialValue: false,
      );
      final widgetFinder = find.byWidget(testWidget);

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      final focusNode =
          formKey.currentState?.fields[widgetName]?.effectiveFocusNode;

      expect(formSave(), isTrue);
      expect(formValue(widgetName), isFalse);
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
      expect(focusNode?.hasFocus, false);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, true);
      expect(focusNode?.hasFocus, true);
    });
    // Regression test for https://github.com/flutter-form-builder-ecosystem/flutter_form_builder/issues/1495
    testWidgets(
      'Programmatic didChange does not steal focus from another field',
      (WidgetTester tester) async {
        const textFieldName = 'text';
        const checkboxName = 'checkbox';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FormBuilder(
                key: formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: textFieldName,
                      onChanged: (v) {
                        formKey.currentState?.fields[checkboxName]?.didChange(
                          true,
                        );
                      },
                    ),
                    FormBuilderCheckbox(
                      name: checkboxName,
                      title: const Text('Checkbox'),
                      initialValue: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        // Tap the text field to focus it
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();

        final textFocusNode =
            formKey.currentState?.fields[textFieldName]?.effectiveFocusNode;
        final checkboxFocusNode =
            formKey.currentState?.fields[checkboxName]?.effectiveFocusNode;

        expect(textFocusNode?.hasFocus, isTrue);
        expect(checkboxFocusNode?.hasFocus, isFalse);

        // Type text — triggers onChanged which calls checkbox.didChange(true)
        await tester.enterText(find.byType(TextField), 'hello');
        await tester.pumpAndSettle();

        // The checkbox value should update but focus must stay on the text field
        expect(formKey.currentState?.fields[checkboxName]?.value, isTrue);
        expect(textFocusNode?.hasFocus, isTrue);
        expect(checkboxFocusNode?.hasFocus, isFalse);
      },
    );
  });
}
