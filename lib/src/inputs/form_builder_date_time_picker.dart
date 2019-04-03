import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class FormBuilderDateTimePicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final DateTime initialValue;
  final bool readonly;
  final InputDecoration decoration;

  final DateFormat format;
  final DateTime firstDate;
  final DateTime lastDate;
  final InputType inputType; //TODO: Create own enum

  FormBuilderDateTimePicker({
    @required this.attribute,
    this.validators = const [],
    this.readonly = false,
    this.inputType = InputType.both,
    this.initialValue,
    this.format,
    this.firstDate,
    this.lastDate,
    this.decoration,
  });

  @override
  _FormBuilderDateTimePickerState createState() =>
      _FormBuilderDateTimePickerState();
}

class _FormBuilderDateTimePickerState extends State<FormBuilderDateTimePicker> {
  final _dateTimeFormats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  @override
  Widget build(BuildContext context) {
    return DateTimePickerFormField(
      inputType: widget.inputType,
      initialValue: widget.initialValue,
      format: widget.format != null
          ? widget.format
          : _dateTimeFormats[widget.inputType],
      enabled: !widget.readonly,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      decoration: widget.decoration.copyWith(
        enabled: !(widget.readonly),
      ),
      onSaved: (val) {
        FormBuilder.of(context).setValue(widget.attribute, val);
      },
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
      },
    );
  }
}
