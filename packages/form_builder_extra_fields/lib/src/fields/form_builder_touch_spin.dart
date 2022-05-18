import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';

/// Field for selection of a number by tapping on an add or subtract icon
class FormBuilderTouchSpin extends FormBuilderField<num> {
  final bool shouldRequestFocus;

  /// Value to increment or decrement by
  final num step;

  /// The minimum value the user can select.
  ///
  /// Defaults to 0.0. Must be less than or equal to [max].
  final num min;

  /// The maximum value the user can select.
  ///
  /// Defaults to 1.0. Must be greater than or equal to [min].
  final num max;

  /// Icon for the decrement button
  final Icon subtractIcon;

  /// Icon for the decrement button
  final Icon addIcon;

  /// Icon sizes for the decrement and increment buttons
  final double iconSize;

  /// NumberFormat to be used when displaying values
  final NumberFormat? displayFormat;

  /// Spacing around the decrement and increment icons
  final EdgeInsets iconPadding;

  /// Text styling for the current value of the control
  final TextStyle textStyle;

  /// Color of icon while the widget is in active state
  final Color? iconActiveColor;

  /// Color of icon while the widget is in active state
  final Color? iconDisabledColor;

  /// Creates field for selection of a number by tapping on an add or subtract icon
  FormBuilderTouchSpin({
    Key? key,
    //From Super
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    FocusNode? focusNode,
    FormFieldSetter<num>? onSaved,
    FormFieldValidator<num>? validator,
    InputDecoration decoration = const InputDecoration(),
    num? initialValue,
    required String name,
    ValueChanged<num?>? onChanged,
    ValueTransformer<num?>? valueTransformer,
    VoidCallback? onReset,
    this.addIcon = const Icon(Icons.add),
    this.displayFormat,
    this.iconActiveColor,
    this.iconDisabledColor,
    this.iconPadding = const EdgeInsets.all(4.0),
    this.iconSize = 24.0,
    this.max = 9999999.0,
    this.min = 1.0,
    this.step = 1.0,
    this.subtractIcon = const Icon(Icons.remove),
    this.textStyle = const TextStyle(fontSize: 24),
    this.shouldRequestFocus = false,
  }) : super(
          autovalidateMode: autovalidateMode,
          decoration: decoration,
          enabled: enabled,
          focusNode: focusNode,
          initialValue: initialValue,
          key: key,
          name: name,
          onChanged: onChanged,
          onReset: onReset,
          onSaved: onSaved,
          validator: validator,
          valueTransformer: valueTransformer,
          builder: (FormFieldState<num?> field) {
            final state = field as FormBuilderTouchSpinState;
            final theme = Theme.of(state.context);

            return InputDecorator(
              decoration: state.decoration,
              child: TouchSpin(
                key: ObjectKey(state.value),
                min: min,
                max: max,
                step: step,
                value: field.value ?? 0,
                iconSize: iconSize,
                onChanged: state.enabled
                    ? (value) {
                        if (shouldRequestFocus) {
                          state.requestFocus();
                        }
                        state.didChange(value);
                      }
                    : null,
                displayFormat: displayFormat,
                textStyle: textStyle,
                addIcon: addIcon,
                subtractIcon: subtractIcon,
                iconActiveColor: iconActiveColor ?? theme.primaryColor,
                iconDisabledColor: iconDisabledColor ?? theme.disabledColor,
                iconPadding: iconPadding,
                enabled: state.enabled,
              ),
            );
          },
        );

  @override
  FormBuilderTouchSpinState createState() => FormBuilderTouchSpinState();
}

class FormBuilderTouchSpinState
    extends FormBuilderFieldState<FormBuilderTouchSpin, num> {}
