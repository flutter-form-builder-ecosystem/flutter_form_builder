import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'form_builder_tester.dart';

void main() {
  group('onChanged --', () {
    late GlobalKey<FormBuilderState> formKey;
    late FormBuilderTextField emptyTextField;
    late FormBuilder form;

    setUp(() {
      formKey = GlobalKey<FormBuilderState>();
      emptyTextField = FormBuilderTextField(
        key: const Key('text1'),
        name: 'text1',
      );
      form = FormBuilder(key: formKey, child: emptyTextField);
    });

    testWidgets('initial', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableFieldWidget(form));
      final nextChange = await formKey.currentState!.onChanged.first;

      expect(nextChange, contains('text1'));
      expect(nextChange['text1']?.value, isNull);
    });
  });
}
