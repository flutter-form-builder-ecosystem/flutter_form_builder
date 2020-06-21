import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCheckboxList<T> extends FormBuilderField<List<T>> {
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final List<T> initialValue;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueChanged onChanged;
  @override
  final ValueTransformer valueTransformer;

  final List<FormBuilderFieldOption> options;
  final ListTileControlAffinity controlAffinity;
  final Color activeColor;
  final Color checkColor;

  // final Widget secondary;

  FormBuilderCheckboxList({
    Key key,
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validator,
    this.readOnly = false,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.activeColor,
    this.checkColor,
    // this.secondary,
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderCheckboxListState<T> state = field;
            List<Widget> checkboxList = [];

            for (var i = 0; i < options.length; i++) {
              checkboxList.addAll([
                CheckboxListTile(
                  value: state.value.contains(options[i].value),
                  title: options[i],
                  onChanged: state.readOnly
                      ? null
                      : (val) {
                          var currentValue = [...state.value];
                          if (!currentValue.contains(options[i].value)) {
                            currentValue.add(options[i].value);
                          } else {
                            currentValue.remove(options[i].value);
                          }
                          state.didChange(currentValue);
                        },
                  dense: true,
                  isThreeLine: false,
                  controlAffinity: controlAffinity,
                  // secondary: secondary,
                  activeColor: activeColor,
                  checkColor: checkColor,
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
                key: ObjectKey(state.value),
                children: checkboxList,
              ),
            );
          },
        );

  @override
  _FormBuilderCheckboxListState<T> createState() =>
      _FormBuilderCheckboxListState();
}

class _FormBuilderCheckboxListState<T> extends FormBuilderFieldState<List<T>> {
  @override
  FormBuilderCheckboxList<T> get widget => super.widget;
}
