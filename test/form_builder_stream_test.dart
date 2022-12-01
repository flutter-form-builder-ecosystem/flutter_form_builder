import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'form_builder_tester.dart';

void main() {
  group('onChanged --', () {
    testWidgets('initial', (WidgetTester tester) async {
      final key = GlobalKey<FormBuilderState>();
      final form = FormBuilder(
        key: key,
        child: FormBuilderTextField(
          key: const Key('text1'),
          name: 'text1',
        ),
      );

      await tester.pumpWidget(buildTestableFieldWidget(form));
      final nextChange = await key.currentState!.onChanged.first;

      expect(nextChange, contains('text1'));
      expect(nextChange['text1']?.value, isNull);
    });
  });
}
