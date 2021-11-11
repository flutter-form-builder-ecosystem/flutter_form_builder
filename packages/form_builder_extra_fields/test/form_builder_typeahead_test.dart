import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_builder_extra_fields/src/fields/form_builder_typeahead.dart';

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
    expect(formFieldValue(textFieldName), initialTextValue);

    // await tester.enterText(widgetFinder, newTextValue);
    // TODO: Test typing a something in the field then choosing the first option
    /*textEditingController.text = newTextValue;
    expect(formSave(), isTrue);
    expect(formFieldValue(textFieldName), equals(newTextValue));*/

    // await tester.enterText(widgetFinder, newTextValue);
    testWidgetKey.currentState!.didChange(newTextValue);
    expect(textEditingController.text, newTextValue);
    expect(formSave(), isTrue);
    expect(formFieldValue(textFieldName), equals(newTextValue));

    // await tester.enterText(widgetFinder, '');
    testWidgetKey.currentState!.didChange(null);
    expect(formSave(), isTrue);
    expect(formFieldValue(textFieldName), isNull);
  });
}
