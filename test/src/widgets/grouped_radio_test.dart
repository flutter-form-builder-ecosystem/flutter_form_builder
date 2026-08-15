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

void main() {
  group('GroupedRadio -', () {
    testWidgets('auto orientation renders in an OverflowBar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedRadio<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(OverflowBar), findsOneWidget);
      expect(find.byType(Radio<int?>), findsNWidgets(3));
    });

    testWidgets('tapping a label calls onChanged with the option value', (
      WidgetTester tester,
    ) async {
      int? changed;

      await tester.pumpWidget(
        _wrap(
          GroupedRadio<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            onChanged: (value) => changed = value,
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();

      expect(changed, 2);
    });

    testWidgets('tapping a radio control calls onChanged with its value', (
      WidgetTester tester,
    ) async {
      int? changed;

      await tester.pumpWidget(
        _wrap(
          GroupedRadio<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            onChanged: (value) => changed = value,
          ),
        ),
      );

      await tester.tap(find.byType(Radio<int?>).at(2));
      await tester.pumpAndSettle();

      expect(changed, 3);
    });

    testWidgets('passes the value to the RadioGroup', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedRadio<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            value: 1,
            onChanged: (_) {},
          ),
        ),
      );

      final group = tester.widget<RadioGroup<int?>>(
        find.byType(RadioGroup<int?>),
      );
      expect(group.groupValue, 1);
    });

    testWidgets('disabled options can not change the value', (
      WidgetTester tester,
    ) async {
      int? changed;

      await tester.pumpWidget(
        _wrap(
          GroupedRadio<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            disabled: const [2],
            onChanged: (value) => changed = value,
          ),
        ),
      );

      final radios = tester
          .widgetList<Radio<int?>>(find.byType(Radio<int?>))
          .toList();
      expect(radios.map((radio) => radio.enabled), [true, false, true]);

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
          GroupedRadio<int>(
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
          GroupedRadio<int>(
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
          GroupedRadio<int>(
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
          GroupedRadio<int>(
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

    testWidgets('wrap orientation passes the wrap configuration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedRadio<int>(
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
          GroupedRadio<int>(
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
      expect(row.children.first, isA<Radio<int?>>());
    });

    testWidgets('trailing control affinity places the control after label', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          GroupedRadio<int>(
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
      expect(row.children.last, isA<Radio<int?>>());
    });

    testWidgets('passes the visual props to each radio', (
      WidgetTester tester,
    ) async {
      const color = Color(0xFF111111);

      await tester.pumpWidget(
        _wrap(
          GroupedRadio<int>(
            options: _options,
            orientation: OptionsOrientation.auto,
            activeColor: color,
            focusColor: color,
            hoverColor: color,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (_) {},
          ),
        ),
      );

      final radios = tester
          .widgetList<Radio<int?>>(find.byType(Radio<int?>))
          .toList();
      for (final radio in radios) {
        expect(radio.activeColor, color);
        expect(radio.focusColor, color);
        expect(radio.hoverColor, color);
        expect(radio.materialTapTargetSize, MaterialTapTargetSize.shrinkWrap);
      }
    });
  });
}
