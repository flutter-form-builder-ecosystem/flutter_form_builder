import 'dart:async';
import 'dart:core';

import 'package:date_range_picker/date_range_picker.dart' as date_range_picker;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/always_disabled_focus_node.dart';
import 'package:intl/intl.dart' as intl;

class FormBuilderDateRangePicker extends FormBuilderField {
  final String attribute;
  final FormFieldValidator validator;
  final List<DateTime> initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final bool autovalidate;
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
  final bool enabled;
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
  final FormFieldSetter onSaved;

  FormBuilderDateRangePicker({
    Key key,
    @required this.attribute,
    @required this.firstDate,
    @required this.lastDate,
    @required this.format,
    this.initialValue = const [],
    this.validator,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.autovalidate = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enabled = true,
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
    this.onChanged,
    this.valueTransformer,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.initialFirstDate,
    this.initialLastDate,
    this.initialDatePickerMode = date_range_picker.DatePickerMode.day,
    this.locale,
    this.selectableDayPredicate,
    this.onSaved,
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final FormBuilderDateRangePickerState state = field;

            return TextField(
              enabled: !state.readOnly,
              style: style,
              focusNode: state.readOnly
                  ? AlwaysDisabledFocusNode()
                  : state.effectiveFocusNode,
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: field.errorText,
              ),
              // initialValue: "${_initialValue ?? ''}",
              maxLines: maxLines,
              keyboardType: keyboardType,
              obscureText: obscureText,
              onEditingComplete: onEditingComplete,
              controller: state.effectiveController,
              autocorrect: autocorrect,
              autofocus: autofocus,
              buildCounter: buildCounter,
              cursorColor: cursorColor,
              cursorRadius: cursorRadius,
              cursorWidth: cursorWidth,
              enableInteractiveSelection: enableInteractiveSelection,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              keyboardAppearance: keyboardAppearance,
              maxLengthEnforced: maxLengthEnforced,
              scrollPadding: scrollPadding,
              textAlign: textAlign,
              textCapitalization: textCapitalization,
              textDirection: textDirection,
              textInputAction: textInputAction,
              strutStyle: strutStyle,
              readOnly: true,
              expands: expands,
              minLines: minLines,
              showCursor: showCursor,
            );
          },
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

class FormBuilderDateRangePickerState extends FormBuilderFieldState {
  FormBuilderDateRangePicker get widget => super.widget;

  FocusNode _effectiveFocusNode;

  FocusNode get effectiveFocusNode => _effectiveFocusNode;

  TextEditingController _effectiveController;

  TextEditingController get effectiveController => _effectiveController;

  @override
  void initState() {
    _effectiveFocusNode = widget.focusNode ?? FocusNode();
    _effectiveController = widget.controller ??
        TextEditingController(
          text: _valueToText(),
        );
    _effectiveFocusNode.addListener(_handleFocus);
    super.initState();
  }

  _handleFocus() async {
    if (_effectiveFocusNode.hasFocus) {
      _hideKeyboard();
      var initialFirstDate = value.isEmpty
          ? (widget.initialFirstDate ?? DateTime.now())
          : value[0];
      var initialLastDate = value.isEmpty
          ? (widget.initialLastDate ?? initialFirstDate)
          : (value.length < 2 ? initialFirstDate : value[1]);
      final List<DateTime> picked = await date_range_picker.showDatePicker(
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
      didChange(picked);
    }
  }

  _valueToText() {
    if (value == null || value.isEmpty) {
      return "";
    }
    if (value.length == 1) {
      return "${format(value[0])}";
    }
    return "${format(value[0])} - ${format(value[1])}";
  }

  void _hideKeyboard() {
    Future.microtask(() => FocusScope.of(context).requestFocus(FocusNode()));
  }

  String format(DateTime date) =>
      FormBuilderDateRangePicker.tryFormat(date, widget.format);

  _setTextFieldString() {
    setState(() {
      _effectiveController.text = _valueToText();
    });
  }

  @override
  void didChange(value) {
    super.didChange(value);
    _setTextFieldString();
  }

  @override
  void reset() {
    super.reset();
    _setTextFieldString();
  }

  @override
  void dispose() {
    _effectiveController?.dispose();
    _effectiveFocusNode?.dispose();
    super.dispose();
  }
}
