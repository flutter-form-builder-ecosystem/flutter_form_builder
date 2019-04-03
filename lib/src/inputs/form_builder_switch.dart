import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSwitch extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final bool initialValue;
  final bool readonly;
  final InputDecoration decoration;

  final Widget label;

  FormBuilderSwitch({
    @required this.attribute,
    @required this.label,
    this.initialValue = false,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
  });

  @override
  _FormBuilderSwitchState createState() => _FormBuilderSwitchState();
}

class _FormBuilderSwitchState extends State<FormBuilderSwitch> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      // key: _fieldKey,
        enabled: !(widget.readonly),
        initialValue: widget.initialValue ?? false,
        validator: (val) {
          for (int i = 0; i < widget.validators.length; i++) {
            if (widget.validators[i](val) != null)
              return widget.validators[i](val);
          }
        },
        onSaved: (val) {
          FormBuilder.of(context)?.setValue(widget.attribute, val);
        },
        builder: (FormFieldState<dynamic> field) {
          return InputDecorator(
            decoration: widget.decoration.copyWith(
              enabled: !(widget.readonly || widget.readonly),
              errorText: field.errorText,
            ),
            child: ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: EdgeInsets.all(0.0),
              title: widget.label,
              trailing: Switch(
                value: field.value,
                onChanged: (widget.readonly || widget.readonly)
                    ? null
                    : (bool value) {
                  field.didChange(value);
                },
              ),
              onTap: (widget.readonly || widget.readonly)
                  ? null
                  : () {
                bool newValue = !(field.value ?? false);
                field.didChange(newValue);
              },
            ),
          );
        });
  }
}
