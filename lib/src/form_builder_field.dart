import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderField<T> extends FormField<T> {
  final String attribute;
  final ValueTransformer valueTransformer;
  final List<FormFieldValidator> validators;
  final ValueChanged onChanged;
  final bool readOnly;
  final InputDecoration decoration;

  FormBuilderField({
    @required this.attribute,
    @required FormFieldBuilder<T> builder,
    this.valueTransformer,
    this.validators = const [],
    this.onChanged,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
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
  FormBuilderFieldState<T> createState() => FormBuilderFieldState();
}

class FormBuilderFieldState<T> extends FormFieldState<T> {
  @override
  FormBuilderField<T> get widget => super.widget;

  FormBuilderState get formState => _formBuilderState;

  bool get readOnly => _readOnly;

  bool get isPristine => _isPristine;
  // bool get isPristine => value != _initialValue;

  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formBuilderState;
  bool _readOnly = false;
  bool _isPristine = true;
  T _initialValue;

  @override
  void initState() {
    super.initState();
    _readOnly = (formState?.readOnly == true) ? true : widget.readOnly;
    _formBuilderState = FormBuilder.of(context);
    _formBuilderState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        (_formBuilderState.initialValue.containsKey(widget.attribute)
            ? _formBuilderState.initialValue[widget.attribute]
            : null);
    setValue(_initialValue);
  }

  @override
  void dispose() {
    _formBuilderState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  void save() {
    super.save();
    if (widget.valueTransformer != null) {
      var transformed = widget.valueTransformer(value);
      FormBuilder.of(context)?.setAttributeValue(widget.attribute, transformed);
    } else
      _formBuilderState?.setAttributeValue(widget.attribute, value);
  }

  @override
  void didChange(T value) {
    super.didChange(value);
    setState(() {
      _isPristine = value != _initialValue;
    });
    if (widget.onChanged != null) widget.onChanged(value);
  }
}
