import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field for selection of a numerical value on a slider
class FormBuilderSlider extends FormBuilderFieldDecoration<double> {
  /// Called when the user starts selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider [value] (use
  /// [onChanged] for that), but rather to be notified when the user has started
  /// selecting a new value by starting a drag or with a tap.
  ///
  /// The value passed will be the last [value] that the slider had before the
  /// change began.
  ///
  /// See also:
  ///
  ///  * [onChangeEnd] for a callback that is called when the value change is
  ///    complete.
  final ValueChanged<double>? onChangeStart;

  /// Called when the user is done selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider [value] (use
  /// [onChanged] for that), but rather to know when the user has completed
  /// selecting a new [value] by ending a drag or a click.
  /// See also:
  ///
  ///  * [onChangeStart] for a callback that is called when a value change
  ///    begins.
  final ValueChanged<double>? onChangeEnd;

  /// The minimum value the user can select.
  ///
  /// Defaults to 0.0. Must be less than or equal to [max].
  ///
  /// If the [max] is equal to the [min], then the slider is disabled.
  final double min;

  /// The maximum value the user can select.
  ///
  /// Defaults to 1.0. Must be greater than or equal to [min].
  ///
  /// If the [max] is equal to the [min], then the slider is disabled.
  final double max;

  /// The number of discrete divisions.
  ///
  /// Typically used with [label] to show the current discrete value.
  ///
  /// If null, the slider is continuous.
  final int? divisions;

  /// A label to show above the slider when the slider is active.
  ///
  /// It is used to display the value of a discrete slider, and it is displayed
  /// as part of the value indicator shape.
  ///
  /// The label is rendered using the active [ThemeData]'s
  /// [ThemeData.textTheme.bodyText1] text style, with the
  /// theme data's [ThemeData.colorScheme.onPrimaryColor]. The label's text style
  /// can be overridden with [SliderThemeData.valueIndicatorTextStyle].
  ///
  /// If null, then the value indicator will not be displayed.
  ///
  /// Ignored if this slider is created with [Slider.adaptive].
  ///
  /// See also:
  ///
  ///  * [SliderComponentShape] for how to create a custom value indicator
  ///    shape.
  final String? label;

  /// The color to use for the portion of the slider track that is active.
  ///
  /// The "active" side of the slider is the side between the thumb and the
  /// minimum value.
  ///
  /// Defaults to [SliderTheme.activeTrackColor] of the current [SliderTheme].
  ///
  /// Using a [SliderTheme] gives much more fine-grained control over the
  /// appearance of various components of the slider.
  final Color? activeColor;

  /// The color for the inactive portion of the slider track.
  ///
  /// The "inactive" side of the slider is the side between the thumb and the
  /// maximum value.
  ///
  /// Defaults to the [SliderTheme.inactiveTrackColor] of the current
  /// [SliderTheme].
  ///
  /// Using a [SliderTheme] gives much more fine-grained control over the
  /// appearance of various components of the slider.
  ///
  /// Ignored if this slider is created with [Slider.adaptive].
  final Color? inactiveColor;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// The callback used to create a semantic value from a slider value.
  ///
  /// Defaults to formatting values as a percentage.
  final SemanticFormatterCallback? semanticFormatterCallback;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// An alternative to displaying the text value of the slider.
  ///
  /// Defaults to null.
  ///
  /// When used [minValueWidget] will override the value for the minimum widget.
  final Widget Function(String min)? minValueWidget;

  /// An alternative to displaying the text value of the slider.
  ///
  /// Defaults to null.
  ///
  /// When used [valueWidget] will override the value for the selected value widget.
  final Widget Function(String value)? valueWidget;

  /// An alternative to displaying the text value of the slider.
  ///
  /// Defaults to null.
  ///
  /// When used [maxValueWidget] will override the value for the maximum widget.
  final Widget Function(String max)? maxValueWidget;

  /// Provides the ability to format a number in a locale-specific way.
  ///
  /// The format is specified as a pattern using a subset of the ICU formatting
  /// patterns.
  ///
  /// - `0` A single digit
  /// - `#` A single digit, omitted if the value is zero
  /// - `.` Decimal separator
  /// - `-` Minus sign
  /// - `,` Grouping separator
  /// - `E` Separates mantissa and expontent
  /// - `+` - Before an exponent, to say it should be prefixed with a plus sign.
  /// - `%` - In prefix or suffix, multiply by 100 and show as percentage
  /// - `‰ (\u2030)` In prefix or suffix, multiply by 1000 and show as per mille
  /// - `¤ (\u00A4)` Currency sign, replaced by currency name
  /// - `'` Used to quote special characters
  /// - `;` Used to separate the positive and negative patterns (if both present)
  ///
  /// For example,
  ///
  ///       var f = NumberFormat("###.0#", "en_US");
  ///       print(f.format(12.345));
  ///           ==> 12.34
  ///
  /// If the locale is not specified, it will default to the current locale. If
  /// the format is not specified it will print in a basic format with at least
  /// one integer digit and three fraction digits.
  ///
  /// There are also standard patterns available via the special constructors.
  /// e.g.
  ///
  ///       var percent = NumberFormat.percentPattern("ar"); var
  ///       eurosInUSFormat = NumberFormat.currency(locale: "en_US",
  ///           symbol: "€");
  ///
  /// There are several such constructors available, though some of them are
  /// limited. For example, at the moment, scientificPattern prints only as
  /// equivalent to "#E0" and does not take into account significant digits.
  final NumberFormat? numberFormat;

  final DisplayValues displayValues;

  /// Creates field for selection of a numerical value on a slider
  FormBuilderSlider({
    super.key,
    required super.name,
    super.validator,
    required double super.initialValue,
    super.decoration,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.onReset,
    super.focusNode,
    super.restorationId,
    required this.min,
    required this.max,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.onChangeStart,
    this.onChangeEnd,
    this.label,
    this.semanticFormatterCallback,
    this.numberFormat,
    this.displayValues = DisplayValues.all,
    this.autofocus = false,
    this.mouseCursor,
    this.maxValueWidget,
    this.minValueWidget,
    this.valueWidget,
  }) : super(
          builder: (FormFieldState<double?> field) {
            final state = field as _FormBuilderSliderState;
            final effectiveNumberFormat =
                numberFormat ?? NumberFormat.compact();

            return InputDecorator(
              decoration: state.decoration,
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Slider(
                      value: field.value!,
                      min: min,
                      max: max,
                      divisions: divisions,
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                      onChangeEnd: onChangeEnd,
                      onChangeStart: onChangeStart,
                      label: label,
                      semanticFormatterCallback: semanticFormatterCallback,
                      onChanged: state.enabled
                          ? (value) {
                              field.didChange(value);
                            }
                          : null,
                      autofocus: autofocus,
                      mouseCursor: mouseCursor,
                      focusNode: state.effectiveFocusNode,
                    ),
                    Row(
                      children: <Widget>[
                        if (displayValues != DisplayValues.none &&
                            displayValues != DisplayValues.current)
                          minValueWidget
                                  ?.call(effectiveNumberFormat.format(min)) ??
                              Text(effectiveNumberFormat.format(min)),
                        const Spacer(),
                        if (displayValues != DisplayValues.none &&
                            displayValues != DisplayValues.minMax)
                          valueWidget?.call(
                                  effectiveNumberFormat.format(field.value)) ??
                              Text(effectiveNumberFormat.format(field.value)),
                        const Spacer(),
                        if (displayValues != DisplayValues.none &&
                            displayValues != DisplayValues.current)
                          maxValueWidget
                                  ?.call(effectiveNumberFormat.format(max)) ??
                              Text(effectiveNumberFormat.format(max)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );

  @override
  FormBuilderFieldDecorationState<FormBuilderSlider, double> createState() =>
      _FormBuilderSliderState();
}

class _FormBuilderSliderState
    extends FormBuilderFieldDecorationState<FormBuilderSlider, double> {}
