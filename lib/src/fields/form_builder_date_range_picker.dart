import 'dart:async';
import 'dart:core';

import 'package:date_range_picker/date_range_picker.dart' as date_range_picker;
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

  final AutovalidateMode autovalidateMode;
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
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.autovalidateMode,
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
        super(key: key);

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
        ((_formState?.initialValue?.containsKey(widget.attribute) ?? false)
            ? _formState.initialValue[widget.attribute]
            : []);
    _controller = TextEditingController(text: _valueToText());
    _focusNode = FocusNode();
    _effectiveFocusNode?.addListener(_handleFocus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = _formState?.readOnly == true || widget.readOnly;

    return FormField(
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _initialValue,
      validator: (val) =>
          FormBuilderValidators.validateValidators(val, widget.validators),
      onSaved: (val) {
        var transformed;
        if (widget.valueTransformer != null) {
          transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else {
          _formState?.setAttributeValue(widget.attribute, val);
        }
        widget.onSaved?.call(transformed ?? val);
      },
      autovalidateMode: widget.autovalidateMode,
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
        _fieldKey.currentState.didChange(picked);
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
    _formState?.unregisterFieldKey(widget.attribute);
    _controller?.dispose();
    super.dispose();
  }
}
