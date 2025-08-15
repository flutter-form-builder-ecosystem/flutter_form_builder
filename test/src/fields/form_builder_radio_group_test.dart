import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../form_builder_tester.dart';

void main() {
  group('FormBuilderRadioGroup -', () {
    testWidgets('1,3', (WidgetTester tester) async {
      const widgetName = 'rg1';
      final testWidget = FormBuilderRadioGroup<int>(
        name: widgetName,
        options: const [
          FormBuilderFieldOption(key: ValueKey('1'), value: 1),
          FormBuilderFieldOption(key: ValueKey('2'), value: 2),
          FormBuilderFieldOption(key: ValueKey('3'), value: 3),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(formValue(widgetName), isNull);
      await tester.tap(find.byKey(const ValueKey('1')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(1));
      await tester.tap(find.byKey(const ValueKey('3')));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(3));
    });
    testWidgets(
      'When had a disabled option then can not set this value option',
      (WidgetTester tester) async {
        const widgetName = 'rg1';
        final testWidget = FormBuilderRadioGroup<int>(
          name: widgetName,
          disabled: [2],
          options: const [
            FormBuilderFieldOption(key: ValueKey('1'), value: 1),
            FormBuilderFieldOption(key: ValueKey('2'), value: 2),
            FormBuilderFieldOption(key: ValueKey('3'), value: 3),
          ],
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(formSave(), isTrue);
        expect(formValue(widgetName), isNull);
        await tester.tap(find.byKey(const ValueKey('2')));
        await tester.pumpAndSettle();
        expect(formSave(), isTrue);
        expect(formValue(widgetName), isNull);
      },
    );

    testWidgets('decoration horizontal', (WidgetTester tester) async {
      const widgetName = 'rg1';
      final testWidget = FormBuilderRadioGroup<int>(
        name: widgetName,
        orientation: OptionsOrientation.horizontal,
        wrapSpacing: 10.0,
        options: const [
          FormBuilderFieldOption(key: ValueKey('1'), value: 1),
          FormBuilderFieldOption(key: ValueKey('2'), value: 2),
        ],
        itemDecoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        ),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // this is a brittle test knowing how we use container for a border
      // there is one container for each option
      expect(find.byType(Container), findsExactly(2));
      // same as wrapSpacing
      Container foo = tester.firstWidget(find.byType(Container));
      expect(foo.margin, const EdgeInsets.only(right: 10.0));
      // verify separator counts
      expect(find.byType(VerticalDivider), findsNothing);
    });

    testWidgets('decoration vertical', (WidgetTester tester) async {
      const widgetName = 'rg1';
      final testWidget = FormBuilderRadioGroup<int>(
        name: widgetName,
        orientation: OptionsOrientation.vertical,
        wrapSpacing: 10.0,
        options: const [
          FormBuilderFieldOption(key: ValueKey('1'), value: 1),
          FormBuilderFieldOption(key: ValueKey('2'), value: 2),
        ],
        itemDecoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        ),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // this is a brittle test knowing how we use container for a border
      // there is one container for each option
      expect(find.byType(Container), findsExactly(2));
      // same as wrapSpacing
      Container foo = tester.firstWidget(find.byType(Container));
      expect(foo.margin, const EdgeInsets.only(bottom: 10.0));
      // verify separator counts
      expect(find.byType(VerticalDivider), findsNothing);
    });

    testWidgets('separators horizontal', (WidgetTester tester) async {
      const widgetName = 'rg1';
      final testWidget = FormBuilderRadioGroup<int>(
        name: widgetName,
        orientation: OptionsOrientation.horizontal,
        wrapSpacing: 10.0,
        options: const [
          FormBuilderFieldOption(key: ValueKey('1'), value: 1),
          FormBuilderFieldOption(key: ValueKey('2'), value: 2),
          FormBuilderFieldOption(key: ValueKey('3'), value: 2),
        ],
        separator: const VerticalDivider(width: 8.0, color: Colors.red),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // verify separator counts
      expect(find.byType(VerticalDivider), findsNWidgets(2));
    });

    testWidgets('separators vertical', (WidgetTester tester) async {
      const widgetName = 'rg1';
      final testWidget = FormBuilderRadioGroup<int>(
        name: widgetName,
        orientation: OptionsOrientation.vertical,
        wrapSpacing: 10.0,
        options: const [
          FormBuilderFieldOption(key: ValueKey('1'), value: 1),
          FormBuilderFieldOption(key: ValueKey('2'), value: 2),
          FormBuilderFieldOption(key: ValueKey('2'), value: 2),
        ],
        itemDecoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        ),
        separator: const VerticalDivider(width: 8.0, color: Colors.red),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // verify separator counts
      expect(find.byType(VerticalDivider), findsNWidgets(2));
    });
    testWidgets('When press tab, field will be focused', (
      WidgetTester tester,
    ) async {
      const widgetName = 'key';
      final testWidget = FormBuilderRadioGroup<int>(
        name: widgetName,
        options: const [
          FormBuilderFieldOption(key: ValueKey('1'), value: 1),
          FormBuilderFieldOption(key: ValueKey('2'), value: 2),
          FormBuilderFieldOption(key: ValueKey('3'), value: 3),
        ],
      );
      final widgetFinder = find.byWidget(testWidget);

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      final focusNode =
          formKey.currentState?.fields[widgetName]?.effectiveFocusNode;

      expect(formSave(), isTrue);
      expect(formValue(widgetName), isNull);
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
      expect(focusNode?.hasFocus, false);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, true);
      expect(focusNode?.hasFocus, true);
    });
    testWidgets(
      'when change value, onChange will be called with value changed',
      (WidgetTester tester) async {
        const widgetName = 'key';
        int? changedValue;
        final testWidget = FormBuilderRadioGroup<int>(
          name: widgetName,
          onChanged: (value) {
            changedValue = value;
          },
          options: const [
            FormBuilderFieldOption(key: ValueKey('1'), value: 1),
            FormBuilderFieldOption(key: ValueKey('2'), value: 2),
            FormBuilderFieldOption(key: ValueKey('3'), value: 3),
          ],
        );
        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(formValue(widgetName), isNull);
        await tester.tap(find.byKey(const ValueKey('2')));
        await tester.pumpAndSettle();
        expect(changedValue, equals(2));
      },
    );
    testWidgets('when is disable then can not change value', (
      WidgetTester tester,
    ) async {
      const widgetName = 'key';
      int? changedValue;
      final testWidget = FormBuilderRadioGroup<int>(
        name: widgetName,
        onChanged: (value) {
          changedValue = value;
        },
        enabled: false,
        options: const [
          FormBuilderFieldOption(key: ValueKey('1'), value: 1),
          FormBuilderFieldOption(key: ValueKey('2'), value: 2),
          FormBuilderFieldOption(key: ValueKey('3'), value: 3),
        ],
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      await tester.tap(find.byKey(const ValueKey('2')));
      await tester.pumpAndSettle();
      expect(changedValue, equals(null));
    });
  });
}
