import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../form_builder_tester.dart';

void main() {
  group('FormBuilderDateTimePicker --', () {
    testWidgets('basic', (WidgetTester tester) async {
      const widgetName = 'fdtp1';
      final widgetKey = UniqueKey();
      final dateNow = DateTime.now();
      const confirmText = 'OK';
      const cancelText = 'CANCEL';

      final testWidget = FormBuilderDateTimePicker(
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

      final testDay = dateNow.day - 1 <= 0 ? dateNow.day + 1 : dateNow.day - 1;
      await tester.tap(find.text(testDay.toString()));
      await tester.pumpAndSettle();
      await tester.tap(find.text(confirmText));
      await tester.pumpAndSettle();
      await tester.tap(find.text(confirmText));
      await tester.pumpAndSettle();

      expect(formSave(), isTrue);
      expect(
        formValue<DateTime>(widgetName),
        DateTime(dateNow.year, dateNow.month, testDay, 12),
      );
    });
    testWidgets(
      'should change to text field and show keyboard when edit icon is pressed',
      (WidgetTester tester) async {
        const widgetName = 'fdtp3';
        final widgetKey = UniqueKey();
        const keyboardType = TextInputType.datetime;

        final testWidget = FormBuilderDateTimePicker(
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

        final textField = tester.widget<TextField>(
          find.byType(TextField).first,
        );
        expect(textField.keyboardType, equals(keyboardType));
      },
    );
    testWidgets('should show a past year when set on lastDate', (
      WidgetTester tester,
    ) async {
      const widgetName = 'fdtp3';
      final widgetKey = UniqueKey();
      const confirmText = 'OK';
      const cancelText = 'CANCEL';
      final year = 2006;

      final testWidget = FormBuilderDateTimePicker(
        key: widgetKey,
        name: widgetName,
        confirmText: confirmText,
        cancelText: cancelText,
        initialDate: null,
        lastDate: DateTime(year, 12, 31),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      await tester.tap(find.byKey(widgetKey));
      await tester.pumpAndSettle();

      expect(find.text(confirmText), findsOneWidget);
      expect(find.text(cancelText), findsOneWidget);
      expect(find.text('December ${year.toString()}'), findsOneWidget);
    });
    group('initial value -', () {
      testWidgets('to FormBuilder', (WidgetTester tester) async {
        const widgetName = 'fdtp2';
        final widgetKey = UniqueKey();
        final dateFuture = DateTime.now().add(const Duration(days: 10));
        const confirmText = 'OK';
        const cancelText = 'CANCEL';

        final testWidget = FormBuilderDateTimePicker(
          key: widgetKey,
          name: widgetName,
          confirmText: confirmText,
          cancelText: cancelText,
        );

        await tester.pumpWidget(
          buildTestableFieldWidget(
            testWidget,
            initialValue: {widgetName: dateFuture},
          ),
        );

        expect(formSave(), isTrue);
        expect(formValue(widgetName), dateFuture);
        await tester.tap(find.byKey(widgetKey));
        await tester.pumpAndSettle();
        expect(find.text(confirmText), findsOneWidget);
        expect(find.text(cancelText), findsOneWidget);

        final testDay = dateFuture.day - 1 <= 0
            ? dateFuture.day + 1
            : dateFuture.day - 1;
        await tester.tap(find.text(testDay.toString()));
        await tester.pumpAndSettle();
        await tester.tap(find.text(confirmText));
        await tester.pumpAndSettle();
        await tester.tap(find.text(confirmText));
        await tester.pumpAndSettle();

        expect(formSave(), isTrue);
        expect(
          formValue<DateTime>(widgetName),
          DateTime(
            dateFuture.year,
            dateFuture.month,
            testDay,
            dateFuture.hour,
            dateFuture.minute,
            0,
            0,
          ),
        );
      });
      testWidgets('to Widget', (WidgetTester tester) async {
        const widgetName = 'fdtp3';
        final widgetKey = UniqueKey();
        final datePast = DateTime.now().subtract(const Duration(days: 10));
        const confirmText = 'OK';
        const cancelText = 'CANCEL';

        final testWidget = FormBuilderDateTimePicker(
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

        final testDay = datePast.day - 1 <= 0
            ? datePast.day + 1
            : datePast.day - 1;
        await tester.tap(find.text(testDay.toString()));
        await tester.pumpAndSettle();
        await tester.tap(find.text(confirmText));
        await tester.pumpAndSettle();
        await tester.tap(find.text(confirmText));
        await tester.pumpAndSettle();

        expect(formSave(), isTrue);
        expect(
          formValue<DateTime>(widgetName),
          DateTime(
            datePast.year,
            datePast.month,
            testDay,
            datePast.hour,
            datePast.minute,
            0,
            0,
          ),
        );
      });
    });
  });

  testWidgets('When press tab, field will be focused', (
    WidgetTester tester,
  ) async {
    const widgetName = 'cb1';
    final widgetKey = UniqueKey();
    const confirmText = 'OK';
    const cancelText = 'CANCEL';

    final testWidget = FormBuilderDateTimePicker(
      key: widgetKey,
      name: widgetName,
      confirmText: confirmText,
      cancelText: cancelText,
    );
    final widgetFinder = find.byWidget(testWidget);

    await tester.pumpWidget(buildTestableFieldWidget(testWidget));
    final focusNode =
        formKey.currentState?.fields[widgetName]?.effectiveFocusNode;

    expect(formSave(), isTrue);
    expect(formValue(widgetName), equals(null));
    expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
    expect(focusNode?.hasFocus, false);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();
    expect(Focus.of(tester.element(widgetFinder)).hasFocus, true);
    expect(focusNode?.hasFocus, true);

    // Open picker
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    expect(find.text(confirmText), findsOneWidget);
    expect(find.text(cancelText), findsOneWidget);
  });
}
