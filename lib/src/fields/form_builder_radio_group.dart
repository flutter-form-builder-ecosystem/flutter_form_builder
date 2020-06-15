import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:group_radio_button/group_radio_button.dart';

class FormBuilderRadioGroup extends FormBuilderField {
  final String attribute;
  final FormFieldValidator validator;
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
  final EdgeInsets contentPadding;
  final Axis direction;
  final MainAxisAlignment horizontalAlignment;
  final double spaceBetween;

  FormBuilderRadioGroup({
    Key key,
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validator,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.leadingInput = false,
    this.materialTapTargetSize,
    this.activeColor,
    this.onSaved,
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
          builder: (FormFieldState field) {
            final _FormBuilderRadioGroupState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: field.errorText,
              ),
              child: RadioGroup.builder(
                groupValue: field.value,
                onChanged: state.readOnly
                    ? null
                    : (value) {
                  FocusScope.of(state.context).requestFocus(FocusNode());
                  field.didChange(value);
                  if (onChanged != null) onChanged(value);
                },
                items: options
                    .map((option) => option.value)
                    .toList(growable: false),
                itemBuilder: (item) {
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
  _FormBuilderRadioGroupState createState() => _FormBuilderRadioGroupState();
}

class _FormBuilderRadioGroupState extends FormBuilderFieldState {
  FormBuilderRadioGroup get widget => super.widget;
}
