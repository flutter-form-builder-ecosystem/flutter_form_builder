import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderField<T> extends FormField<T> {
  final String attribute;
  final ValueTransformer valueTransformer;
  final List<FormFieldValidator> validators;
  final ValueChanged onChanged;

  FormBuilderField({
    @required this.attribute,
    @required FormFieldBuilder<T> builder,
    this.valueTransformer,
    this.validators = const [],
    this.onChanged,
    //From Super
    Key key,
    FormFieldSetter<T> onSaved,
    T initialValue,
    bool autovalidate = false,
    bool enabled = true,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          autovalidate: autovalidate,
          enabled: enabled,
          builder: builder,
          validator: (val) {
            for (int i = 0; i < validators.length; i++) {
              if (validators[i](val) != null) return validators[i](val);
            }
            return null;
          },
        );

  @override
  _FormBuilderFieldState<T> createState() => _FormBuilderFieldState();
}

class _FormBuilderFieldState<T> extends FormFieldState<T> {
  @override
  FormBuilderField<T> get widget => super.widget;

  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  bool readOnly = false;
  T _initialValue;

  @override
  void initState() {
    super.initState();
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        (_formState.initialValue.containsKey(widget.attribute)
            ? _formState.initialValue[widget.attribute]
            : null);
    setValue(_initialValue);
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  void save() {
    super.save();
    if (widget.valueTransformer != null) {
      var transformed = widget.valueTransformer(value);
      FormBuilder.of(context)?.setAttributeValue(widget.attribute, transformed);
    } else
      _formState?.setAttributeValue(widget.attribute, value);
  }

  @override
  void didChange(T value) {
    if (widget.onChanged != null) widget.onChanged(value);
    super.didChange(value);
  }
}
