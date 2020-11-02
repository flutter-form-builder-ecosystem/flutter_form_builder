import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  testWidgets('FormBuilderValidators.required', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Builder(
          builder: (BuildContext context) {
            expect(FormBuilderValidators.required(context)('something long'),
                isNull);
            expect(FormBuilderValidators.required(context)(DateTime.now()),
                isNull);
            expect(FormBuilderValidators.required(context)(''), isNotNull);
            expect(FormBuilderValidators.required(context)([]), isNotNull);

            // The builder function must return a widget.
            return Placeholder();
          },
        ),
      ),
    );
  });

  testWidgets('FormBuilderValidators.maxLength', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Builder(
          builder: (BuildContext context) {
            expect(
                FormBuilderValidators.maxLength(context, 5)('something long'),
                equals('Value must have a length less than or equal to 5'));
            expect(FormBuilderValidators.maxLength(context, 5)('two'), isNull);
            // expect(FormBuilderValidators.maxLength(context, 5)(5), equals(null));

            // The builder function must return a widget.
            return Placeholder();
          },
        ),
      ),
    );
  });

  testWidgets('FormBuilderValidators.email', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Builder(
          builder: (BuildContext context) {
            expect(FormBuilderValidators.email(context)('john@flutter'),
                isNotNull);
            expect(FormBuilderValidators.email(context)('john@flutter.dev'),
                isNull);
            expect(FormBuilderValidators.email(context)(' john@flutter.dev '),
                isNull);
            expect(FormBuilderValidators.email(context)('john@flutter.dev '),
                isNull);
            expect(FormBuilderValidators.email(context)(' john@flutter.dev'),
                isNull);
            expect(FormBuilderValidators.email(context)(null), isNull);
            expect(FormBuilderValidators.email(context)(''), isNull);

            // The builder function must return a widget.
            return Placeholder();
          },
        ),
      ),
    );
  });

  testWidgets('FormBuilderValidators.max', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Builder(
          builder: (BuildContext context) {
            expect(FormBuilderValidators.max(context, 20)('70'), isNotNull);
            expect(FormBuilderValidators.max(context, 30)(70), isNotNull);
            expect(FormBuilderValidators.max(context, 30)(20), isNull);
            expect(FormBuilderValidators.max(context, 30)(''), isNull);

            // The builder function must return a widget.
            return Placeholder();
          },
        ),
      ),
    );
  });

  testWidgets('FormBuilderValidators.min', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Builder(
          builder: (BuildContext context) {
            expect(FormBuilderValidators.min(context, 30)('10'), isNotNull);
            expect(FormBuilderValidators.min(context, 30)(10), isNotNull);
            expect(FormBuilderValidators.min(context, 30)(70), isNull);
            expect(FormBuilderValidators.min(context, 30)(''), isNull);

            // The builder function must return a widget.
            return Placeholder();
          },
        ),
      ),
    );
  });

  testWidgets('FormBuilderValidators.url', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Builder(
          builder: (BuildContext context) {
            expect(FormBuilderValidators.url(context)(null), isNull);
            expect(FormBuilderValidators.url(context)('https://www.google.com'),
                isNull);
            expect(
                FormBuilderValidators.url(context)('www.google.com'), isNull);
            expect(FormBuilderValidators.url(context)('google.com'), isNull);
            expect(FormBuilderValidators.url(context)('http://google.com'),
                isNull);
            expect(FormBuilderValidators.url(context)('.com'), isNotNull);
            expect(
                FormBuilderValidators.url(context,
                    protocols: ['https', 'http'],
                    errorText:
                        'Only HTTP and HTTPS allowed')('ftp://www.google.com'),
                isNotNull);

            // The builder function must return a widget.
            return Placeholder();
          },
        ),
      ),
    );
  });

  testWidgets('FormBuilderValidators.IP', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Builder(
          builder: (BuildContext context) {
            expect(FormBuilderValidators.IP(context)(null), isNull);
            expect(FormBuilderValidators.IP(context)('192.168.0.1'), isNull);
            expect(FormBuilderValidators.IP(context)('256.168.0.1'), isNotNull);
            expect(FormBuilderValidators.IP(context)(''), isNull);

            // The builder function must return a widget.
            return Placeholder();
          },
        ),
      ),
    );
  });
}
