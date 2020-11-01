import 'dart:async';
import 'dart:core';

import 'package:date_range_picker/date_range_picker.dart' as date_range_picker;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/always_disabled_focus_node.dart';
import 'package:intl/intl.dart' as intl;

class FormBuilderDateRangePicker extends FormBuilderField<List<DateTime>> {
  final int maxLines;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle style;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final bool maxLengthEnforced;
  final int maxLength;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;
  final bool expands;
  final int minLines;
  final bool showCursor;
  final DateTime initialFirstDate;
  final DateTime initialLastDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final date_range_picker.DatePickerMode initialDatePickerMode;
  final Locale locale;
  final date_range_picker.SelectableDayPredicate selectableDayPredicate;
  final intl.DateFormat format;

  FormBuilderDateRangePicker({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    List<DateTime> initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<List<DateTime>> onChanged,
    FormFieldSetter<List<DateTime>> onSaved,
    ValueTransformer<List<DateTime>> valueTransformer,
    List<FormFieldValidator<List<DateTime>>> validators = const [],
    @required this.firstDate,
    @required this.lastDate,
    @required this.format,
    this.maxLines = 1,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforced = true,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.keyboardType,
    this.style,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.initialFirstDate,
    this.initialLastDate,
    this.initialDatePickerMode = date_range_picker.DatePickerMode.day,
    this.locale,
    this.selectableDayPredicate,
  })  : assert(
            initialValue == null ||
                lastDate == null ||
                initialValue[1] == null ||
                initialValue[1].isBefore(lastDate),
            'The last date of initialValue must be on or before lastDate'),
        assert(
            initialValue == null ||
                firstDate == null ||
                initialValue[0] == null ||
                initialValue[0].isAfter(firstDate),
            'The first date of initialValue must be on or after firstDate'),
        assert(
            lastDate == null ||
                firstDate == null ||
                lastDate.isAfter(firstDate),
            'lastDate must be on or after firstDate'),
        super(
          key: key,
          attribute: attribute,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: initialValue,
          decoration: decoration,
          onChanged: onChanged,
          onSaved: onSaved,
          valueTransformer: valueTransformer,
          validators: validators,
        );

  @override
  FormBuilderDateRangePickerState createState() =>
      FormBuilderDateRangePickerState();

  static String tryFormat(DateTime date, intl.DateFormat format) {
    if (date != null) {
      try {
        return format.format(date);
      } catch (e) {
        // print('Error formatting date: $e');
      }
    }
    return '';
  }
}

class FormBuilderDateRangePickerState extends FormBuilderFieldState<
    FormBuilderDateRangePicker, List<DateTime>, List<DateTime>> {
  TextEditingController _controller;
  List<DateTime> _currentValue;
  FocusNode _focusNode;

  List<DateTime> get value => _currentValue ?? [];

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _valueToText());
    _focusNode = FocusNode();
    _effectiveFocusNode?.addListener(_handleFocus);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<DateTime>>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue,
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<List<DateTime>> field) {
        return TextField(
          enabled: widget.enabled,
          style: widget.style,
          focusNode: readOnly ? AlwaysDisabledFocusNode() : _effectiveFocusNode,
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          // initialValue: "${_initialValue ?? ''}",
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          onEditingComplete: widget.onEditingComplete,
          controller: _effectiveController,
          autocorrect: widget.autocorrect,
          autofocus: widget.autofocus,
          buildCounter: widget.buildCounter,
          cursorColor: widget.cursorColor,
          cursorRadius: widget.cursorRadius,
          cursorWidth: widget.cursorWidth,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          keyboardAppearance: widget.keyboardAppearance,
          maxLengthEnforced: widget.maxLengthEnforced,
          scrollPadding: widget.scrollPadding,
          textAlign: widget.textAlign,
          textCapitalization: widget.textCapitalization,
          textDirection: widget.textDirection,
          textInputAction: widget.textInputAction,
          strutStyle: widget.strutStyle,
          readOnly: true,
          expands: widget.expands,
          minLines: widget.minLines,
          showCursor: widget.showCursor,
        );
      },
    );
  }

  Future<void> _handleFocus() async {
    if (_effectiveFocusNode.hasFocus) {
      _hideKeyboard();
      var initialFirstDate = value.isEmpty
          ? (widget.initialFirstDate ?? DateTime.now())
          : value[0];
      var initialLastDate = value.isEmpty
          ? (widget.initialLastDate ?? initialFirstDate)
          : (value.length < 2 ? initialFirstDate : value[1]);
      final picked = await date_range_picker.showDatePicker(
        context: context,
        initialFirstDate: initialFirstDate,
        initialLastDate: initialLastDate,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        initialDatePickerMode: widget.initialDatePickerMode,
        locale: widget.locale,
        textDirection: widget.textDirection,
        selectableDayPredicate: widget.selectableDayPredicate,
      );
      if (picked != null) {
        if (picked.length == 1) {
          picked.add(picked[0]);
        }
        fieldKey.currentState.didChange(picked);
        widget.onChanged?.call(picked);
        _setCurrentValue(picked);
        _effectiveController.text = _valueToText();
      }
    }
  }

  String _valueToText() {
    if (value.isEmpty) {
      return '';
    } else if (value.length == 1) {
      return format(value[0]);
    }
    return '${format(value[0])} - ${format(value[1])}';
  }

  void _setCurrentValue(val) {
    setState(() {
      _currentValue = val ?? [];
    });
  }

  void _hideKeyboard() {
    Future.microtask(() => FocusScope.of(context).requestFocus(FocusNode()));
  }

  String format(DateTime date) =>
      FormBuilderDateRangePicker.tryFormat(date, widget.format);

  @override
  void dispose() {
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }
}
