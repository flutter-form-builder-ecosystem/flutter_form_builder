import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'form_builder_tester.dart';

void main() {
  testWidgets('FormBuilderTypeahead -- Two', (WidgetTester tester) async {
    const options = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven'];
    const initialTextValue = 'One';
    const newTextValue = 'Two';
    const textFieldName = 'typeahead1';
    final textEditingController = TextEditingController();
    final testWidgetKey = GlobalKey<FormBuilderFieldState>();

    final testWidget = FormBuilderTypeAhead<String>(
      key: testWidgetKey,
      name: textFieldName,
      initialValue: initialTextValue,
      controller: textEditingController,
      itemBuilder: (context, country) {
        return ListTile(title: Text(country));
      },
      suggestionsCallback: (query) {
        if (query.isNotEmpty) {
          var lowercaseQuery = query.toLowerCase();
          return options.where((country) {
            return country.toLowerCase().contains(lowercaseQuery);
          }).toList(growable: false)
            ..sort((a, b) => a
                .toLowerCase()
                .indexOf(lowercaseQuery)
                .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
        } else {
          return options;
        }
      },
    );
    // final widgetFinder = find.byWidget(testWidget);

    await tester.pumpWidget(buildTestableFieldWidget(testWidget));
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), initialTextValue);

    // await tester.enterText(widgetFinder, newTextValue);
    textEditingController.text = newTextValue;
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), equals(newTextValue));

    // await tester.enterText(widgetFinder, newTextValue);
    testWidgetKey.currentState.didChange(initialTextValue);
    expect(textEditingController.text, initialTextValue);
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), equals(initialTextValue));

    // await tester.enterText(widgetFinder, '');
    textEditingController.text = '';
    expect(formSave(), isTrue);
    expect(formValue(textFieldName), isEmpty);
  });
}
