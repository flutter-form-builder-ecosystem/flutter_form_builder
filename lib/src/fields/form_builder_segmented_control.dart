import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSegmentedControl extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final Color borderColor;
  final Color selectedColor;
  final Color pressedColor;
  final FormFieldSetter onSaved;

  final List<FormBuilderFieldOption> options;

  final EdgeInsetsGeometry padding;

  final Color unselectedColor;

  FormBuilderSegmentedControl({
    Key key,
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.borderColor,
    this.selectedColor,
    this.pressedColor,
    this.padding,
    this.unselectedColor,
    this.onSaved,
  }) : super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validators: validators,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            builder: (FormFieldState field) {
              final _FormBuilderSegmentedControlState state = field;

              return InputDecorator(
                decoration: decoration.copyWith(
                  enabled: !state.readOnly,
                  errorText: field.errorText,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: CupertinoSegmentedControl(
                    borderColor: state.readOnly
                        ? Theme.of(state.context).disabledColor
                        : borderColor ?? Theme.of(state.context).primaryColor,
                    selectedColor: state.readOnly
                        ? Theme.of(state.context).disabledColor
                        : selectedColor ?? Theme.of(state.context).primaryColor,
                    pressedColor: state.readOnly
                        ? Theme.of(state.context).disabledColor
                        : pressedColor ?? Theme.of(state.context).primaryColor,
                    groupValue: field.value,
                    children: Map.fromIterable(
                      options,
                      key: (option) => option.value,
                      value: (option) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: option,
                      ),
                    ),
                    padding: padding,
                    unselectedColor: unselectedColor,
                    onValueChanged: (dynamic value) {
                      if (state.readOnly) {
                        field.reset();
                      } else {
                        field.didChange(value);
                      }
                    },
                  ),
                ),
              );
            });

  @override
  _FormBuilderSegmentedControlState createState() =>
      _FormBuilderSegmentedControlState();
}

class _FormBuilderSegmentedControlState extends FormBuilderFieldState {
  FormBuilderSegmentedControl get widget => super.widget;
}
