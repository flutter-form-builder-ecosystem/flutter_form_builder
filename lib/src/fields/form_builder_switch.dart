import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSwitch extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final bool initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final Widget label;

  FormBuilderSwitch({
    @required this.attribute,
    @required this.label,
    this.initialValue = false,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
  });

  @override
  _FormBuilderSwitchState createState() => _FormBuilderSwitchState();
}

class _FormBuilderSwitchState extends State<FormBuilderSwitch> {
  bool _readonly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;

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
    _readonly = (_formState?.readonly == true) ? true : widget.readonly;

    return FormField(
        key: _fieldKey,
        enabled: !_readonly,
        initialValue: widget.initialValue ?? false,
        validator: (val) {
          for (int i = 0; i < widget.validators.length; i++) {
            if (widget.validators[i](val) != null)
              return widget.validators[i](val);
          }
          return null;
        },
        onSaved: (val) {
          if (widget.valueTransformer != null) {
            var transformed = widget.valueTransformer(val);
            _formState?.setAttributeValue(widget.attribute, transformed);
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
              trailing: Switch(
                value: field.value,
                onChanged: _readonly
                    ? null
                    : (bool value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        field.didChange(value);
                        if (widget.onChanged != null) widget.onChanged(value);
                      },
              ),
              onTap: _readonly
                  ? null
                  : () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      bool newValue = !(field.value ?? false);
                      field.didChange(newValue);
                      if (widget.onChanged != null) widget.onChanged(newValue);
                    },
            ),
          );
        });
  }
}
