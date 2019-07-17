import 'dart:ui' as ui;
import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

enum InputType { date, time, both }

class FormBuilderDateTimePicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final DateTime initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueTransformer valueTransformer;

  /// The date/time picker dialogs to show.
  final InputType inputType;

  /// Allow manual editing of the date/time. Defaults to true. If false, the
  /// picker(s) will be shown every time the field gains focus.
  final bool editable;

  /// For representing the date as a string e.g.
  /// `DateFormat("EEEE, MMMM d, yyyy 'at' h:mma")`
  /// (Sunday, June 3, 2018 at 9:24pm)
  final DateFormat format;

  /// The date the calendar opens to when displayed. Defaults to the current date.
  ///
  /// To preset the widget's value, use [initialValue] instead.
  final DateTime initialDate;

  /// The earliest choosable date. Defaults to 1900.
  final DateTime firstDate;

  /// The latest choosable date. Defaults to 2100.
  final DateTime lastDate;

  /// The initial time prefilled in the picker dialog when it is shown. Defaults
  /// to noon. Explicitly set this to `null` to use the current time.
  final TimeOfDay initialTime;

  /// If defined, the TextField [decoration]'s [suffixIcon] will be
  /// overridden to reset the input using the icon defined here.
  /// Set this to `null` to stop that behavior. Defaults to [Icons.close].
  final IconData resetIcon;

  /// For validating the [DateTime]. The value passed will be `null` if
  /// [format] fails to parse the text.
  final FormFieldValidator<DateTime> validator;

  /// Called when an enclosing form is saved. The value passed will be `null`
  /// if [format] fails to parse the text.
  final FormFieldSetter<DateTime> onSaved;

  /// Corresponds to the [showDatePicker()] parameter. Defaults to
  /// [DatePickerMode.day].
  final DatePickerMode initialDatePickerMode;

  /// Corresponds to the [showDatePicker()] parameter.
  ///
  /// See [GlobalMaterialLocalizations](https://docs.flutter.io/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html)
  /// for acceptable values.
  final Locale locale;

  /// Corresponds to the [showDatePicker()] parameter.
  final bool Function(DateTime) selectableDayPredicate;

  /// Corresponds to the [showDatePicker()] parameter.
  final ui.TextDirection textDirection;

  /// Called when an enclosing form is submitted. The value passed will be
  /// `null` if [format] fails to parse the text.
  final ValueChanged<DateTime> onFieldSubmitted;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextStyle style;
  final TextAlign textAlign;

  /// Preset the widget's value.
  final bool autofocus;
  final bool autovalidate;
  final bool obscureText;
  final bool autocorrect;
  final bool maxLengthEnforced;
  final int maxLines;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final TransitionBuilder builder;

  /// Called when the time chooser dialog should be shown. In the future the
  /// preferred way of using this widget will be to utilize the [datePicker] and
  /// [timePicker] callback functions instead of adding their parameter list to
  /// this widget.
  final Future<TimeOfDay> Function(BuildContext context) timePicker;

  /// Called when the date chooser dialog should be shown. In the future the
  /// preferred way of using this widget will be to utilize the [datePicker] and
  /// [timePicker] callback functions instead of adding their parameter list to
  /// this widget.
  final Future<DateTime> Function(BuildContext context) datePicker;

  /// Called whenever the state's value changes, e.g. after picker value(s)
  /// have been selected or when the field loses focus. To listen for all text
  /// changes, use the [controller] and [focusNode].
  final ValueChanged<DateTime> onChanged;

  FormBuilderDateTimePicker({
    @required this.attribute,
    this.validators = const [],
    this.readonly = false,
    this.inputType = InputType.both,
    this.initialValue,
    this.format,
    this.firstDate,
    this.lastDate,
    this.decoration = const InputDecoration(),
    this.editable = true,
    this.onChanged,
    this.resetIcon = Icons.close,
    this.initialDate,
    this.initialTime = const TimeOfDay(hour: 12, minute: 0),
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.autovalidate = false,
    this.initialDatePickerMode,
    this.locale,
    this.selectableDayPredicate,
    this.textDirection,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.style,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLengthEnforced = true,
    this.enabled,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.valueTransformer,
    this.builder,
    this.timePicker,
    this.datePicker,
  });

  @override
  _FormBuilderDateTimePickerState createState() =>
      _FormBuilderDateTimePickerState();
}

class _FormBuilderDateTimePickerState extends State<FormBuilderDateTimePicker> {
  bool _readonly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;

  final _dateTimeFormats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

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

    return DateTimeField(
      key: _fieldKey,
      initialValue: widget.initialValue,
      format: widget.format != null
          ? widget.format
          : _dateTimeFormats[widget.inputType],
      onSaved: (val) {
        if (widget.valueTransformer != null) {
          var transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, val);
      },
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        return null;
      },
      onChanged: widget.onChanged,
      autovalidate: widget.autovalidate,
      resetIcon: Icon(widget.resetIcon),
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      decoration: widget.decoration,
      enabled: widget.editable,
      autocorrect: widget.autocorrect,
      readOnly: _readonly,
      controller: widget.controller,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      maxLengthEnforced: widget.maxLengthEnforced,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      onShowPicker: (ctx, time) async {
        switch (widget.inputType) {
          case InputType.date:
            return _showDatePicker(context);
          case InputType.time:
            return DateTimeField.convert(await _showTimePicker(context));
          case InputType.both:
            final date = await _showDatePicker(context);
            if (date != null) {
              final time = await _showTimePicker(context);
              return DateTimeField.combine(date, time);
            }
            return _fieldKey.currentState.value ?? widget.initialValue;
          default:
            throw "unexcepted input type ${widget.inputType}";
        }
      },
    );
  }

  Future<DateTime> _showDatePicker(BuildContext context) {
    if (widget.datePicker != null) {
      return widget.datePicker(context);
    } else {
      return showDatePicker(
          context: context,
          selectableDayPredicate: widget.selectableDayPredicate,
          initialDatePickerMode:
              widget.initialDatePickerMode ?? DatePickerMode.day,
          initialDate: widget.initialDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate);
    }
  }

  Future<TimeOfDay> _showTimePicker(BuildContext context) {
    if (widget.timePicker != null) {
      return widget.timePicker(context);
    } else {
      return showTimePicker(context: context, initialTime: widget.initialTime);
    }
  }
}
