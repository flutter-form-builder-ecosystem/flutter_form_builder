import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

/// Field to select a range of values on a Slider
class FormBuilderRangeSlider extends FormBuilderField<RangeValues> {
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

  final DisplayValues displayValues;
  final TextStyle? minTextStyle;
  final TextStyle? textStyle;
  final TextStyle? maxTextStyle;
  final NumberFormat? numberFormat;

  /// Creates field to select a range of values on a Slider
  FormBuilderRangeSlider({
    Key? key,
    //From Super
    required String name,
    FormFieldValidator<RangeValues>? validator,
    RangeValues? initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<RangeValues?>? onChanged,
    ValueTransformer<RangeValues?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<RangeValues>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
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
    this.minTextStyle,
    this.textStyle,
    this.maxTextStyle,
    this.numberFormat,
  }) : super(
            key: key,
            initialValue: initialValue,
            name: name,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            autovalidateMode: autovalidateMode,
            onSaved: onSaved,
            enabled: enabled,
            onReset: onReset,
            decoration: decoration,
            focusNode: focusNode,
            builder: (FormFieldState<RangeValues?> field) {
              final state = field as _FormBuilderRangeSliderState;
              final _numberFormat = numberFormat ?? NumberFormat.compact();

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
                                state.requestFocus();
                                field.didChange(values);
                              }
                            : null,
                      ),
                      Row(
                        children: <Widget>[
                          if (displayValues != DisplayValues.none &&
                              displayValues != DisplayValues.current)
                            Text(
                              _numberFormat.format(min),
                              style: minTextStyle ?? textStyle,
                            ),
                          const Spacer(),
                          if (displayValues != DisplayValues.none &&
                              displayValues != DisplayValues.minMax)
                            Text(
                              '${_numberFormat.format(field.value!.start)} - ${_numberFormat.format(field.value!.end)}',
                              style: textStyle,
                            ),
                          const Spacer(),
                          if (displayValues != DisplayValues.none &&
                              displayValues != DisplayValues.current)
                            Text(
                              _numberFormat.format(max),
                              style: maxTextStyle ?? textStyle,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });

  @override
  _FormBuilderRangeSliderState createState() => _FormBuilderRangeSliderState();
}

class _FormBuilderRangeSliderState
    extends FormBuilderFieldState<FormBuilderRangeSlider, RangeValues> {}
