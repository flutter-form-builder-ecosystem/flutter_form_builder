import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'form_builder_tester.dart';

void main() {
  group('FormBuilderDateRangePicker --', () {
    testWidgets('basic', (WidgetTester tester) async {
      const widgetName = 'formBuilderDateRangePicker';
      final testWidget = FormBuilderDateRangePicker(
        name: widgetName,
        firstDate: DateTime(2010),
        // Using last date < today to make date picker always open on 01/01/2010
        // If last date >= today, it opens on DateTime.now month, which complicates testing.
        lastDate: DateTime(2020),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(formValue<DateTimeRange?>(widgetName), isNull);

      await tester.tap(find.byType(TextField));
      await tester.pump();

      // Set Jan 2, 2010 as start
      await tester.tap(find.text('2').first);
      await tester.pump();

      // Set Jan 4, 2010 as end
      await tester.tap(find.text('4').first);
      await tester.pump();

      // Close date range picker dialog
      await tester.tap(find.text('Save'));
      await tester.pump();

      expect(formSave(), isTrue);
      expect(
        formValue<DateTimeRange?>(widgetName),
        equals(DateTimeRange(
          start: DateTime(2010, 1, 2),
          end: DateTime(2010, 1, 4),
        )),
      );
    });

    testWidgets('initial value', (WidgetTester tester) async {
      const widgetName = 'formBuilderDateRangePicker';
      final testWidget = FormBuilderDateRangePicker(
        name: widgetName,
        firstDate: DateTime(2010),
        lastDate: DateTime(2020),
        initialValue: DateTimeRange(
          start: DateTime(2010, 1, 2),
          end: DateTime(2010, 1, 4),
        ),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(
        formValue<DateTimeRange?>(widgetName),
        equals(DateTimeRange(
          start: DateTime(2010, 1, 2),
          end: DateTime(2010, 1, 4),
        )),
      );
    });

    testWidgets('text field empty when value is null',
        (WidgetTester tester) async {
      const widgetName = 'formBuilderDateRangePicker';
      final testWidget = FormBuilderDateRangePicker(
        name: widgetName,
        firstDate: DateTime(2010),
        lastDate: DateTime(2020),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(find.widgetWithText(TextField, ''), findsOneWidget);
    });

    testWidgets('text field shows date range', (WidgetTester tester) async {
      const widgetName = 'formBuilderDateRangePicker';
      final testWidget = FormBuilderDateRangePicker(
        name: widgetName,
        firstDate: DateTime(2010),
        lastDate: DateTime(2020),
        initialValue: DateTimeRange(
          start: DateTime(2010, 1, 2),
          end: DateTime(2010, 1, 4),
        ),
        format: DateFormat('yyyy-MM-dd'),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(
        find.widgetWithText(TextField, '2010-01-02 - 2010-01-04'),
        findsOneWidget,
      );
    });
  });
}
