import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';

class FormBuilderTouchSpin extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final double initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final double step;
  final double min;
  final double max;
  final FormFieldSetter onSaved;
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
    @required this.attribute,
    @required this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.step,
    this.min = 1,
    this.max = 9999,
    this.onChanged,
    this.valueTransformer,
    this.onSaved,
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
          attribute: attribute,
          validators: validators,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderTouchSpinState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: field.errorText,
              ),
              child: TouchSpin(
                min: min,
                max: max,
                step: step,
                value: field.value,
                iconSize: iconSize,
                onChanged: state.readOnly
                    ? null
                    : (value) {
                        field.didChange(value);
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
  FormBuilderTouchSpin get widget => super.widget;
}
