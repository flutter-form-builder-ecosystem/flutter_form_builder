import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Test Harness for running Validations
Future<void> testValidations(
    WidgetTester tester, void Function(BuildContext) validations) async {
  await tester.pumpWidget(MaterialApp(
    localizationsDelegates: [
      FormBuilderLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    home: Builder(
      builder: (BuildContext context) {
        // Exercise validations using the provided context
        validations(context);
        // The builder function must return a widget.
        return Placeholder();
      },
    ),
  ));

  // Critical to pumpAndSettle to let Builder build to exercise validations
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'FormBuilderValidators.required',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.required(context);
            // Pass
            expect(validator(false), isNull);
            expect(validator(0), isNull);
            expect(validator('0'), isNull);
            expect(validator('something long'), isNull);
            expect(validator(DateTime.now()), isNull);
            // Fail
            expect(validator(null), isNotNull);
            expect(validator(''), isNotNull);
            expect(validator([]), isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.equal',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.equal(context, true);
            // Pass
            expect(validator(true), isNull);
            // Fail
            expect(validator(null), isNotNull);
            expect(validator(false), isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.maxLength',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.maxLength(context, 5);
            // Pass
            expect(validator(null), isNull);
            expect(validator(''), isNull);
            expect(validator('two'), isNull);
            expect(validator('12345'), isNull);
            // Fail
            expect(validator('something long'), isNotNull);
            expect(validator('123456'), isNotNull);
          }));
  testWidgets(
      'FormBuilderValidators.minLength',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.minLength(context, 5);
            // Pass
            expect(validator('12345'), isNull);
            expect(validator('123456'), isNull);
            expect(validator('something long'), isNull);
            // Fail
            expect(validator(null), isNotNull);
            expect(validator(''), isNotNull);
            expect(validator('two'), isNotNull);
            // Advanced
            final validatorAllowEmpty =
                FormBuilderValidators.minLength(context, 5, allowEmpty: true);
            expect(validatorAllowEmpty(null), isNull);
            expect(validatorAllowEmpty(''), isNull);
          }));

  testWidgets(
      'FormBuilderValidators.email',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.email(context);
            // Pass
            expect(validator(null), isNull);
            expect(validator(''), isNull);
            expect(validator('john@flutter.dev'), isNull);
            expect(validator(' john@flutter.dev '), isNull);
            expect(validator('john@flutter.dev '), isNull);
            expect(validator(' john@flutter.dev'), isNull);
            // Fail
            expect(validator('john@flutter'), isNotNull);
            expect(validator('john@ flutter.dev'), isNotNull);
            expect(validator('john flutter.dev'), isNotNull);
            expect(validator('flutter.dev'), isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.max',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.max(context, 20);
            // Pass
            expect(validator(null), isNull);
            expect(validator(''), isNull);
            expect(validator(0), isNull);
            expect(validator(-1), isNull);
            expect(validator(-1.1), isNull);
            expect(validator(1.2), isNull);
            expect(validator('19'), isNull);
            expect(validator('20'), isNull);
            expect(validator(20), isNull);
            // Fail
            expect(validator(20.01), isNotNull);
            expect(validator(21), isNotNull);
            expect(validator('21'), isNotNull);
            expect(validator(999), isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.min',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.min(context, 30);
            // Pass
            expect(validator(null), isNull);
            expect(validator(''), isNull);
            expect(validator(30.01), isNull);
            expect(validator(31), isNull);
            expect(validator('31'), isNull);
            expect(validator(70), isNull);
            // Fail
            expect(validator(-1), isNotNull);
            expect(validator(0), isNotNull);
            expect(validator('10'), isNotNull);
            expect(validator(10), isNotNull);
            expect(validator(29), isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.numeric',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.numeric(context);
            // Pass
            expect(validator(null), isNull);
            expect(validator(''), isNull);
            expect(validator('0'), isNull);
            expect(validator('31'), isNull);
            expect(validator('-1'), isNull);
            expect(validator('-1.01'), isNull);
            // Fail
            expect(validator('A'), isNotNull);
            expect(validator('XYZ'), isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.integer',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.integer(context);
            // Pass
            expect(validator(null), isNull);
            expect(validator(''), isNull);
            expect(validator('0'), isNull);
            expect(validator('31'), isNull);
            expect(validator('-1'), isNull);
            // Fail
            expect(validator('-1.01'), isNotNull);
            expect(validator('1.'), isNotNull);
            expect(validator('A'), isNotNull);
            expect(validator('XYZ'), isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.match',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.match(context, '^A[0-9]\$');
            // Pass
            expect(validator(null), isNull);
            expect(validator(''), isNull);
            expect(validator('A1'), isNull);
            expect(validator('A9'), isNull);
            // Fail
            expect(validator('A'), isNotNull);
            expect(validator('Z9'), isNotNull);
            expect(validator('A12'), isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.url',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.url(context);
            // Pass
            expect(validator(null), isNull);
            expect(validator(''), isNull);
            expect(validator('https://www.google.com'), isNull);
            expect(validator('www.google.com'), isNull);
            expect(validator('google.com'), isNull);
            expect(validator('http://google.com'), isNull);
            // Fail
            expect(validator('.com'), isNotNull);
            // Advanced overrides
            expect(
                FormBuilderValidators.url(context,
                    protocols: ['https', 'http'],
                    errorText:
                        'Only HTTP and HTTPS allowed')('ftp://www.google.com'),
                isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.IP',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.IP(context);
            // Pass
            expect(validator(null), isNull);
            expect(validator(''), isNull);
            expect(validator('192.168.0.1'), isNull);
            // Fail
            expect(validator('256.168.0.1'), isNotNull);
            expect(validator('256.168.0.'), isNotNull);
            expect(validator('255.168.0.'), isNotNull);
          }));

  testWidgets(
      'FormBuilderValidators.compose',
      (WidgetTester tester) => testValidations(tester, (context) {
            final validator = FormBuilderValidators.compose<String>([
              FormBuilderValidators.required(context),
              FormBuilderValidators.numeric(context),
              FormBuilderValidators.minLength(context, 2),
              FormBuilderValidators.maxLength(context, 3),
            ]);
            // Pass
            expect(validator('12'), isNull);
            expect(validator('123'), isNull);
            // Fail
            expect(validator(null), isNotNull);
            expect(validator(''), isNotNull);
            expect(validator('1'), isNotNull);
            expect(validator('1234'), isNotNull);
            expect(validator('ABC'), isNotNull);
          }));
}
