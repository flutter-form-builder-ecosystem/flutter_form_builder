import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../form_builder_tester.dart';

void main() {
  group('FormBuilderDateTimePicker --', () {
    testWidgets('basic', (WidgetTester tester) async {
      const String widgetName = 'fdtp1';
      final UniqueKey widgetKey = UniqueKey();
      final DateTime dateNow = DateTime.now();
      const String confirmText = 'OK';
      const String cancelText = 'CANCEL';

      final FormBuilderDateTimePicker testWidget = FormBuilderDateTimePicker(
        key: widgetKey,
        name: widgetName,
        confirmText: confirmText,
        cancelText: cancelText,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(null));
      await tester.tap(find.byKey(widgetKey));
      await tester.pumpAndSettle();
      expect(find.text(confirmText), findsOneWidget);
      expect(find.text(cancelText), findsOneWidget);

      final int testDay =
          dateNow.day - 1 <= 0 ? dateNow.day + 1 : dateNow.day - 1;
      await tester.tap(find.text(testDay.toString()));
      await tester.pumpAndSettle();
      await tester.tap(find.text(confirmText));
      await tester.pumpAndSettle();
      await tester.tap(find.text(confirmText));
      await tester.pumpAndSettle();

      expect(formSave(), isTrue);
      expect(formValue<DateTime>(widgetName),
          DateTime(dateNow.year, dateNow.month, testDay, 12));
    });
    testWidgets('input keyboard type', (WidgetTester tester) async {
      const String widgetName = 'fdtp3';
      final UniqueKey widgetKey = UniqueKey();
      const TextInputType keyboardType = TextInputType.datetime;

      final FormBuilderDateTimePicker testWidget = FormBuilderDateTimePicker(
        key: widgetKey,
        name: widgetName,
        keyboardType: keyboardType,
        inputType: InputType.date,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      await tester.tap(find.byKey(widgetKey));
      await tester.pumpAndSettle();

      // change to input edition
      await tester.tap(find.byIcon(Icons.edit_outlined));
      await tester.pumpAndSettle();

      final TextField textField =
          tester.widget<TextField>(find.byType(TextField).first);
      expect(textField.keyboardType, equals(keyboardType));
    });
    group('initial value -', () {
      testWidgets('to FormBuilder', (WidgetTester tester) async {
        const String widgetName = 'fdtp2';
        final UniqueKey widgetKey = UniqueKey();
        final DateTime dateFuture =
            DateTime.now().add(const Duration(days: 10));
        const String confirmText = 'OK';
        const String cancelText = 'CANCEL';

        final FormBuilderDateTimePicker testWidget = FormBuilderDateTimePicker(
          key: widgetKey,
          name: widgetName,
          confirmText: confirmText,
          cancelText: cancelText,
        );

        await tester.pumpWidget(buildTestableFieldWidget(
          testWidget,
          initialValue: <String, dynamic>{widgetName: dateFuture},
        ));

        expect(formSave(), isTrue);
        expect(formValue(widgetName), dateFuture);
        await tester.tap(find.byKey(widgetKey));
        await tester.pumpAndSettle();
        expect(find.text(confirmText), findsOneWidget);
        expect(find.text(cancelText), findsOneWidget);

        final int testDay =
            dateFuture.day - 1 <= 0 ? dateFuture.day + 1 : dateFuture.day - 1;
        await tester.tap(find.text(testDay.toString()));
        await tester.pumpAndSettle();
        await tester.tap(find.text(confirmText));
        await tester.pumpAndSettle();
        await tester.tap(find.text(confirmText));
        await tester.pumpAndSettle();

        expect(formSave(), isTrue);
        expect(
          formValue<DateTime>(widgetName),
          DateTime(dateFuture.year, dateFuture.month, testDay, dateFuture.hour,
              dateFuture.minute, 0, 0),
        );
      });
      testWidgets('to Widget', (WidgetTester tester) async {
        const String widgetName = 'fdtp3';
        final UniqueKey widgetKey = UniqueKey();
        final DateTime datePast =
            DateTime.now().subtract(const Duration(days: 10));
        const String confirmText = 'OK';
        const String cancelText = 'CANCEL';

        final FormBuilderDateTimePicker testWidget = FormBuilderDateTimePicker(
          key: widgetKey,
          name: widgetName,
          confirmText: confirmText,
          cancelText: cancelText,
          initialValue: datePast,
        );

        await tester.pumpWidget(buildTestableFieldWidget(testWidget));

        expect(formSave(), isTrue);
        expect(formValue(widgetName), datePast);
        await tester.tap(find.byKey(widgetKey));
        await tester.pumpAndSettle();
        expect(find.text(confirmText), findsOneWidget);
        expect(find.text(cancelText), findsOneWidget);

        final int testDay =
            datePast.day - 1 <= 0 ? datePast.day + 1 : datePast.day - 1;
        await tester.tap(find.text(testDay.toString()));
        await tester.pumpAndSettle();
        await tester.tap(find.text(confirmText));
        await tester.pumpAndSettle();
        await tester.tap(find.text(confirmText));
        await tester.pumpAndSettle();

        expect(formSave(), isTrue);
        expect(
          formValue<DateTime>(widgetName),
          DateTime(datePast.year, datePast.month, testDay, datePast.hour,
              datePast.minute, 0, 0),
        );
      });
    });
  });
}
