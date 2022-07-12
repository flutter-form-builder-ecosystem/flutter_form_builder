import 'package:flutter/material.dart';
import 'package:flutter_form_builder/src/fields/form_builder_dropdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderDropdown -- 3,1', (WidgetTester tester) async {
    const widgetName = 'd1';
    final testWidget = FormBuilderDropdown<int>(
      name: widgetName,
      items: const [
        DropdownMenuItem(
          value: 1,
          child: Text('One'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Two'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Three'),
        ),
      ],
    );
    final widgetFinder = find.byWidget(testWidget);
    await tester.pumpWidget(buildTestableFieldWidget(testWidget));

    expect(formSave(), isTrue);
    expect(formValue(widgetName), isNull);
    await tester.tap(widgetFinder);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Three').last);
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(3));

    await tester.tap(find.text('Three').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('One').last);
    await tester.pumpAndSettle();
    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(1));
  });
}
