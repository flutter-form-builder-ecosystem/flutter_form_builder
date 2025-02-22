import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../form_builder_tester.dart';

void main() {
  group('FormBuilderRangeSlider -', () {
    testWidgets('basic', (WidgetTester tester) async {
      const widgetName = 'formBuilderRangeSlider';
      final testWidget = FormBuilderRangeSlider(
        name: widgetName,
        min: 10.0,
        max: 20.0,
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(
        formValue<RangeValues?>(widgetName),
        equals(const RangeValues(10.0, 10.0)),
      );

      // Inspired by https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/range_slider_test.dart
      // Tap at the center of the slider.
      final Offset topLeft = tester
          .getTopLeft(find.byType(RangeSlider))
          .translate(24, 0);
      final Offset bottomRight = tester
          .getBottomRight(find.byType(RangeSlider))
          .translate(-24, 0);
      final Offset rightTarget = topLeft + (bottomRight - topLeft) * 0.5;
      await tester.tapAt(rightTarget);
      await tester.pumpAndSettle();

      expect(formSave(), isTrue);
      expect(formValue<RangeValues>(widgetName), const RangeValues(10.0, 15.0));
    });

    testWidgets('initial value', (WidgetTester tester) async {
      const widgetName = 'formBuilderRangeSlider';
      final testWidget = FormBuilderRangeSlider(
        name: widgetName,
        min: 10.0,
        max: 20.0,
        initialValue: const RangeValues(14.0, 18.0),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(
        formValue<RangeValues?>(widgetName),
        equals(const RangeValues(14.0, 18.0)),
      );

      // Inspired by https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/range_slider_test.dart
      // Tap a small offset after the start of the slider.
      final Offset topLeft = tester
          .getTopLeft(find.byType(RangeSlider))
          .translate(24, 0);
      final Offset bottomRight = tester
          .getBottomRight(find.byType(RangeSlider))
          .translate(-24, 0);
      final Offset leftTarget = topLeft + (bottomRight - topLeft) * 0.1;
      await tester.tapAt(leftTarget);
      await tester.pumpAndSettle();

      expect(formSave(), isTrue);
      expect(formValue<RangeValues>(widgetName), const RangeValues(11.0, 18.0));
    });

    testWidgets('when set valueWidget then show on FormBuilderRangeSlider', (
      WidgetTester tester,
    ) async {
      const widgetName = 'formBuilderRangeSlider';
      final keyValueWidget = Key('valueWidget');
      final testWidget = FormBuilderRangeSlider(
        name: widgetName,
        min: 10.0,
        max: 20.0,
        valueWidget: (value) => Text(value, key: keyValueWidget),
        initialValue: const RangeValues(14.0, 18.0),
      );
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(
        formValue<RangeValues?>(widgetName),
        equals(const RangeValues(14.0, 18.0)),
      );
      expect(find.byKey(keyValueWidget), findsOneWidget);
    });

    testWidgets('Stateful Update', (WidgetTester tester) async {
      const widgetName = 'formBuilderRangeSlider';
      const testWidget = _FormBuilderRangeSliderStateTest(widgetName);
      await tester.pumpWidget(buildTestableFieldWidget(testWidget));

      expect(formSave(), isTrue);
      expect(
        formValue<RangeValues?>(widgetName),
        equals(const RangeValues(-10.0, 10.0)),
      );

      await tester.tapAt(tester.getCenter(find.byType(TextButton)));
      await tester.pumpAndSettle();

      expect(formSave(), isTrue);
      expect(
        formValue<RangeValues?>(widgetName),
        equals(const RangeValues(-9.0, 9.0)),
      );
    });

    testWidgets('When press tab, field will be focused', (
      WidgetTester tester,
    ) async {
      const widgetName = 'key';
      final testWidget = FormBuilderRangeSlider(
        name: widgetName,
        min: 10.0,
        max: 20.0,
      );
      final widgetFinder = find.byWidget(testWidget);

      await tester.pumpWidget(buildTestableFieldWidget(testWidget));
      final focusNode =
          formKey.currentState?.fields[widgetName]?.effectiveFocusNode;

      expect(formSave(), isTrue);
      expect(
        formValue<RangeValues?>(widgetName),
        equals(const RangeValues(10.0, 10.0)),
      );
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, false);
      expect(focusNode?.hasFocus, false);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      expect(Focus.of(tester.element(widgetFinder)).hasFocus, true);
      expect(focusNode?.hasFocus, true);
    });
  });
}

class _FormBuilderRangeSliderStateTest extends StatefulWidget {
  final String name;

  const _FormBuilderRangeSliderStateTest(this.name);

  @override
  State<StatefulWidget> createState() =>
      _FormBuilderRangeSliderStateTestState();
}

class _FormBuilderRangeSliderStateTestState
    extends State<_FormBuilderRangeSliderStateTest> {
  double range = 10;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FormBuilderRangeSlider(
            name: widget.name,
            min: -range,
            max: range,
            initialValue: RangeValues(-range, range),
          ),
        ),
        TextButton(
          onPressed: () => setState(() => range -= 1),
          child: const Text('Reduce Range'),
        ),
      ],
    );
  }
}
