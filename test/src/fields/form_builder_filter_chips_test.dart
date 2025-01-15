import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../form_builder_tester.dart';

void main() {
  group('FormBuilderFilterChip --', () {
    testWidgets('basic', (WidgetTester tester) async {
      const widgetName = 'formBuilderFilterChip';

      final testWidget = FormBuilderFilterChips<int>(
        name: widgetName,
        options: const [
          FormBuilderChipOption(key: ValueKey('1'), value: 1),
          FormBuilderChipOption(key: ValueKey('2'), value: 2),
          FormBuilderChipOption(key: ValueKey('3'), value: 3),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(formValue<List<int>?>(widgetName), equals(null));
      await tester.tap(find.byKey(const ValueKey('1')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue<List<int>?>(widgetName), equals(<int>[1]));
      await tester.tap(find.byKey(const ValueKey('3')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue<List<int>?>(widgetName), equals(<int>[1, 3]));
    });
    group('initial value -', () {
      testWidgets('to FormBuilder', (WidgetTester tester) async {
        const widgetName = 'fc2';

        final testWidget = FormBuilderFilterChips<int>(
          name: widgetName,
          options: const [
            FormBuilderChipOption(key: ValueKey('1'), value: 1),
            FormBuilderChipOption(key: ValueKey('2'), value: 2),
            FormBuilderChipOption(key: ValueKey('3'), value: 3),
          ],
        );
        await tester.pumpWidget(buildTestableFieldWidget(
          testWidget,
          initialValue: {
            widgetName: [1]
          },
        ));

        await tester.ensureVisible(find.byKey(const ValueKey('1')));
        expect(formInstantValue(widgetName), equals(<int>[1]));
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[1]));
        await tester.tap(find.byKey(const ValueKey('1')));
        await tester.pumpAndSettle();
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[]));
        await tester.tap(find.byKey(const ValueKey('3')));
        await tester.pumpAndSettle();
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[3]));
      });
      testWidgets('to Widget', (WidgetTester tester) async {
        const widgetName = 'fc3';

        final testWidget = FormBuilderFilterChips<int>(
          name: widgetName,
          initialValue: const [1],
          options: const [
            FormBuilderChipOption(key: ValueKey('1'), value: 1),
            FormBuilderChipOption(key: ValueKey('2'), value: 2),
            FormBuilderChipOption(key: ValueKey('3'), value: 3),
          ],
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.byKey(const ValueKey('1')));
        expect(formInstantValue(widgetName), equals(<int>[1]));
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[1]));
        await tester.tap(find.byKey(const ValueKey('1')));
        await tester.pumpAndSettle();
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[]));
        await tester.tap(find.byKey(const ValueKey('3')));
        await tester.pumpAndSettle();
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[3]));
      });
    });
    testWidgets('When press tab, field will be focused',
        (WidgetTester tester) async {
      const widgetName = 'key';
      final testWidget = FormBuilderFilterChips<int>(
        name: widgetName,
        options: const [
          FormBuilderChipOption(key: ValueKey('1'), value: 1),
          FormBuilderChipOption(key: ValueKey('2'), value: 2),
          FormBuilderChipOption(key: ValueKey('3'), value: 3),
        ],
      );
      final widgetFinder = find.byWidget(testWidget);

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      final focusNode =
          formKey.currentState?.fields[widgetName]?.effectiveFocusNode;

      expect(formSave(), isTrue);
      expect(formValue<List<int>?>(widgetName), equals(null));
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
      expect(focusNode?.hasFocus, false);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, true);
      expect(focusNode?.hasFocus, true);
    });
  });
}
