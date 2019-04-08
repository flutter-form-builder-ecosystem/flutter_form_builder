import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCustomField<T> extends StatefulWidget {
  final String attribute;
  final FormField<T> formField;
  final List<FormFieldValidator> validators;
  final ValueTransformer valueTransformer;

  FormBuilderCustomField({
    @required this.attribute,
    @required this.formField,
    this.validators = const [],
    this.valueTransformer,
  });

  @override
  FormBuilderCustomFieldState<T> createState() =>
      FormBuilderCustomFieldState<T>();
}

class FormBuilderCustomFieldState<T> extends State<FormBuilderCustomField<T>> {
  @override
  Widget build(BuildContext context) {
    /*return widget.formField
      ..onSaved = (T val) {
        FormBuilder.of(context)?.setValue(widget.attribute, val);
        if (widget.formField.onSaved != null) widget.formField.onSaved(val);
      }
      ..validator = (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        if (widget.formField.validator != null)
          return widget.formField.validator(val);
      };*/
    return Container(
      key: Key(widget.attribute),
      child: FormField(
        onSaved: (val) {
          if (widget.formField.onSaved != null) widget.formField.onSaved(val);
          var transformed = val;
          if (widget.valueTransformer != null)
            transformed = widget.valueTransformer(val);
          FormBuilder.of(context)
              ?.setAttributeValue(widget.attribute, transformed);
        },
        validator: (val) {
          for (int i = 0; i < widget.validators.length; i++) {
            if (widget.validators[i](val) != null)
              return widget.validators[i](val);
          }
          if (widget.formField.validator != null)
            return widget.formField.validator(val);
        },
        builder:
            widget.formField.builder ?? (FormField<T> field) => Container(),
        enabled: widget.formField.enabled,
        autovalidate: widget.formField.autovalidate,
        initialValue: widget.formField.initialValue,
        key: widget.formField.key,
      ), //widget.formField,
    );
  }
}
