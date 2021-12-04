import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';

/// Field for selection of a number by tapping on an add or subtract icon
class FormBuilderTouchSpin extends FormBuilderField<num> {
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
    required String name,
    FormFieldValidator<num>? validator,
    num? initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<num?>? onChanged,
    ValueTransformer<num?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<num>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    this.step = 1.0,
    this.min = 1.0,
    this.max = 9999999.0,
    this.iconSize = 24.0,
    this.displayFormat,
    this.subtractIcon = const Icon(Icons.remove),
    this.addIcon = const Icon(Icons.add),
    this.iconPadding = const EdgeInsets.all(4.0),
    this.textStyle = const TextStyle(fontSize: 24),
    this.iconActiveColor,
    this.iconDisabledColor,
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
          builder: (FormFieldState<num?> field) {
            final state = field as _FormBuilderTouchSpinState;
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
                        state.requestFocus();
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
  _FormBuilderTouchSpinState createState() => _FormBuilderTouchSpinState();
}

class _FormBuilderTouchSpinState
    extends FormBuilderFieldState<FormBuilderTouchSpin, num> {}
