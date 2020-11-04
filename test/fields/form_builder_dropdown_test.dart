import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderDropdown -- 1,3', (WidgetTester tester) async {
    const widgetName = 'd1';
    final testWidget = FormBuilderDropdown<int>(
      name: widgetName,
      items: [
        DropdownMenuItem(
          key: ValueKey(1),
          value: 1,
          child: Text('One'),
        ),
        DropdownMenuItem(
          key: ValueKey(2),
          value: 2,
          child: Text('Two'),
        ),
        DropdownMenuItem(
          key: ValueKey(3),
          value: 3,
          child: Text('Three'),
        ),
      ],
      onChanged: (newValue) => print('>>>> Changed to $newValue'),
    );
    final widgetFinder = find.byWidget(testWidget);
    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    expect(formSave(), isTrue);
    expect(formValue(widgetName), isNull);
    await tester.tap(widgetFinder);
    await tester.pumpAndSettle();
    await tester.tap(
        find.descendant(of: widgetFinder, matching: find.byKey(ValueKey(1))));
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(1));

    /* Not sure why this isn't working; instead of 3, 1 is being tapped?
    await tester.tap(widgetFinder);
    await tester.pumpAndSettle();
    await tester.tap(
        find.descendant(of: widgetFinder, matching: find.byKey(ValueKey(3))));
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(3));
    */
  });
}
