import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class FormBuilderRate extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final num initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final num max;
  final IconData icon;
  final num iconSize;

  FormBuilderRate({
    @required this.attribute,
    this.initialValue = 1,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.max,
    this.icon = Icons.star,
    this.iconSize = 24.0,
    this.onChanged,
    this.valueTransformer,
  });

  @override
  _FormBuilderRateState createState() => _FormBuilderRateState();
}

class _FormBuilderRateState extends State<FormBuilderRate> {
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
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readonly,
            errorText: field.errorText,
          ),
          child: SyRate(
            value: field.value,
            total: widget.max,
            icon: widget.icon,
            iconSize: widget.iconSize,
            //TODO: When disabled change icon color (Probably deep grey)
            onTap: _readonly
                ? null
                : (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    field.didChange(value);
                    if (widget.onChanged != null) widget.onChanged(value);
                    return value;
                  },
          ),
        );
      },
    );
  }
}
