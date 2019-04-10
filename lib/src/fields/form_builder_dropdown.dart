import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdown extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final Widget hint;
  final List<DropdownMenuItem> items;
  final bool isExpanded;
  final TextStyle style;
  final bool isDense;
  final int elevation;
  final Widget disabledHint;
  final double iconSize;

  FormBuilderDropdown({
    @required this.attribute,
    @required this.items,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.isExpanded = true,
    this.isDense = false,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.hint,
    this.initialValue,
    this.style,
    this.disabledHint,
    this.onChanged,
    this.valueTransformer,
  });

  @override
  _FormBuilderDropdownState createState() => _FormBuilderDropdownState();
}

class _FormBuilderDropdownState extends State<FormBuilderDropdown> {
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
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            errorText: field.errorText,
            border: InputBorder.none,
          ),
          child: DropdownButton(
            isExpanded: widget.isExpanded,
            hint: widget.hint,
            items: widget.items,
            value: field.value,
            style: widget.style,
            isDense: widget.isDense,
            disabledHint: widget.disabledHint,
            elevation: widget.elevation,
            iconSize: widget.iconSize,
            onChanged: _readonly
                ? null
                : (value) {
                    field.didChange(value);
                    if (widget.onChanged != null) widget.onChanged(value);
                  },
          ),
        );
      },
    );
  }
}
