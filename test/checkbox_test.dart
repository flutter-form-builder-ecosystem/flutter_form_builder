import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets('Smoke test checkbox form', (WidgetTester tester) async {
    await insertWidget(
        tester: tester,
        child: FormBuilderCheckbox(
          attribute: "agreement",
          label: Text('I Agree'),
          validators: [
            FormBuilderValidators.required(),
          ],
        )
    );

    await tester.pump();

    final agreementCheckboxField = find.byKey(Key('agreement'));
    expect(agreementCheckboxField, findsOneWidget);

    await tester.tap(agreementCheckboxField);

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('done button')));

    await tester.pumpAndSettle();
  });

  testWidgets('Smoke test checkbox list form', (WidgetTester tester) async {
    await insertWidget(
        tester: tester,
        child: FormBuilderCheckboxList(
          decoration:
          InputDecoration(labelText: "The language of my people"),
          attribute: "languages",
          initialValue: ["Dart"],
          options: [
            FormBuilderFieldOption(value: "Dart"),
            FormBuilderFieldOption(value: "Kotlin"),
            FormBuilderFieldOption(value: "Java"),
            FormBuilderFieldOption(value: "Swift"),
            FormBuilderFieldOption(value: "Objective-C"),
          ],
        ),
    );

    final favouriteLanguage = find.byKey(Key('Swift'));
    expect(favouriteLanguage, findsOneWidget);
    expect(find.byKey(Key('Dart')), findsOneWidget);
    expect(find.byKey(Key('Kotlin')), findsOneWidget);
    expect(find.byKey(Key('Java')), findsOneWidget);
    expect(find.byKey(Key('Swift')), findsOneWidget);
    expect(find.byKey(Key('Objective-C')), findsOneWidget);

    await tester.tap(favouriteLanguage);

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('done button')));

    await tester.pumpAndSettle();
  });
}
