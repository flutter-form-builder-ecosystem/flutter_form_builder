import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCheckbox extends FormBuilderField<bool> {
  final String attribute;
  final List<FormFieldValidator> validators;
  final bool initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final bool leadingInput;
  final Widget label;
  final Color activeColor;
  final Color checkColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;

  FormBuilderCheckbox({
    Key key,
    @required this.attribute,
    @required this.label,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.leadingInput = false,
    this.activeColor,
    this.checkColor,
    this.materialTapTargetSize,
    this.tristate = false,
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validators: validators,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (field) {
            _FormBuilderCheckboxState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: field.errorText,
              ),
              child: ListTile(
                dense: true,
                isThreeLine: false,
                contentPadding: EdgeInsets.all(0.0),
                title: label,
                leading: _leading(field),
                trailing: _trailing(field),
                onTap: state.readOnly
                    ? null
                    : () {
                        bool newValue = !(field.value ?? false);
                        _changeVal(field, newValue);
                      },
              ),
            );
          },
        );

  @override
  _FormBuilderCheckboxState createState() => _FormBuilderCheckboxState();

  static Widget _checkbox(_FormBuilderCheckboxState field) {
    return Checkbox(
      value:
          (field.value == null && !field.widget.tristate) ? false : field.value,
      activeColor: field.widget.activeColor,
      checkColor: field.widget.checkColor,
      materialTapTargetSize: field.widget.materialTapTargetSize,
      tristate: field.widget.tristate,
      onChanged: field.readOnly
          ? null
          : (value) {
              _changeVal(field, value);
            },
    );
  }

  static void _changeVal(_FormBuilderCheckboxState field, bool value) {
    field.didChange(value);
  }

  static Widget _leading(_FormBuilderCheckboxState field) {
    if (field.widget.leadingInput) return _checkbox(field);
    return null;
  }

  static Widget _trailing(_FormBuilderCheckboxState field) {
    if (!field.widget.leadingInput) return _checkbox(field);
    return null;
  }
}

class _FormBuilderCheckboxState extends FormBuilderFieldState<bool> {
  FormBuilderCheckbox get widget => super.widget;
}
