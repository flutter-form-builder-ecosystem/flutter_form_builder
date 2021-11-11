import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

enum DisplayValues { all, current, minMax, none }

/// Field for selection of a numerical value on a slider
class FormBuilderSlider extends FormBuilderField<double> {
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

  ///TODO: Add documentation
  final NumberFormat? numberFormat;
  final DisplayValues displayValues;
  final TextStyle? minTextStyle;
  final TextStyle? textStyle;
  final TextStyle? maxTextStyle;

  /// Creates field for selection of a numerical value on a slider
  FormBuilderSlider({
    Key? key,
    //From Super
    required String name,
    FormFieldValidator<double>? validator,
    required double initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<double?>? onChanged,
    ValueTransformer<double?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<double>? onSaved,
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
    this.label,
    this.semanticFormatterCallback,
    this.numberFormat,
    this.displayValues = DisplayValues.all,
    this.minTextStyle,
    this.textStyle,
    this.maxTextStyle,
    this.autofocus = false,
    this.mouseCursor,
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
          builder: (FormFieldState<double?> field) {
            final state = field as _FormBuilderSliderState;
            final _numberFormat = numberFormat ?? NumberFormat.compact();
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
                              state.requestFocus();
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
                          Text(
                            _numberFormat.format(min),
                            style: minTextStyle ?? textStyle,
                          ),
                        const Spacer(),
                        if (displayValues != DisplayValues.none &&
                            displayValues != DisplayValues.minMax)
                          Text(
                            _numberFormat.format(field.value),
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
          },
        );

  @override
  _FormBuilderSliderState createState() => _FormBuilderSliderState();
}

class _FormBuilderSliderState
    extends FormBuilderFieldState<FormBuilderSlider, double> {}
