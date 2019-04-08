import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderRadio extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueChanged onChanged;

  final List<FormBuilderFieldOption> options;

  FormBuilderRadio({
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
  });

  @override
  _FormBuilderRadioState createState() => _FormBuilderRadioState();
}

class _FormBuilderRadioState extends State<FormBuilderRadio> {
  bool _readonly = false;

  @override
  void initState() {
    _readonly =
        (FormBuilder.of(context)?.readonly == true) ? true : widget.readonly;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      // key: _fieldKey,
      enabled: !_readonly && !_readonly,
      initialValue: widget.initialValue,
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
      },
      onSaved: (val) {
        FormBuilder.of(context)?.setAttributeValue(widget.attribute, val);
      },
      builder: (FormFieldState<dynamic> field) {
        List<Widget> radioList = [];
        for (int i = 0; i < widget.options.length; i++) {
          radioList.addAll([
            ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: EdgeInsets.all(0.0),
              leading: null,
              title:
                  Text("${widget.options[i].label ?? widget.options[i].value}"),
              trailing: Radio<dynamic>(
                value: widget.options[i].value,
                groupValue: field.value,
                onChanged: _readonly
                    ? null
                    : (dynamic value) {
                        field.didChange(value);
                        if (widget.onChanged != null) widget.onChanged(value);
                      },
              ),
              onTap: _readonly
                  ? null
                  : () {
                      field.didChange(widget.options[i].value);
                      if (widget.onChanged != null)
                        widget.onChanged(widget.options[i].value);
                    },
            ),
            Divider(
              height: 0.0,
            ),
          ]);
        }
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readonly,
            errorText: field.errorText,
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
            border: InputBorder.none,
          ),
          child: Column(
            children: radioList,
          ),
        );
      },
    );
  }
}
