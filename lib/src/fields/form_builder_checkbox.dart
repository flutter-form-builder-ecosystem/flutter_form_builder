import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCheckbox extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final bool initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final bool leadingInput;

  final Widget label;

  FormBuilderCheckbox({
    @required this.attribute,
    @required this.label,
    this.initialValue = false,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.leadingInput = false,
  });

  @override
  _FormBuilderCheckboxState createState() => _FormBuilderCheckboxState();
}

class _FormBuilderCheckboxState extends State<FormBuilderCheckbox> {
  bool _readonly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _readonly = (_formState?.readonly == true) ? true : widget.readonly;
    super.initState();
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  Widget _checkbox(FormFieldState<dynamic> field) {
    return Checkbox(
      value: field.value ?? false,
      onChanged: _readonly
          ? null
          : (bool value) {
              field.didChange(value);
              if (widget.onChanged != null) widget.onChanged(value);
            },
    );
  }

  Widget _leading(FormFieldState<dynamic> field) {
    if (widget.leadingInput) return _checkbox(field);
    return null;
  }

  Widget _trailing(FormFieldState<dynamic> field) {
    if (!widget.leadingInput) return _checkbox(field);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: _fieldKey,
      enabled: !_readonly,
      initialValue: widget.initialValue ?? false,
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
      },
      onSaved: (val) {
        if (widget.valueTransformer != null) {
          var transformed = widget.valueTransformer(val);
          FormBuilder.of(context)
              ?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, val);
      },
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readonly,
            errorText: field.errorText,
          ),
          child: ListTile(
            dense: true,
            isThreeLine: false,
            contentPadding: EdgeInsets.all(0.0),
            title: widget.label,
            leading: _leading(field),
            trailing: _trailing(field),
            onTap: _readonly
                ? null
                : () {
                    bool newValue = !(field.value ?? false);
                    field.didChange(newValue);
                    if (widget.onChanged != null) widget.onChanged(newValue);
                  },
          ),
        );
      },
    );
  }
}
