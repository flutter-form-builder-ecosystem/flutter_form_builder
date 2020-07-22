import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderRadioList<T> extends FormBuilderField<T> {
  final List<FormBuilderFieldOption> options;
  final Color activeColor;
  final ListTileControlAffinity controlAffinity;

  FormBuilderRadioList({
    Key key,
    //From Super
    @required String attribute,
    FormFieldValidator validator,
    T initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    bool autovalidate = false,
    VoidCallback onReset,
    FocusNode focusNode,
    this.activeColor,
    @required this.options,
    this.controlAffinity = ListTileControlAffinity.leading,
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidate: autovalidate,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          builder: (FormFieldState field) {
            final _FormBuilderRadioState state = field;
            var radioList = [];
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
                          state.requestFocus();
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
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: Column(
                children: List<Widget>.from(radioList),
              ),
            );
          },
        );

  @override
  _FormBuilderRadioState<T> createState() => _FormBuilderRadioState();
}

class _FormBuilderRadioState<T> extends FormBuilderFieldState<T> {
  @override
  FormBuilderRadioList<T> get widget => super.widget as FormBuilderRadioList;
}
