import 'package:flutter/material.dart';
import 'package:flutter_form_builder/src/fields/form_builder_dropdown.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../form_builder_tester.dart';

void main() {
  group('FormBuilderDropdown --', () {
    testWidgets('basic', (WidgetTester tester) async {
      const widgetName = 'd1';
      final testWidget = FormBuilderDropdown<int>(
        name: widgetName,
        items: const [
          DropdownMenuItem(
            value: 1,
            child: Text('One'),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text('Two'),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text('Three'),
          ),
        ],
      );
      final widgetFinder = find.byWidget(testWidget);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(formValue(widgetName), isNull);
      await tester.tap(widgetFinder);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Three').last);
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(3));

      await tester.tap(find.text('Three').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('One').last);
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(1));
    });
    testWidgets('reset to initial value when update items',
        (WidgetTester tester) async {
      const widgetName = 'dropdown_field';
      const buttonKey = Key('update_button');

      // Define the initial and updated items for the dropdown
      const List<DropdownMenuItem<int>> initialItems = [
        DropdownMenuItem(value: 1, child: Text('Option 1')),
        DropdownMenuItem(value: 2, child: Text('Option 2')),
      ];

      const List<DropdownMenuItem<int>> updatedItems = [
        DropdownMenuItem(value: 3, child: Text('Option 3')),
        DropdownMenuItem(value: 4, child: Text('Option 4')),
      ];

      // Build the test widget tree with the initial items
      const testWidget = MyTestWidget(
        initialItems: initialItems,
        updatedItems: updatedItems,
        initialValue: 1,
        updatedInitialValue: 3,
        fieldName: widgetName,
        buttonKey: buttonKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Verify the initial value of field
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(1));

      // Tap button and update the dropdown items
      final buttonFinder = find.byKey(buttonKey);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Verify the updated value of field
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(3));
    });
    testWidgets('reset to initial value when update items with same values',
        (WidgetTester tester) async {
      const widgetName = 'dropdown_field';
      const buttonKey = Key('update_button');

      // Define the initial and updated items for the dropdown
      const List<DropdownMenuItem<int>> initialItems = [
        DropdownMenuItem(value: 1, child: Text('Option 1')),
        DropdownMenuItem(value: 2, child: Text('Option 2')),
      ];

      const List<DropdownMenuItem<int>> updatedItems = [
        DropdownMenuItem(value: 1, child: Text('Option 3')),
        DropdownMenuItem(value: 2, child: Text('Option 4')),
      ];

      // Build the test widget tree with the initial items
      const testWidget = MyTestWidget(
        initialItems: initialItems,
        updatedItems: updatedItems,
        initialValue: 1,
        fieldName: widgetName,
        buttonKey: buttonKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Verify the initial value of field
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(1));

      // Update dropdown selected value
      await tester.tap(find.byType(FormBuilderDropdown<int>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(2));

      // Tap button and update the dropdown items
      final buttonFinder = find.byKey(buttonKey);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Verify the updated value of field
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(1));
    });

    testWidgets('reset to initial value when update items with same children',
        (WidgetTester tester) async {
      const widgetName = 'dropdown_field';
      const buttonKey = Key('update_button');
      const option1 = Text('Option 1');
      const option2 = Text('Option 2');

      // Define the initial and updated items for the dropdown
      const List<DropdownMenuItem<int>> initialItems = [
        DropdownMenuItem(value: 1, child: option1),
        DropdownMenuItem(value: 2, child: option2),
      ];

      const List<DropdownMenuItem<int>> updatedItems = [
        DropdownMenuItem(value: 3, child: option1),
        DropdownMenuItem(value: 4, child: option2),
      ];

      // Build the test widget tree with the initial items
      const testWidget = MyTestWidget(
        initialItems: initialItems,
        updatedItems: updatedItems,
        initialValue: 1,
        updatedInitialValue: 3,
        fieldName: widgetName,
        buttonKey: buttonKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Verify the initial value of field
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(1));

      // Update dropdown selected value
      await tester.tap(find.byType(FormBuilderDropdown<int>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(2));

      // Tap button and update the dropdown items
      final buttonFinder = find.byKey(buttonKey);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Verify the updated value of field
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(3));
    });
    testWidgets('maintain initial value when update to equals items',
        (WidgetTester tester) async {
      const widgetName = 'dropdown_field';
      const buttonKey = Key('update_button');

      // Define the initial and updated items for the dropdown
      const List<DropdownMenuItem<int>> initialItems = [
        DropdownMenuItem(value: 1, child: Text('Option 1')),
        DropdownMenuItem(value: 2, child: Text('Option 2')),
      ];

      // Build the test widget tree with the initial items
      const testWidget = MyTestWidget(
        initialItems: initialItems,
        updatedItems: initialItems,
        initialValue: 1,
        fieldName: widgetName,
        buttonKey: buttonKey,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      // Verify the initial value of field
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(1));

      // Update dropdown selected value
      await tester.tap(find.byType(FormBuilderDropdown<int>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(2));

      // Tap button and update the dropdown items
      final buttonFinder = find.byKey(buttonKey);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Verify the updated value of field
      expect(formSave(), isTrue);
      expect(formValue(widgetName), equals(2));
    });
  });
}

class MyTestWidget<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> initialItems;
  final List<DropdownMenuItem<T>> updatedItems;
  final T? initialValue;
  final T? updatedInitialValue;
  final String fieldName;
  final Key? buttonKey;

  const MyTestWidget({
    super.key,
    required this.initialItems,
    this.initialValue,
    this.updatedItems = const [],
    required this.fieldName,
    required this.buttonKey,
    this.updatedInitialValue,
  });

  @override
  State<MyTestWidget> createState() => _MyTestWidgetState<T>();
}

class _MyTestWidgetState<T> extends State<MyTestWidget> {
  T? _initialValue;
  List<DropdownMenuItem<T>> _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.initialItems as List<DropdownMenuItem<T>>;
    _initialValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderDropdown<T>(
          name: 'dropdown_field',
          items: _items,
          initialValue: _initialValue,
          onChanged: (value) {},
        ),
        ElevatedButton(
          key: widget.buttonKey,
          onPressed: () {
            setState(() {
              _items = widget.updatedItems as List<DropdownMenuItem<T>>;
              if (widget.updatedInitialValue != null) {
                _initialValue = widget.updatedInitialValue;
              }
            });
          },
          child: const Text('update'),
        )
      ],
    );
  }
}
