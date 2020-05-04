import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderRadio extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final bool leadingInput;

  final List<FormBuilderFieldOption> options;

  final MaterialTapTargetSize materialTapTargetSize;

  final Color activeColor;
  final FormFieldSetter onSaved;

  FormBuilderRadio({
    Key key,
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.leadingInput = false,
    this.materialTapTargetSize,
    this.activeColor,
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
            final _FormBuilderRadioState state = field;
            List<Widget> radioList = [];
            for (int i = 0; i < options.length; i++) {
              radioList.addAll([
                ListTile(
                  dense: true,
                  isThreeLine: false,
                  contentPadding: EdgeInsets.all(0.0),
                  leading: state._leading(state, i),
                  title: options[i],
                  trailing: state._trailing(state, i),
                  onTap: state.readOnly
                      ? null
                      : () {
                          field.didChange(options[i].value);
                        },
                ),
                Divider(
                  height: 0.0,
                ),
              ]);
            }
            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: field.errorText,
              ),
              child: Column(
                children: radioList,
              ),
            );
          },
        );

  @override
  _FormBuilderRadioState createState() => _FormBuilderRadioState();
}

class _FormBuilderRadioState extends FormBuilderFieldState {
  FormBuilderRadio get widget => super.widget;

  Widget _radio(_FormBuilderRadioState field, int i) {
    return Radio<dynamic>(
      value: field.widget.options[i].value,
      groupValue: field.value,
      materialTapTargetSize: field.widget.materialTapTargetSize,
      activeColor: field.widget.activeColor,
      onChanged: field.readOnly
          ? null
          : (dynamic value) {
              field.didChange(value);
            },
    );
  }

  Widget _leading(_FormBuilderRadioState field, int i) {
    if (field.widget.leadingInput) return _radio(field, i);
    return null;
  }

  Widget _trailing(_FormBuilderRadioState field, int i) {
    if (!field.widget.leadingInput) return _radio(field, i);
    return null;
  }
}
