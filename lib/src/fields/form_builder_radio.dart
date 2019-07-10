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
  final ValueTransformer valueTransformer;
  final bool leadingInput;

  final List<FormBuilderFieldOption> options;

  FormBuilderRadio({
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.leadingInput = false,
  });

  @override
  _FormBuilderRadioState createState() => _FormBuilderRadioState();
}

class _FormBuilderRadioState extends State<FormBuilderRadio> {
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

  Widget _radio(FormFieldState<dynamic> field, int i) {
    return Radio<dynamic>(
      value: widget.options[i].value,
      groupValue: field.value,
      onChanged: _readonly
          ? null
          : (dynamic value) {
              FocusScope.of(context).requestFocus(FocusNode());
              field.didChange(value);
              if (widget.onChanged != null) widget.onChanged(value);
            },
    );
  }

  Widget _leading(FormFieldState<dynamic> field, int i) {
    if (widget.leadingInput) return _radio(field, i);
    return null;
  }

  Widget _trailing(FormFieldState<dynamic> field, int i) {
    if (!widget.leadingInput) return _radio(field, i);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _readonly = (_formState?.readonly == true) ? true : widget.readonly;

    return FormField(
      key: _fieldKey,
      enabled: !_readonly,
      initialValue: widget.initialValue,
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
        List<Widget> radioList = [];
        for (int i = 0; i < widget.options.length; i++) {
          radioList.addAll([
            ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: EdgeInsets.all(0.0),
              leading: _leading(field, i),
              title:
                  Text("${widget.options[i].label ?? widget.options[i].value}"),
              trailing: _trailing(field, i),
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
