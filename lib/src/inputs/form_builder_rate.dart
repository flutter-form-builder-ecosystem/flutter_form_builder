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
  });

  @override
  _FormBuilderRateState createState() => _FormBuilderRateState();
}

class _FormBuilderRateState extends State<FormBuilderRate> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      enabled: !(widget.readonly),
      // key: _fieldKey,
      initialValue: widget.initialValue,
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
            enabled: !(widget.readonly),
            errorText: field.errorText,
          ),
          child: SyRate(
            value: field.value,
            total: widget.max,
            icon: widget.icon,
            iconSize: widget.iconSize, //TODO: When disabled change icon color (Probably deep grey)
            onTap: (widget.readonly)
                ? null
                : (value) {
                    field.didChange(value);
                  },
          ),
        );
      },
    );
  }
}
