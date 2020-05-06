import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCheckboxList<T> extends FormBuilderField<List<T>> {
  final String attribute;
  final List<FormFieldValidator> validators;
  final List<T> initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final List<FormBuilderFieldOption> options;
  final bool leadingInput;
  final Color activeColor;
  final Color checkColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;

  FormBuilderCheckboxList({
    Key key,
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.leadingInput = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
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
            builder: (FormFieldState field) {
              final _FormBuilderCheckboxListState<T> state = field;

              List<Widget> checkboxList = [];
              for (int i = 0; i < options.length; i++) {
                checkboxList.addAll([
                  ListTile(
                    key: UniqueKey(),
                    dense: true,
                    isThreeLine: false,
                    contentPadding: EdgeInsets.all(0.0),
                    leading: state._leading(state, i),
                    trailing: state._trailing(state, i),
                    title: options[i],
                    onTap: state.readOnly
                        ? null
                        : () {
                            var currentValue = state.value;
                            if (!currentValue.contains(options[i].value))
                              currentValue.add(options[i].value);
                            else
                              currentValue.remove(options[i].value);
                            state.didChange(currentValue);
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
                  contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  border: InputBorder.none,
                ),
                child: Column(
                  children: checkboxList,
                ),
              );
            });

  @override
  _FormBuilderCheckboxListState<T> createState() =>
      _FormBuilderCheckboxListState();
}

class _FormBuilderCheckboxListState<T> extends FormBuilderFieldState<List<T>> {
  FormBuilderCheckboxList<T> get widget => super.widget;

  Widget _checkbox(_FormBuilderCheckboxListState field, int i) {
    return Checkbox(
      activeColor: field.widget.activeColor,
      checkColor: field.widget.checkColor,
      materialTapTargetSize: field.widget.materialTapTargetSize,
      tristate: field.widget.tristate,
      value: field.value.contains(field.widget.options[i].value),
      onChanged: field.readOnly
          ? null
          : (bool value) {
              field.requestFocus();
              var currValue = field.value;
              if (value)
                currValue.add(field.widget.options[i].value);
              else
                currValue.remove(field.widget.options[i].value);
              field.didChange(currValue);
            },
    );
  }

  Widget _leading(_FormBuilderCheckboxListState field, int i) {
    if (field.widget.leadingInput) return _checkbox(field, i);
    return null;
  }

  Widget _trailing(_FormBuilderCheckboxListState field, int i) {
    if (!field.widget.leadingInput) return _checkbox(field, i);
    return null;
  }
}
