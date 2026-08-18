import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

const _options = <FormBuilderFieldOption<int>>[
  FormBuilderFieldOption(key: ValueKey('1'), value: 1, child: Text('One')),
  FormBuilderFieldOption(key: ValueKey('2'), value: 2, child: Text('Two')),
  FormBuilderFieldOption(key: ValueKey('3'), value: 3, child: Text('Three')),
];

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

class _CheckboxGroupHarness extends StatefulWidget {
  const _CheckboxGroupHarness({
    required this.options,
    required this.orientation,
    required this.onResult,
  });

  final List<FormBuilderFieldOption<int>> options;
  final OptionsOrientation orientation;
  final ValueChanged<List<int>> onResult;

  @override
  State<_CheckboxGroupHarness> createState() => _CheckboxGroupHarnessState();
}

class _CheckboxGroupHarnessState extends State<_CheckboxGroupHarness> {
  List<int>? _value;

  @override
  Widget build(BuildContext context) {
    return GroupedCheckbox<int>(
      options: widget.options,
      orientation: widget.orientation,
      value: _value,
      onChanged: (value) {
        setState(() => _value = value);
        widget.onResult(value);
      },
    );
  }
}

void main() {
  group('GroupedCheckbox -', () {
    testWidgets('auto orientation renders in an OverflowBar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(OverflowBar), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(3));
    });

    testWidgets('tapping a label toggles the value', (
      WidgetTester tester,
    ) async {
      List<int>? changed;

      await tester.pumpWidget(
        _wrap(
          _CheckboxGroupHarness(
            options: _options,
            orientation: OptionsOrientation.auto,
            onResult: (value) => changed = value,
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();
      expect(changed, [2]);

      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();
      expect(changed, isEmpty);
    });

    testWidgets('tapping a checkbox toggles the value', (
      WidgetTester tester,
    ) async {
      List<int>? changed;

      await tester.pumpWidget(
        _wrap(
          _CheckboxGroupHarness(
            options: _options,
            orientation: OptionsOrientation.auto,
            onResult: (value) => changed = value,
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox).at(0));
      await tester.pumpAndSettle();
      expect(changed, [1]);

      await tester.tap(find.byType(Checkbox).at(0));
      await tester.pumpAndSettle();
      expect(changed, isEmpty);
    });

    testWidgets('reflects the provided value in each checkbox', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            value: const [1, 3],
            onChanged: (_) {},
          ),
        ),
      );

      final checkboxes = tester
          .widgetList<Checkbox>(find.byType(Checkbox))
          .toList();
      expect(checkboxes.map((checkbox) => checkbox.value), [true, false, true]);
    });

    testWidgets('tristate mode uses a nullable value per checkbox', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            tristate: true,
            value: const [1],
            onChanged: (_) {},
          ),
        ),
      );

      final checkboxes = tester
          .widgetList<Checkbox>(find.byType(Checkbox))
          .toList();
      expect(checkboxes.map((checkbox) => checkbox.tristate), [
        true,
        true,
        true,
      ]);
      expect(checkboxes.map((checkbox) => checkbox.value), [
        true,
        false,
        false,
      ]);
    });

    testWidgets('tristate mode yields null values when value is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            tristate: true,
            onChanged: (_) {},
          ),
        ),
      );

      final checkboxes = tester
          .widgetList<Checkbox>(find.byType(Checkbox))
          .toList();
      expect(checkboxes.map((checkbox) => checkbox.value), [null, null, null]);
    });

    testWidgets('disabled options can not change the value', (
      WidgetTester tester,
    ) async {
      List<int>? changed;

      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            disabled: const [2],
            onChanged: (value) => changed = value,
          ),
        ),
      );

      final checkboxes = tester
          .widgetList<Checkbox>(find.byType(Checkbox))
          .toList();
      expect(checkboxes[1].onChanged, isNull);

      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();
      expect(changed, isNull);
    });

    testWidgets('vertical orientation places a separator below each option', (
      WidgetTester tester,
    ) async {
      const separator = SizedBox(key: ValueKey('sep'), height: 8);

      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.vertical,
            separator: separator,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.byKey(const ValueKey('sep')), findsNWidgets(2));
    });

    testWidgets('horizontal orientation places a separator after each option', (
      WidgetTester tester,
    ) async {
      const separator = SizedBox(key: ValueKey('sep'), width: 8);

      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.horizontal,
            separator: separator,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.byKey(const ValueKey('sep')), findsNWidgets(2));
    });

    testWidgets('vertical item decoration uses wrapSpacing as bottom margin', (
      WidgetTester tester,
    ) async {
      const decoration = BoxDecoration(
        border: Border.fromBorderSide(BorderSide()),
      );

      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.vertical,
            wrapSpacing: 5,
            onChanged: (_) {},
            itemDecoration: decoration,
          ),
        ),
      );

      final containers = tester
          .widgetList<Container>(find.byType(Container))
          .where((container) => container.decoration == decoration)
          .toList();
      expect(containers, hasLength(3));
      for (final container in containers) {
        expect(container.margin, const EdgeInsets.only(bottom: 5));
      }
    });

    testWidgets('horizontal item decoration uses wrapSpacing as right margin', (
      WidgetTester tester,
    ) async {
      const decoration = BoxDecoration(
        border: Border.fromBorderSide(BorderSide()),
      );

      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.horizontal,
            wrapSpacing: 7,
            onChanged: (_) {},
            itemDecoration: decoration,
          ),
        ),
      );

      final containers = tester
          .widgetList<Container>(find.byType(Container))
          .where((container) => container.decoration == decoration)
          .toList();
      expect(containers, hasLength(3));
      for (final container in containers) {
        expect(container.margin, const EdgeInsets.only(right: 7));
      }
    });

    testWidgets('auto item decoration has no margin', (
      WidgetTester tester,
    ) async {
      const decoration = BoxDecoration(
        border: Border.fromBorderSide(BorderSide()),
      );

      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            onChanged: (_) {},
            itemDecoration: decoration,
          ),
        ),
      );

      final containers = tester
          .widgetList<Container>(find.byType(Container))
          .where((container) => container.decoration == decoration)
          .toList();
      expect(containers, hasLength(3));
      for (final container in containers) {
        expect(container.margin, EdgeInsets.zero);
      }
    });

    testWidgets('wrap orientation passes the wrap configuration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.wrap,
            wrapSpacing: 8,
            wrapRunSpacing: 12,
            wrapAlignment: WrapAlignment.center,
            wrapRunAlignment: WrapAlignment.spaceAround,
            wrapCrossAxisAlignment: WrapCrossAlignment.end,
            wrapTextDirection: TextDirection.rtl,
            wrapVerticalDirection: VerticalDirection.up,
            onChanged: (_) {},
          ),
        ),
      );

      final wrap = tester.widget<Wrap>(find.byType(Wrap));
      expect(wrap.spacing, 8);
      expect(wrap.runSpacing, 12);
      expect(wrap.alignment, WrapAlignment.center);
      expect(wrap.runAlignment, WrapAlignment.spaceAround);
      expect(wrap.crossAxisAlignment, WrapCrossAlignment.end);
      expect(wrap.direction, Axis.horizontal);
      expect(wrap.textDirection, TextDirection.rtl);
      expect(wrap.verticalDirection, VerticalDirection.up);
    });

    testWidgets('leading control affinity places the control before label', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            controlAffinity: ControlAffinity.leading,
            onChanged: (_) {},
          ),
        ),
      );

      final row = tester.widget<Row>(
        find.ancestor(of: find.text('One'), matching: find.byType(Row)).first,
      );
      expect(row.children.first, isA<Checkbox>());
    });

    testWidgets('trailing control affinity places the control after label', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            controlAffinity: ControlAffinity.trailing,
            onChanged: (_) {},
          ),
        ),
      );

      final row = tester.widget<Row>(
        find.ancestor(of: find.text('One'), matching: find.byType(Row)).first,
      );
      expect(row.children.last, isA<Checkbox>());
    });

    testWidgets('passes the visual props to each checkbox', (
      WidgetTester tester,
    ) async {
      const color = Color(0xFF111111);

      await tester.pumpWidget(
        _wrap(
          GroupedCheckbox<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            activeColor: color,
            checkColor: color,
            focusColor: color,
            hoverColor: color,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (_) {},
          ),
        ),
      );

      final checkboxes = tester
          .widgetList<Checkbox>(find.byType(Checkbox))
          .toList();
      for (final checkbox in checkboxes) {
        expect(checkbox.activeColor, color);
        expect(checkbox.checkColor, color);
        expect(checkbox.focusColor, color);
        expect(checkbox.hoverColor, color);
        expect(checkbox.visualDensity, VisualDensity.compact);
        expect(
          checkbox.materialTapTargetSize,
          MaterialTapTargetSize.shrinkWrap,
        );
      }
    });
  });
}
