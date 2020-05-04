import 'dart:async';
import 'dart:ui' as ui;

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

enum InputType { date, time, both }

class FormBuilderDateTimePicker extends FormBuilderField {
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
      "This field will be removed in the next major version. Selected time or current time will be used on TimePicker instead")
  final TimeOfDay initialTime;

  /// If defined, the TextField [decoration]'s [suffixIcon] will be
  /// overridden to reset the input using the icon defined here.
  /// Set this to `null` to stop that behavior. Defaults to [Icons.close].
  final Icon resetIcon;

  /// Called when an enclosing form is saved. The value passed will be `null`
  /// if [format] fails to parse the text.
  // final FormFieldSetter<DateTime> onSaved;

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

  /// Corresponds to the [showDatePicker()] parameter.
  final bool useRootNavigator;

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
  final TransitionBuilder transitionBuilder;

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
  // final ValueChanged<DateTime> onChanged;

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
    Key key,
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
    // this.onChanged,
    this.initialDate,
    // this.onSaved,
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
    this.transitionBuilder,
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
    this.useRootNavigator = true,
  }) : super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validators: validators,
            valueTransformer: valueTransformer,
            // onChanged: onChanged,
            readOnly: readOnly,
            builder: (FormFieldState field) {
              final _FormBuilderDateTimePickerState state = field;
              return DateTimeField(
                key: state.fieldKey,
                initialValue: state.initialValue,
                format: state.dateFormat,
                /*onSaved: (val) {
            var value = _fieldKey.currentState.value;
            var transformed;
            if (valueTransformer != null) {
              transformed = valueTransformer(val);
              _formState?.setAttributeValue(attribute, transformed);
            } else
              _formState?.setAttributeValue(attribute, value);
            if (onSaved != null) {
              onSaved(transformed ?? value);
            }
          },*/
                validator: (val) {
                  for (int i = 0; i < validators.length; i++) {
                    if (validators[i](val) != null) return validators[i](val);
                  }
                  return null;
                },
                onShowPicker: state.onShowPicker,
                autovalidate: autovalidate,
                resetIcon: resetIcon,
                textDirection: textDirection,
                textAlign: textAlign,
                maxLength: maxLength,
                autofocus: autofocus,
                decoration: decoration,
                readOnly: state.readOnly,
                enabled: state.readOnly ? false : enabled,
                autocorrect: autocorrect,
                controller: state.textFieldController,
                focusNode: state.focusNode,
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
                maxLengthEnforced: maxLengthEnforced,
                maxLines: maxLines,
                obscureText: obscureText,
                showCursor: showCursor,
                minLines: minLines,
                expands: expands,
                style: style,
                onEditingComplete: onEditingComplete,
                buildCounter: buildCounter,
                cursorColor: cursorColor,
                cursorRadius: cursorRadius,
                cursorWidth: cursorWidth,
                enableInteractiveSelection: enableInteractiveSelection,
                keyboardAppearance: keyboardAppearance,
                onFieldSubmitted: onFieldSubmitted,
                scrollPadding: scrollPadding,
                strutStyle: strutStyle,
                textCapitalization: textCapitalization,
                textInputAction: textInputAction,
              );
            });

  final StrutStyle strutStyle;

  @override
  _FormBuilderDateTimePickerState createState() =>
      _FormBuilderDateTimePickerState();
}

class _FormBuilderDateTimePickerState extends FormBuilderFieldState {
  FormBuilderDateTimePicker get widget => super.widget;
  DateTime _initialValue;
  FocusNode _focusNode;

  FocusNode get focusNode => _focusNode;

  TextEditingController get textFieldController => _textFieldController;
  TextEditingController _textFieldController;
  DateTime stateCurrentValue;
  DateFormat get dateFormat => _dateFormat;
  DateFormat _dateFormat;

  final _dateTimeFormats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  @override
  void initState() {
    super.initState();
    stateCurrentValue = _initialValue;
    _focusNode = widget.focusNode ?? FocusNode();
    _textFieldController = widget.controller ?? TextEditingController();
    _dateFormat = widget.format ?? _dateTimeFormats[widget.inputType];
    _textFieldController.text =
        _initialValue == null ? '' : _dateFormat.format(_initialValue);
    _focusNode.addListener(_handleFocus);
  }

  // Hack to avoid manual editing of date - as is in DateTimeField library
  _handleFocus() async {
    setState(() {
      stateCurrentValue = value;
    });
    if (_focusNode.hasFocus) {
      _textFieldController.clear();
    }
  }

  Future<DateTime> onShowPicker(
      BuildContext context, DateTime currentValue) async {
    currentValue = stateCurrentValue;
    DateTime newValue;
    switch (widget.inputType) {
      case InputType.date:
        newValue = await _showDatePicker(context, currentValue) ?? currentValue;
        break;
      case InputType.time:
        var newTime = await _showTimePicker(context, currentValue);
        newValue =
            newTime != null ? DateTimeField.convert(newTime) : currentValue;
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
    didChange(newValue);
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
        lastDate: widget.lastDate ?? DateTime(2100),
        locale: widget.locale,
        textDirection: widget.textDirection,
        useRootNavigator: widget.useRootNavigator,
        builder: widget.transitionBuilder,
      );
    }
  }

  Future<TimeOfDay> _showTimePicker(
      BuildContext context, DateTime currentValue) {
    if (widget.timePicker != null) {
      return widget.timePicker(context);
    } else {
      return showTimePicker(
        context: context,
        // initialTime: widget.initialTime ?? TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
        initialTime: currentValue != null
            ? TimeOfDay.fromDateTime(currentValue)
            // ignore: deprecated_member_use_from_same_package
            : widget.initialTime ?? TimeOfDay.fromDateTime(DateTime.now()),
        builder: widget.transitionBuilder,
        useRootNavigator: widget.useRootNavigator,
      ).then(
        (result) {
          return result ??
              (currentValue != null
                  ? TimeOfDay.fromDateTime(currentValue)
                  : null);
        },
      );
    }
  }
}
