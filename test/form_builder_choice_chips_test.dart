import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'form_builder_tester.dart';

void main() {
  group('FormBuilderChoiceChip --', () {
    testWidgets('basic', (WidgetTester tester) async {
      const widgetName = 'cc1';

      final testWidget = FormBuilderChoiceChip<int>(
        name: widgetName,
        options: const [
          FormBuilderChipOption(key: ValueKey('1'), value: 1),
          FormBuilderChipOption(key: ValueKey('2'), value: 2),
          FormBuilderChipOption(key: ValueKey('3'), value: 3),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(formValue<int?>(widgetName), isNull);
      await tester.tap(find.byKey(const ValueKey('1')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue<int?>(widgetName), equals(1));
      await tester.tap(find.byKey(const ValueKey('3')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue<int?>(widgetName), equals(3));
    });
  });
  group('initial value -', () {
    testWidgets('to FormBuilder', (WidgetTester tester) async {
      const widgetName = 'cc2';

      final testWidget = FormBuilderChoiceChip<int>(
        name: widgetName,
        options: const [
          FormBuilderChipOption(key: ValueKey('1'), value: 1),
          FormBuilderChipOption(key: ValueKey('2'), value: 2),
          FormBuilderChipOption(key: ValueKey('3'), value: 3),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(
        testWidget,
        initialValue: {widgetName: 1},
      ));

      await tester.ensureVisible(find.byKey(const ValueKey('1')));
      expect(formInstantValue(widgetName), equals(1));
      expect(formSave(), isTrue);
      expect(formValue<int?>(widgetName), equals(1));
      await tester.tap(find.byKey(const ValueKey('3')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue<int?>(widgetName), equals(3));
    });
    testWidgets('to Widget', (WidgetTester tester) async {
      const widgetName = 'cc3';

      final testWidget = FormBuilderChoiceChip<int>(
        name: widgetName,
        initialValue: 1,
        options: const [
          FormBuilderChipOption(key: ValueKey('1'), value: 1),
          FormBuilderChipOption(key: ValueKey('2'), value: 2),
          FormBuilderChipOption(key: ValueKey('3'), value: 3),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const ValueKey('1')));
      expect(formInstantValue(widgetName), equals(1));
      expect(formSave(), isTrue);
      expect(formValue<int?>(widgetName), equals(1));
      await tester.tap(find.byKey(const ValueKey('3')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue<int?>(widgetName), equals(3));
    });
  });
}
