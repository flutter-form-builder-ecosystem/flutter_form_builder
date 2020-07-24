import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSegmentedControl<T> extends FormBuilderField<T> {
  final Color borderColor;
  final Color selectedColor;
  final Color pressedColor;
  final List<FormBuilderFieldOption> options;
  final EdgeInsetsGeometry padding;
  final Color unselectedColor;

  FormBuilderSegmentedControl({
    Key key,
    //From Super
    @required String name,
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
    @required this.options,
    this.borderColor,
    this.selectedColor,
    this.pressedColor,
    this.padding,
    this.unselectedColor,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
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
            final _FormBuilderSegmentedControlState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
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
                  groupValue: state.value,
                  children: {
                    for (var option in options)
                      option.value: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: option,
                      ),
                  },
                  padding: padding,
                  unselectedColor: unselectedColor,
                  onValueChanged: (dynamic value) {
                    state.requestFocus();
                    if (state.readOnly) {
                      field.reset();
                    } else {
                      field.didChange(value);
                    }
                  },
                ),
              ),
            );
          },
        );

  @override
  _FormBuilderSegmentedControlState<T> createState() =>
      _FormBuilderSegmentedControlState();
}

class _FormBuilderSegmentedControlState<T> extends FormBuilderFieldState<T> {
  @override
  FormBuilderSegmentedControl<T> get widget =>
      super.widget as FormBuilderSegmentedControl;
}
