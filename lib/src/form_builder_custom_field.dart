import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCustomField<T> extends FormBuilderField<T> {
  final Widget Function(FormFieldState<T>) builder;

  FormBuilderCustomField({
    Key key,
    @required String attribute,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    T initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<T> onChanged,
    FormFieldSetter<T> onSaved,
    bool readOnly = false,
    ValueTransformer<T> valueTransformer,
    List<FormFieldValidator<T>> validators = const [],
    @required this.builder,
  }) : super(
          key: key,
          attribute: attribute,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: initialValue,
          decoration: decoration,
          onChanged: onChanged,
          onSaved: onSaved,
          valueTransformer: valueTransformer,
          validators: validators,
        );

  @override
  FormBuilderCustomFieldState<T> createState() =>
      FormBuilderCustomFieldState<T>();
}

class FormBuilderCustomFieldState<T>
    extends FormBuilderFieldState<FormBuilderCustomField<T>, T, T> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(widget.attribute),
      child: FormField<T>(
        key: fieldKey,
        enabled: widget.enabled,
        initialValue: initialValue,
        autovalidateMode: widget.autovalidateMode,
        validator: (val) => validate(val),
        onSaved: (val) => save(val),
        builder: widget.builder,
      ),
    );
  }
}
