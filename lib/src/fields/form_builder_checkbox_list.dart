import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCheckboxList extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final List<FormBuilderFieldOption> options;

  FormBuilderCheckboxList({
    @required this.attribute,
    @required this.options,
    this.initialValue = const [],
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
  });

  @override
  _FormBuilderCheckboxListState createState() =>
      _FormBuilderCheckboxListState();
}

class _FormBuilderCheckboxListState extends State<FormBuilderCheckboxList> {
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
        enabled: !_readonly,
        initialValue: widget.initialValue,
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
            FormBuilder.of(context)?.setAttributeValue(widget.attribute, val);
        },
        builder: (FormFieldState<dynamic> field) {
          List<Widget> checkboxList = [];
          for (int i = 0; i < widget.options.length; i++) {
            checkboxList.addAll([
              ListTile(
                dense: true,
                isThreeLine: false,
                contentPadding: EdgeInsets.all(0.0),
                leading: Checkbox(
                  value: field.value.contains(widget.options[i].value),
                  onChanged: _readonly
                      ? null
                      : (bool value) {
                          var currValue = field.value;
                          if (value)
                            currValue.add(widget.options[i].value);
                          else
                            currValue.remove(widget.options[i].value);
                          field.didChange(currValue);
                          if (widget.onChanged != null)
                            widget.onChanged(currValue);
                        },
                ),
                title: Text(
                    "${widget.options[i].label ?? widget.options[i].value}"),
                onTap: _readonly
                    ? null
                    : () {
                        var currentValue = field.value;
                        if (!currentValue.contains(widget.options[i].value))
                          currentValue.add(widget.options[i].value);
                        else
                          currentValue.remove(widget.options[i].value);
                        field.didChange(currentValue);
                        if (widget.onChanged != null)
                          widget.onChanged(currentValue);
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
              children: checkboxList,
            ),
          );
        });
  }
}
