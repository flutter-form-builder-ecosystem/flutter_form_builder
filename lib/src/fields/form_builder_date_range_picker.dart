import 'dart:async';
import 'dart:core';

import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/always_disabled_focus_node.dart';
import 'package:intl/intl.dart' as intl;

class FormBuilderDateRangePicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
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
  final DateRangePicker.DatePickerMode initialDatePickerMode;
  final Locale locale;
  final DateRangePicker.SelectableDayPredicate selectableDayPredicate;
  final intl.DateFormat format;
  final FormFieldSetter onSaved;

  FormBuilderDateRangePicker({
    @required this.attribute,
    @required this.firstDate,
    @required this.lastDate,
    @required this.format,
    this.initialValue,
    this.validators = const [],
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
    this.initialDatePickerMode = DateRangePicker.DatePickerMode.day,
    this.locale,
    this.selectableDayPredicate,
    this.onSaved,
  });

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

class FormBuilderDateRangePickerState
    extends State<FormBuilderDateRangePicker> {
  bool _readOnly = false;
  TextEditingController _controller;
  FormBuilderState _formState;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  List<DateTime> _initialValue;
  List<DateTime> _currentValue;
  FocusNode _focusNode;

  List<DateTime> get value => _currentValue ?? [];

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = _currentValue = widget.initialValue ??
        (_formState.initialValue.containsKey(widget.attribute)
            ? _formState.initialValue[widget.attribute]
            : []);
    _controller = TextEditingController(
      text: _valueToText(),
    );
    _effectiveController.addListener(() {
      if (widget.onChanged != null) widget.onChanged(_effectiveController.text);
    });
    _focusNode = FocusNode();
    widget.focusNode?.addListener(_handleFocus);
    _focusNode?.addListener(_handleFocus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = (_formState?.readOnly == true) ? true : widget.readOnly;
    return FormField(
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _initialValue,
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        return null;
      },
      onSaved: (val) {
        var transformed;
        if (widget.valueTransformer != null) {
          transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, val);
        if (widget.onSaved != null) {
          widget.onSaved(transformed ?? val);
        }
      },
      autovalidate: widget.autovalidate ?? false,
      builder: (FormFieldState<List<DateTime>> field) {
        return TextField(
          enabled: !_readOnly,
          style: widget.style,
          focusNode:
              _readOnly ? AlwaysDisabledFocusNode() : _effectiveFocusNode,
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
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
          readOnly: _readOnly,
          expands: widget.expands,
          minLines: widget.minLines,
          showCursor: widget.showCursor,
        );
      },
    );
  }

  _handleFocus() async {
    if (_effectiveFocusNode.hasFocus) {
      _hideKeyboard();
      var initialFirstDate = value.isEmpty ? DateTime.now() : value[0];
      var initialLastDate = value.length < 2
          ? initialFirstDate /*.add(Duration(minutes: 5))*/
          : value[1];
      final List<DateTime> picked = await DateRangePicker.showDatePicker(
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
      _fieldKey.currentState.didChange(picked);
      _setCurrentValue(picked);
      _effectiveController.text = _valueToText();
    }
  }

  _valueToText() {
    if (value.isEmpty) {
      return "";
    } else if (value.length == 1) {
      return "${format(value[0])}";
    }
    return "${format(value[0])} - ${format(value[1])}";
  }

  _setCurrentValue(val) {
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
    _formState?.unregisterFieldKey(widget.attribute);
    _effectiveController.dispose();
    super.dispose();
  }
}
