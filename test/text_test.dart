import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets('Smoke test textfield form', (WidgetTester tester) async {
    final formKey = GlobalKey<FormBuilderState>();
    await insertWidget(
        formKey: formKey,
        tester: tester,
        child: FormBuilderTextField(
          attribute: "name",
          decoration: InputDecoration(labelText: "Name"),
          validators: [
            FormBuilderValidators.required(),
          ],
        ));

    await tester.pump();

    final nameInputField = find.byKey(Key('name'));
    expect(nameInputField, findsOneWidget);

    await tester.enterText(nameInputField, 'some name');

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('done button')));

    await tester.pumpAndSettle();

    expect(formKey.currentState.value['name'], 'some name');
  });
}
