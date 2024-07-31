import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderCheckboxGroup -- 1,3', (WidgetTester tester) async {
    const String widgetName = 'cbg1';
    final FormBuilderCheckboxGroup<int> testWidget =
        FormBuilderCheckboxGroup<int>(
      name: widgetName,
      options: const <FormBuilderFieldOption<int>>[
        FormBuilderFieldOption<int>(key: ValueKey<String>('1'), value: 1),
        FormBuilderFieldOption<int>(key: ValueKey<String>('2'), value: 2),
        FormBuilderFieldOption<int>(key: ValueKey<String>('3'), value: 3),
      ],
    );
    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    expect(formSave(), isTrue);
    expect(formValue(widgetName), isNull);
    await tester.tap(find.byKey(const ValueKey<String>('1')));
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(const <int>[1]));
    await tester.tap(find.byKey(const ValueKey<String>('3')));
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(const <int>[1, 3]));
  });

  testWidgets('FormBuilderCheckboxGroup -- decoration horizontal',
      (WidgetTester tester) async {
    const String widgetName = 'cbg1';
    final FormBuilderCheckboxGroup<int> testWidget =
        FormBuilderCheckboxGroup<int>(
      name: widgetName,
      orientation: OptionsOrientation.horizontal,
      wrapSpacing: 10.0,
      options: const <FormBuilderFieldOption<int>>[
        FormBuilderFieldOption<int>(key: ValueKey<String>('1'), value: 1),
        FormBuilderFieldOption<int>(key: ValueKey<String>('2'), value: 2),
      ],
      itemDecoration:
          BoxDecoration(border: Border.all(color: Colors.blueAccent)),
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

  testWidgets('FormBuilderCheckboxGroup -- decoration vertical',
      (WidgetTester tester) async {
    const String widgetName = 'cbg1';
    final FormBuilderCheckboxGroup<int> testWidget =
        FormBuilderCheckboxGroup<int>(
      name: widgetName,
      orientation: OptionsOrientation.vertical,
      wrapSpacing: 10.0,
      options: const <FormBuilderFieldOption<int>>[
        FormBuilderFieldOption<int>(key: ValueKey<String>('1'), value: 1),
        FormBuilderFieldOption<int>(key: ValueKey<String>('2'), value: 2),
      ],
      itemDecoration:
          BoxDecoration(border: Border.all(color: Colors.blueAccent)),
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

  testWidgets('FormBuilderCheckboxGroup -- separator horizontal',
      (WidgetTester tester) async {
    const String widgetName = 'cbg1';
    final FormBuilderCheckboxGroup<int> testWidget =
        FormBuilderCheckboxGroup<int>(
      name: widgetName,
      orientation: OptionsOrientation.horizontal,
      wrapSpacing: 10.0,
      options: const <FormBuilderFieldOption<int>>[
        FormBuilderFieldOption<int>(key: ValueKey<String>('1'), value: 1),
        FormBuilderFieldOption<int>(key: ValueKey<String>('2'), value: 2),
        FormBuilderFieldOption<int>(key: ValueKey<String>('3'), value: 2),
      ],
      separator: const VerticalDivider(width: 8.0, color: Colors.red),
    );
    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    // verify separator counts
    expect(find.byType(VerticalDivider), findsNWidgets(2));
  });

  testWidgets('FormBuilderCheckboxGroup -- separator vertical',
      (WidgetTester tester) async {
    const String widgetName = 'cbg1';
    final FormBuilderCheckboxGroup<int> testWidget =
        FormBuilderCheckboxGroup<int>(
      name: widgetName,
      orientation: OptionsOrientation.vertical,
      wrapSpacing: 10.0,
      options: const <FormBuilderFieldOption<int>>[
        FormBuilderFieldOption<int>(key: ValueKey<String>('1'), value: 1),
        FormBuilderFieldOption<int>(key: ValueKey<String>('2'), value: 2),
        FormBuilderFieldOption<int>(key: ValueKey<String>('3'), value: 2),
      ],
      separator: const VerticalDivider(width: 8.0, color: Colors.red),
    );
    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    // verify separator counts
    expect(find.byType(VerticalDivider), findsNWidgets(2));
  });
  testWidgets('FormBuilderCheckboxGroup -- didChange',
      (WidgetTester tester) async {
    const String fieldName = 'cbg1';
    final FormBuilderCheckboxGroup<int> testWidget =
        FormBuilderCheckboxGroup<int>(
      name: fieldName,
      options: const <FormBuilderFieldOption<int>>[
        FormBuilderFieldOption<int>(key: ValueKey<String>('1'), value: 1),
        FormBuilderFieldOption<int>(key: ValueKey<String>('2'), value: 2),
        FormBuilderFieldOption<int>(key: ValueKey<String>('3'), value: 3),
      ],
    );
    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    expect(formSave(), isTrue);
    expect(formValue(fieldName), isNull);
    formFieldDidChange(fieldName, <int>[1, 3]);
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(fieldName), <int>[1, 3]);

    Checkbox checkbox1 = tester
        .element(find.byKey(const ValueKey<String>('1')))
        .findAncestorWidgetOfExactType<Row>()!
        .children
        .first as Checkbox;
    Checkbox checkbox2 = tester
        .element(find.byKey(const ValueKey<String>('2')))
        .findAncestorWidgetOfExactType<Row>()!
        .children
        .first as Checkbox;
    Checkbox checkbox3 = tester
        .element(find.byKey(const ValueKey<String>('3')))
        .findAncestorWidgetOfExactType<Row>()!
        .children
        .first as Checkbox;

    // checkboxes should represent the state of the didChange value
    expect(checkbox1.value, true);
    expect(checkbox2.value, false);
    expect(checkbox3.value, true);
  });
}
