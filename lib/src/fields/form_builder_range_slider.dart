import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

/// Field to select a range of values on a Slider
class FormBuilderRangeSlider extends FormBuilderFieldDecoration<RangeValues> {
  /// Called when the user starts selecting new values for the slider.
  ///
  /// This callback shouldn't be used to update the slider [values] (use
  /// [onChanged] for that). Rather, it should be used to be notified when the
  /// user has started selecting a new value by starting a drag or with a tap.
  ///
  /// The values passed will be the last [values] that the slider had before the
  /// change began.
  ///
  ///  * [onChangeEnd] for a callback that is called when the value change is
  ///    complete.
  final ValueChanged<RangeValues>? onChangeStart;

  /// Called when the user is done selecting new values for the slider.
  ///
  /// This differs from [onChanged] because it is only called once at the end
  /// of the interaction, while [onChanged] is called as the value is getting
  /// updated within the interaction.
  ///
  /// This callback shouldn't be used to update the slider [values] (use
  /// [onChanged] for that). Rather, it should be used to know when the user has
  /// completed selecting a new [values] by ending a drag or a click.
  ///
  /// See also:
  ///
  ///  * [onChangeStart] for a callback that is called when a value change
  ///    begins.
  final ValueChanged<RangeValues>? onChangeEnd;

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
  /// Typically used with [labels] to show the current discrete values.
  ///
  /// If null, the slider is continuous.
  final int? divisions;

  /// Labels to show as text in the [SliderThemeData.rangeValueIndicatorShape].
  ///
  /// There are two labels: one for the start thumb and one for the end thumb.
  ///
  /// Each label is rendered using the active [ThemeData]'s
  /// [ThemeData.textTheme.bodyText1] text style, with the
  /// theme data's [ThemeData.colorScheme.onPrimaryColor]. The label's text
  /// style can be overridden with [SliderThemeData.valueIndicatorTextStyle].
  ///
  /// If null, then the value indicator will not be displayed.
  ///
  /// See also:
  ///
  ///  * [RangeSliderValueIndicatorShape] for how to create a custom value
  ///    indicator shape.
  final RangeLabels? labels;

  /// The color of the track's active segment, i.e. the span of track between
  /// the thumbs.
  ///
  /// Defaults to [ColorScheme.primary].
  ///
  /// Using a [SliderTheme] gives more fine-grained control over the
  /// appearance of various components of the slider.
  final Color? activeColor;

  /// The color of the track's inactive segments, i.e. the span of tracks
  /// between the min and the start thumb, and the end thumb and the max.
  ///
  /// Defaults to [ColorScheme.primary] with 24% opacity.
  ///
  /// Using a [SliderTheme] gives more fine-grained control over the
  /// appearance of various components of the slider.
  final Color? inactiveColor;

  /// The callback used to create a semantic value from the slider's values.
  ///
  /// Defaults to formatting values as a percentage.
  ///
  /// This is used by accessibility frameworks like TalkBack on Android to
  /// inform users what the currently selected value is with more context.
  final SemanticFormatterCallback? semanticFormatterCallback;

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

  /// Creates field to select a range of values on a Slider
  FormBuilderRangeSlider({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.decoration,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.onReset,
    super.focusNode,
    required this.min,
    required this.max,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.onChangeStart,
    this.onChangeEnd,
    this.labels,
    this.semanticFormatterCallback,
    this.displayValues = DisplayValues.all,
    this.minValueWidget,
    this.valueWidget,
    this.maxValueWidget,
    this.numberFormat,
  }) : super(builder: (FormFieldState<RangeValues?> field) {
          final state = field as _FormBuilderRangeSliderState;
          final effectiveNumberFormat = numberFormat ?? NumberFormat.compact();
          if (field.value == null ||
              field.value!.start < min ||
              field.value!.start > max ||
              field.value!.end < min ||
              field.value!.end > max) {
            if (initialValue == null) {
              field.setValue(RangeValues(min, min));
            } else {
              field.setValue(
                RangeValues(initialValue.start, initialValue.end),
              );
            }
          }
          return InputDecorator(
            decoration: state.decoration,
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RangeSlider(
                    values: field.value!,
                    min: min,
                    max: max,
                    divisions: divisions,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onChangeEnd: onChangeEnd,
                    onChangeStart: onChangeStart,
                    labels: labels,
                    semanticFormatterCallback: semanticFormatterCallback,
                    onChanged: state.enabled
                        ? (values) {
                            field.didChange(values);
                          }
                        : null,
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
                                '${effectiveNumberFormat.format(field.value!.start)} - ${effectiveNumberFormat.format(field.value!.end)}') ??
                            Text(
                                '${effectiveNumberFormat.format(field.value!.start)} - ${effectiveNumberFormat.format(field.value!.end)}'),
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
        });

  @override
  FormBuilderFieldDecorationState<FormBuilderRangeSlider, RangeValues>
      createState() => _FormBuilderRangeSliderState();
}

class _FormBuilderRangeSliderState extends FormBuilderFieldDecorationState<
    FormBuilderRangeSlider, RangeValues> {}
