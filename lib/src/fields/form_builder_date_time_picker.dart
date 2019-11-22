import 'dart:async';
import 'dart:ui' as ui;

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
  final bool readOnly;
  final InputDecoration decoration;
  final ValueTransformer valueTransformer;

  /// The date/time picker dialogs to show.
  final InputType inputType;

  /// Allow manual editing of the date/time. Defaults to true. If false, the
  /// picker(s) will be shown every time the field gains focus.
  // final bool editable;

  /// For representing the date as a string e.g.
  /// `DateFormat("EEEE, MMMM d, yyyy 'at' h:mma")`
  /// (Sunday, June 3, 2018 at 9:24pm)
  final DateFormat format;

  /// The date the calendar opens to when displayed. Defaults to the current date.
  ///
  /// To preset the widget's value, use [initialValue] instead.
  @Deprecated(
      "This field will be removed in version 4.0.0. Selected date or Current date will be used on DatePicker calendar instead")
  final DateTime initialDate;

  /// The earliest choosable date. Defaults to 1900.
  final DateTime firstDate;

  /// The latest choosable date. Defaults to 2100.
  final DateTime lastDate;

  /// The initial time prefilled in the picker dialog when it is shown. Defaults
  /// to noon. Explicitly set this to `null` to use the current time.
  @Deprecated(
      "This field will be removed in the next major version. Selected time or noon will be used on TimePicker instead")
  final TimeOfDay initialTime;

  /// If defined, the TextField [decoration]'s [suffixIcon] will be
  /// overridden to reset the input using the icon defined here.
  /// Set this to `null` to stop that behavior. Defaults to [Icons.close].
  final Icon resetIcon;

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

  final bool showCursor;

  final int minLines;

  final bool expands;

  final TextInputAction textInputAction;

  final VoidCallback onEditingComplete;

  final InputCounterWidgetBuilder buildCounter;

  // final VoidCallback onEditingComplete,
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;

  final double cursorWidth;
  final TextCapitalization textCapitalization;

  FormBuilderDateTimePicker({
    @required this.attribute,
    this.validators = const [],
    this.readOnly = false,
    this.inputType = InputType.both,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.cursorWidth = 2.0,
    this.enableInteractiveSelection = true,
    this.decoration = const InputDecoration(),
    this.resetIcon = const Icon(Icons.close),
    this.initialTime = const TimeOfDay(hour: 12, minute: 0),
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.maxLengthEnforced = true,
    this.expands = false,
    this.autovalidate = false,
    // this.editable = true,
    this.initialValue,
    this.format,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.initialDate,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.initialDatePickerMode,
    this.locale,
    this.selectableDayPredicate,
    this.textDirection,
    this.controller,
    this.focusNode,
    this.style,
    this.enabled,
    this.maxLength,
    this.inputFormatters,
    this.valueTransformer,
    this.builder,
    this.timePicker,
    this.datePicker,
    this.showCursor,
    this.minLines,
    this.textInputAction,
    this.onEditingComplete,
    this.buildCounter,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.textCapitalization = TextCapitalization.none,
    this.strutStyle,
  });

  final StrutStyle strutStyle;

  @override
  _FormBuilderDateTimePickerState createState() =>
      _FormBuilderDateTimePickerState();
}

class _FormBuilderDateTimePickerState extends State<FormBuilderDateTimePicker> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  DateTime _initialValue;
  FocusNode _focusNode;
  TextEditingController _textFieldController;
  DateTime stateCurrentValue;

  final _dateTimeFormats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  @override
  void initState() {
    super.initState();
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        (_formState.initialValue.containsKey(widget.attribute)
            ? _formState.initialValue[widget.attribute]
            : null);
    stateCurrentValue = _initialValue;
    _readOnly = (_formState?.readOnly == true) ? true : widget.readOnly;
    _focusNode = widget.focusNode ?? FocusNode();
    _textFieldController = widget.controller ?? TextEditingController();

    _textFieldController.text = _initialValue == null
        ? ''
        : widget.format == null
            ? DateFormat("EEEE, MMMM d, yyyy 'at' h:mma").format(_initialValue)
            : widget.format.format(_initialValue);
    _focusNode.addListener(_handleFocus);
  }

  // Hack to avoid manual editing of date - as is in DateTimeField library
  _handleFocus() async {
    setState(() {
      stateCurrentValue = _fieldKey.currentState.value;
    });
    if (_focusNode.hasFocus) {
      _textFieldController.clear();
    }
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      key: _fieldKey,
      initialValue: _initialValue,
      format: widget.format != null
          ? widget.format
          : _dateTimeFormats[widget.inputType],
      onSaved: (val) {
        var value = _fieldKey.currentState.value;
        var transformed;
        if (widget.valueTransformer != null) {
          transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, value);
        if (widget.onSaved != null) {
          widget.onSaved(transformed ?? value);
        }
      },
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        return null;
      },
      onShowPicker: _onShowPicker,
      // onChanged: widget.onChanged,
      autovalidate: widget.autovalidate,
      resetIcon: widget.resetIcon,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      decoration: widget.decoration,
      enabled: widget.enabled,
      autocorrect: widget.autocorrect,
      readOnly: _readOnly,
      controller: _textFieldController,
      focusNode: _focusNode,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      maxLengthEnforced: widget.maxLengthEnforced,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      showCursor: widget.showCursor,
      minLines: widget.minLines,
      expands: widget.expands,
      style: widget.style,
      onEditingComplete: widget.onEditingComplete,
      buildCounter: widget.buildCounter,
      cursorColor: widget.cursorColor,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      keyboardAppearance: widget.keyboardAppearance,
      onFieldSubmitted: widget.onFieldSubmitted,
      scrollPadding: widget.scrollPadding,
      strutStyle: widget.strutStyle,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
    );
  }

  Future<DateTime> _onShowPicker(
      BuildContext context, DateTime currentValue) async {
    currentValue = stateCurrentValue;
    DateTime newValue;
    switch (widget.inputType) {
      case InputType.date:
        newValue = await _showDatePicker(context, currentValue) ?? currentValue;
        break;
      case InputType.time:
        var newTime = await _showTimePicker(context, currentValue);
        newValue = DateTimeField.convert(newTime) ?? currentValue;
        break;
      case InputType.both:
        final date = await _showDatePicker(context, currentValue);
        if (date != null) {
          final time = await _showTimePicker(context, currentValue);
          newValue = DateTimeField.combine(date, time);
        }
        break;
      default:
        throw "Unexcepted input type ${widget.inputType}";
        break;
    }
    newValue = newValue ?? currentValue;
    _fieldKey.currentState.didChange(newValue);
    if (widget.onChanged != null)
      widget.onChanged(_fieldKey.currentState.value);
    return newValue;
  }

  Future<DateTime> _showDatePicker(
      BuildContext context, DateTime currentValue) {
    if (widget.datePicker != null) {
      return widget.datePicker(context);
    } else {
      return showDatePicker(
          context: context,
          selectableDayPredicate: widget.selectableDayPredicate,
          initialDatePickerMode:
              widget.initialDatePickerMode ?? DatePickerMode.day,
          // ignore: deprecated_member_use_from_same_package
          initialDate: currentValue ?? widget.initialDate ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime(1900),
          lastDate: widget.lastDate ?? DateTime(2100));
    }
  }

  Future<TimeOfDay> _showTimePicker(
      BuildContext context, DateTime currentValue) {
    if (widget.timePicker != null) {
      return widget.timePicker(context);
    } else {
      return showTimePicker(
          context: context,
          // ignore: deprecated_member_use_from_same_package
          initialTime: widget.initialTime ??
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()));
    }
  }
}
