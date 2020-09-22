import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';

class FormBuilderTouchSpin extends FormBuilderField {
  final double step;
  final double min;
  final double max;
  final Icon subtractIcon;
  final Icon addIcon;
  final double iconSize;

  final NumberFormat displayFormat;

  final EdgeInsets iconPadding;

  final TextStyle textStyle;

  final Color iconActiveColor;

  final Color iconDisabledColor;

  FormBuilderTouchSpin({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    @required double initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
    this.step,
    this.min = 1,
    this.max = 9999,
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
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState field) {
            final _FormBuilderTouchSpinState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: TouchSpin(
                key: ObjectKey(state.value),
                min: min,
                max: max,
                step: step,
                value: field.value,
                iconSize: iconSize,
                onChanged: state.readOnly
                    ? null
                    : (value) {
                        state.requestFocus();
                        state.didChange(value);
                      },
                displayFormat: displayFormat,
                textStyle: textStyle,
                addIcon: addIcon,
                subtractIcon: subtractIcon,
                iconActiveColor:
                    iconActiveColor ?? Theme.of(state.context).primaryColor,
                iconDisabledColor:
                    iconDisabledColor ?? Theme.of(state.context).disabledColor,
                iconPadding: iconPadding,
                enabled: !state.readOnly,
              ),
            );
          },
        );

  @override
  _FormBuilderTouchSpinState createState() => _FormBuilderTouchSpinState();
}

class _FormBuilderTouchSpinState extends FormBuilderFieldState {
  @override
  FormBuilderTouchSpin get widget => super.widget as FormBuilderTouchSpin;
}
