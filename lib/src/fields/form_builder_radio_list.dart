import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderRadioList extends FormBuilderField {
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final dynamic initialValue;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueChanged onChanged;
  @override
  final ValueTransformer valueTransformer;
  final List<FormBuilderFieldOption> options;

  final Color activeColor;
  @override
  final FormFieldSetter onSaved;
  final ListTileControlAffinity controlAffinity;

  FormBuilderRadioList({
    Key key,
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validator,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.activeColor,
    this.onSaved,
    this.controlAffinity = ListTileControlAffinity.leading,
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderRadioState state = field;
            List<Widget> radioList = [];
            for (var i = 0; i < options.length; i++) {
              radioList.addAll([
                RadioListTile(
                  dense: true,
                  isThreeLine: false,
                  title: options[i],
                  groupValue: state.value,
                  value: options[i].value,
                  onChanged: state.readOnly
                      ? null
                      : (val) {
                          field.didChange(options[i].value);
                        },
                  controlAffinity: controlAffinity,
                  activeColor: activeColor,
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
  @override
  FormBuilderRadioList get widget => super.widget;
}
