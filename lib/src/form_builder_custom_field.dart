import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCustomField<T> extends StatefulWidget {
  /// Identifier for the field input.
  ///
  /// Used as a key to final map returned when the form is submitted
  final String attribute;

  /// The [FormField] widget that will house the custom input
  final FormField<T> formField;

  /// An optional list of [FormFieldValidator]s that validates the input in the field.
  final List<FormFieldValidator> validators;

  /// Called before field value is submitted.
  ///
  /// Can be used to convert the value to the output expected by the user.
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
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  bool readonly = false;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    super.initState();
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*return widget.formField
      ..onSaved = (T val) {
        _formState?.setValue(widget.attribute, val);
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
        key: _fieldKey,
        onSaved: (val) {
          if (widget.formField.onSaved != null) widget.formField.onSaved(val);
          if (widget.valueTransformer != null) {
            var transformed = widget.valueTransformer(val);
            FormBuilder.of(context)
                ?.setAttributeValue(widget.attribute, transformed);
          } else
            _formState?.setAttributeValue(widget.attribute, val);
        },
        validator: (val) {
          for (int i = 0; i < widget.validators.length; i++) {
            if (widget.validators[i](val) != null)
              return widget.validators[i](val);
          }
          if (widget.formField.validator != null)
            return widget.formField.validator(val);
          return null;
        },
        builder:
            widget.formField.builder ?? (FormField<T> field) => Container(),
        enabled: widget.formField.enabled,
        autovalidate: widget.formField.autovalidate,
        initialValue: widget.formField.initialValue,
      ), //widget.formField,
    );
  }
}
