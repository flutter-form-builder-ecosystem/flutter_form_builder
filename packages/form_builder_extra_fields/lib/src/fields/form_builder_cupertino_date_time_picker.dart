import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

enum CupertinoDateTimePickerInputType { date, time, both }

class FormBuilderCupertinoDateTimePicker extends FormBuilderField<DateTime> {
  /// Called when an enclosing form is submitted. The value passed will be
  /// `null` if [format] fails to parse the text.
  final ValueChanged<DateTime>? onFieldSubmitted;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextStyle? style;
  final TextAlign textAlign;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final MaxLengthEnforcement maxLengthEnforcement;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TransitionBuilder? transitionBuilder;

  /// Called whenever the state's value changes, e.g. after picker value(s)
  /// have been selected or when the field loses focus. To listen for all text
  /// changes, use the [controller] and [focusNode].
  // final ValueChanged<DateTime> onChanged;

  final bool showCursor;

  final int? minLines;

  final bool expands;

  final TextInputAction? textInputAction;

  final VoidCallback? onEditingComplete;

  final InputCounterWidgetBuilder? buildCounter;

  // final VoidCallback onEditingComplete,
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;

  final double cursorWidth;
  final TextCapitalization textCapitalization;
  final ui.TextDirection? textDirection;
  final StrutStyle strutStyle;

  //
  final bool alwaysUse24HourFormat;
  final CupertinoDateTimePickerInputType inputType;
  final DateCancelledCallback? onCancel;
  final DateChangedCallback? onConfirm;
  final DateFormat? format;
  final DatePickerTheme? theme;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Locale? locale;

  FormBuilderCupertinoDateTimePicker({
    Key? key,
    //From Super
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    DateTime? initialValue,
    FocusNode? focusNode,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    InputDecoration decoration = const InputDecoration(),
    required String name,
    ValueChanged<DateTime?>? onChanged,
    ValueTransformer<DateTime?>? valueTransformer,
    VoidCallback? onReset,
    //
    this.alwaysUse24HourFormat = false,
    this.firstDate,
    this.format,
    this.inputType = CupertinoDateTimePickerInputType.both,
    this.lastDate,
    this.locale,
    this.onCancel,
    this.onConfirm,
    this.theme,

    //TextField options
    this.autocorrect = false,
    this.autofocus = false,
    this.buildCounter,
    this.controller,
    this.cursorColor,
    this.cursorRadius,
    this.cursorWidth = 2.0,
    this.enableInteractiveSelection = false,
    this.expands = false,
    this.inputFormatters,
    this.keyboardAppearance,
    this.keyboardType = TextInputType.datetime,
    this.maxLength,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.maxLines,
    this.minLines,
    this.obscureText = false,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.showCursor = false,
    this.strutStyle = StrutStyle.disabled,
    this.style,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.transitionBuilder,
  }) : super(
          autovalidateMode: autovalidateMode,
          decoration: decoration,
          enabled: enabled,
          focusNode: focusNode,
          initialValue: initialValue,
          key: key,
          name: name,
          onChanged: onChanged,
          onReset: onReset,
          onSaved: onSaved,
          validator: validator,
          valueTransformer: valueTransformer,
          builder: (FormFieldState<DateTime?> field) {
            final state = field as _FormBuilderCupertinoDateTimePickerState;

            return TextField(
              autocorrect: autocorrect,
              autofocus: autofocus,
              buildCounter: buildCounter,
              controller: state._textFieldController,
              cursorColor: cursorColor,
              cursorRadius: cursorRadius,
              cursorWidth: cursorWidth,
              decoration: state.decoration,
              enabled: state.enabled,
              enableInteractiveSelection: enableInteractiveSelection,
              expands: expands,
              focusNode: state.effectiveFocusNode,
              inputFormatters: inputFormatters,
              keyboardAppearance: keyboardAppearance,
              keyboardType: keyboardType,
              maxLength: maxLength,
              maxLengthEnforcement: maxLengthEnforcement,
              maxLines: maxLines,
              minLines: minLines,
              obscureText: obscureText,
              onEditingComplete: onEditingComplete,
              readOnly: true,
              scrollPadding: scrollPadding,
              showCursor: showCursor,
              strutStyle: strutStyle,
              style: style,
              textAlign: textAlign,
              textCapitalization: textCapitalization,
              textDirection: textDirection,
              textInputAction: textInputAction,
            );
          },
        );

  @override
  _FormBuilderCupertinoDateTimePickerState createState() =>
      _FormBuilderCupertinoDateTimePickerState();
}

class _FormBuilderCupertinoDateTimePickerState extends FormBuilderFieldState<
    FormBuilderCupertinoDateTimePicker, DateTime> {
  late TextEditingController _textFieldController;

  late DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _textFieldController = widget.controller ?? TextEditingController();
    _dateFormat = widget.format ?? _getDefaultDateTimeFormat();
    final _initialValue = initialValue;
    _textFieldController.text =
        _initialValue == null ? '' : _dateFormat.format(_initialValue);
    effectiveFocusNode.addListener(_handleFocus);
  }

  @override
  void dispose() {
    // Dispose the _textFieldController when initState created it
    if (null == widget.controller) {
      _textFieldController.dispose();
    }
    super.dispose();
  }

  Future<void> _handleFocus() async {
    if (effectiveFocusNode.hasFocus && enabled) {
      effectiveFocusNode.unfocus();
      await onShowPicker(context, value);
    }
  }

  DateFormat _getDefaultDateTimeFormat() {
    final languageCode = widget.locale?.languageCode;
    switch (widget.inputType) {
      case CupertinoDateTimePickerInputType.time:
        return DateFormat.Hm(languageCode);
      case CupertinoDateTimePickerInputType.date:
        return DateFormat.yMd(languageCode);
      case CupertinoDateTimePickerInputType.both:
      default:
        return DateFormat.yMd(languageCode).add_Hms();
    }
  }

  Future<DateTime?> onShowPicker(
      BuildContext context, DateTime? currentValue) async {
    currentValue = value;
    DateTime? newValue;
    switch (widget.inputType) {
      case CupertinoDateTimePickerInputType.date:
        newValue = await _showDatePicker(context, currentValue);
        break;
      case CupertinoDateTimePickerInputType.time:
        final newTime = await _showTimePicker(context, currentValue);
        newValue = null != newTime ? convert(newTime) : null;
        break;
      case CupertinoDateTimePickerInputType.both:
        final date = await _showDatePicker(context, currentValue);
        if (date != null) {
          final time = await _showTimePicker(context, currentValue);
          newValue = combine(date, time);
        }
        break;
      default:
        throw 'Unexpected input type ${widget.inputType}';
    }
    final finalValue = newValue ?? currentValue;
    didChange(finalValue);
    return finalValue;
  }

  Future<DateTime?> _showDatePicker(
      BuildContext context, DateTime? currentValue) {
    return DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: widget.firstDate ?? DateTime(1900),
      maxTime: widget.lastDate ?? DateTime(2100),
      currentTime: currentValue,
      locale: _localeType(),
      theme: widget.theme,
      onCancel: widget.onCancel,
      onConfirm: widget.onConfirm,
    );
  }

  Future<TimeOfDay?> _showTimePicker(
      BuildContext context, DateTime? currentValue) async {
    final timePicker = widget.alwaysUse24HourFormat
        ? DatePicker.showTimePicker(
            context,
            showTitleActions: true,
            currentTime: currentValue,
            showSecondsColumn: false,
            locale: _localeType(),
          )
        : DatePicker.showTime12hPicker(
            context,
            showTitleActions: true,
            currentTime: currentValue,
            locale: _localeType(),
          );
    final timePickerResult = await timePicker;
    final newDateTime = timePickerResult ?? currentValue;
    return null != newDateTime ? TimeOfDay.fromDateTime(newDateTime) : null;
  }

  /// Sets the hour and minute of a [DateTime] from a [TimeOfDay].
  DateTime combine(DateTime date, TimeOfDay? time) => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  DateTime? convert(TimeOfDay? time) =>
      time == null ? null : DateTime(1, 1, 1, time.hour, time.minute);

  @override
  void didChange(DateTime? val) {
    super.didChange(val);
    _textFieldController.text = (val == null) ? '' : _dateFormat.format(val);
  }

  LocaleType _localeType() {
    final shortLocaleCode = widget.locale?.languageCode ??
        Intl.shortLocale(Intl.getCurrentLocale());
    return LocaleType.values.firstWhere(
      (_) => shortLocaleCode == describeEnum(_),
      orElse: () => LocaleType.en,
    );
  }
}
