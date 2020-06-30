import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCheckbox extends FormBuilderField<bool> {
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final bool initialValue;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueChanged onChanged;
  @override
  final ValueTransformer valueTransformer;
  final Widget title;
  final Widget subtitle;
  final Widget secondary;
  final Color activeColor;
  final Color checkColor;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsets contentPadding;

  FormBuilderCheckbox({
    Key key,
    @required this.attribute,
    @required this.title,
    this.initialValue,
    this.validator,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.activeColor,
    this.checkColor,
    this.subtitle,
    this.secondary,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.contentPadding = const EdgeInsets.all(0.0),
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderCheckboxState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: CheckboxListTile(
                dense: true,
                isThreeLine: false,
                title: title,
                subtitle: subtitle,
                value: state.value,
                onChanged: state.readOnly
                    ? null
                    : (val) {
                        state.didChange(val);
                      },
                checkColor: checkColor,
                activeColor: activeColor,
                secondary: secondary,
                controlAffinity: controlAffinity,
              ),
            );
          },
        );

  @override
  _FormBuilderCheckboxState createState() => _FormBuilderCheckboxState();
}

class _FormBuilderCheckboxState extends FormBuilderFieldState<bool> {
  @override
  FormBuilderCheckbox get widget => super.widget;
}
