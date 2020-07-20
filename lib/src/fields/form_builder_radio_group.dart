import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:group_radio_button/group_radio_button.dart';

class FormBuilderRadioGroup<T> extends FormBuilderField<T> {
  final bool leadingInput;
  final List<FormBuilderFieldOption> options;
  final MaterialTapTargetSize materialTapTargetSize;
  final Color activeColor;
  final EdgeInsets contentPadding;
  final Axis direction;
  final MainAxisAlignment horizontalAlignment;
  final double spaceBetween;

  FormBuilderRadioGroup({
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
    @required this.options,
    this.leadingInput = false,
    this.materialTapTargetSize,
    this.activeColor,
    this.contentPadding = const EdgeInsets.all(0.0),
    this.direction = Axis.horizontal,
    this.horizontalAlignment = MainAxisAlignment.start,
    this.spaceBetween,
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
            final _FormBuilderRadioGroupState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: RadioGroup.builder(
                groupValue: field.value,
                onChanged: state.readOnly
                    ? null
                    : (value) {
                        FocusScope.of(state.context).requestFocus(FocusNode());
                        field.didChange(value);
                        onChanged?.call(value);
                      },
                items: options
                    .map((option) => option.value)
                    .toList(growable: false),
                itemBuilder: (item) {
                  // return item;
                  return RadioButtonBuilder(
                    item.toString(),
                    textPosition: RadioButtonTextPosition.right,
                  );
                },
                direction: direction,
                horizontalAlignment: horizontalAlignment,
                spacebetween: spaceBetween,
              ),
            );
          },
        );

  @override
  _FormBuilderRadioGroupState<T> createState() => _FormBuilderRadioGroupState();
}

class _FormBuilderRadioGroupState<T> extends FormBuilderFieldState<T> {
  @override
  FormBuilderRadioGroup<T> get widget => super.widget;
}
