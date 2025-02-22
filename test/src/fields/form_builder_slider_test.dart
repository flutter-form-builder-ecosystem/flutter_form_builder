import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/src/fields/form_builder_slider.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../form_builder_tester.dart';

void main() {
  group('FormBuilderSlider -', () {
    testWidgets('Basic', (WidgetTester tester) async {
      const widgetName = 'slider1';
      final testWidget = FormBuilderSlider(
        name: widgetName,
        initialValue: 2,
        min: 0,
        max: 10,
        divisions: 20,
        decoration: const InputDecoration(labelText: 'Number of things'),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(2.0));
      await tester.tap(find.byType(Slider));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(5.0));
    });

    testWidgets('When press tab, field will be focused', (
      WidgetTester tester,
    ) async {
      const widgetName = 'key';
      final testWidget = FormBuilderSlider(
        name: widgetName,
        initialValue: 2,
        min: 0,
        max: 10,
      );
      final widgetFinder = find.byWidget(testWidget);

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      final focusNode =
          formKey.currentState?.fields[widgetName]?.effectiveFocusNode;

      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(2.0));
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
      expect(focusNode?.hasFocus, false);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, true);
      expect(focusNode?.hasFocus, true);
    });
  });
}
