import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSlider extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final num initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueChanged onChanged;

  final num max;
  final num min;
  final int divisions;

  FormBuilderSlider({
    @required this.attribute,
    @required this.min,
    @required this.max,
    @required this.initialValue,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.divisions,
    this.onChanged,
  });

  @override
  _FormBuilderSliderState createState() => _FormBuilderSliderState();
}

class _FormBuilderSliderState extends State<FormBuilderSlider> {
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
        FormBuilder.of(context)?.setAttributeValue(widget.attribute, val);
      },
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readonly,
            errorText: field.errorText,
          ),
          child: Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: field.value,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  onChanged: _readonly
                      ? null
                      : (num value) {
                          field.didChange(value);
                          if (widget.onChanged != null) widget.onChanged(value);
                        },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("${widget.min}"),
                    Text("${field.value}"),
                    Text("${widget.max}"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
