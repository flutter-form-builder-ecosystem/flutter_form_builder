import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'form_builder_tester.dart';

void main() {
  group('FormBuilderFilterChip --', () {
    testWidgets('basic', (WidgetTester tester) async {
      const String widgetName = 'formBuilderFilterChip';

      final FormBuilderFilterChip<int> testWidget = FormBuilderFilterChip<int>(
        name: widgetName,
        options: const <FormBuilderChipOption<int>>[
          FormBuilderChipOption<int>(key: ValueKey<String>('1'), value: 1),
          FormBuilderChipOption<int>(key: ValueKey<String>('2'), value: 2),
          FormBuilderChipOption<int>(key: ValueKey<String>('3'), value: 3),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(formValue<List<int>?>(widgetName), equals(null));
      await tester.tap(find.byKey(const ValueKey<String>('1')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue<List<int>?>(widgetName), equals(<int>[1]));
      await tester.tap(find.byKey(const ValueKey<String>('3')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue<List<int>?>(widgetName), equals(<int>[1, 3]));
    });
    group('initial value -', () {
      testWidgets('to FormBuilder', (WidgetTester tester) async {
        const String widgetName = 'fc2';

        final FormBuilderFilterChip<int> testWidget =
            FormBuilderFilterChip<int>(
          name: widgetName,
          options: const <FormBuilderChipOption<int>>[
            FormBuilderChipOption<int>(key: ValueKey<String>('1'), value: 1),
            FormBuilderChipOption<int>(key: ValueKey<String>('2'), value: 2),
            FormBuilderChipOption<int>(key: ValueKey<String>('3'), value: 3),
          ],
        );
        await tester.pumpWidget(buildTestableFieldWidget(
          testWidget,
          initialValue: <String, dynamic>{
            widgetName: <int>[1]
          },
        ));

        await tester.ensureVisible(find.byKey(const ValueKey<String>('1')));
        expect(formInstantValue(widgetName), equals(<int>[1]));
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[1]));
        await tester.tap(find.byKey(const ValueKey<String>('1')));
        await tester.pumpAndSettle();
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[]));
        await tester.tap(find.byKey(const ValueKey<String>('3')));
        await tester.pumpAndSettle();
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[3]));
      });
      testWidgets('to Widget', (WidgetTester tester) async {
        const String widgetName = 'fc3';

        final FormBuilderFilterChip<int> testWidget =
            FormBuilderFilterChip<int>(
          name: widgetName,
          initialValue: const <int>[1],
          options: const <FormBuilderChipOption<int>>[
            FormBuilderChipOption<int>(key: ValueKey<String>('1'), value: 1),
            FormBuilderChipOption<int>(key: ValueKey<String>('2'), value: 2),
            FormBuilderChipOption<int>(key: ValueKey<String>('3'), value: 3),
          ],
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.byKey(const ValueKey<String>('1')));
        expect(formInstantValue(widgetName), equals(<int>[1]));
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[1]));
        await tester.tap(find.byKey(const ValueKey<String>('1')));
        await tester.pumpAndSettle();
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[]));
        await tester.tap(find.byKey(const ValueKey<String>('3')));
        await tester.pumpAndSettle();
        expect(formSave(), isTrue);
        expect(formValue<List<int>?>(widgetName), equals(<int>[3]));
      });
    });
  });
}
