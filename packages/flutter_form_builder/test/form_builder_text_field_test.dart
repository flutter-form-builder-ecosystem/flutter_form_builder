import 'package:flutter_form_builder/src/fields/form_builder_text_field.dart';
import 'package:flutter_test/flutter_test.dart';

import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderTextField -- Hello Planet',
      (WidgetTester tester) async {
    const newTextValue = 'Hello 🪐';
    const textFieldName = 'text1';
    final testWidget = FormBuilderTextField(
      name: textFieldName,
    );
    final widgetFinder = find.byWidget(testWidget);

    await tester.pumpWidget(buildTestableFieldWidget(testWidget));
    expect(formSave(), isTrue);
    // TODO Confirm that this should not be isEmpty
    expect(formValue(textFieldName), isNull);
    await tester.enterText(widgetFinder, newTextValue);
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), equals(newTextValue));
    await tester.enterText(widgetFinder, '');
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), isEmpty);
  });
}
