import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

enum InputType { date, time, both }

/// Field for `Date`, `Time` and `DateTime` input
class FormBuilderDateTimePicker extends FormBuilderFieldDecoration<DateTime> {
  /// The date/time picker dialogs to show.
  final InputType inputType;

  /// Allow manual editing of the date/time. Defaults to true. If false, the
  /// picker(s) will be shown every time the field gains focus.
  // final bool editable;

  /// For representing the date as a string e.g.
  /// `DateFormat("EEEE, MMMM d, yyyy 'at' h:mma")`
  /// (Sunday, June 3, 2018 at 9:24pm)
  final DateFormat? format;

  /// The date the calendar opens to when displayed. Defaults to null.
  ///
  /// To preset the widget's value, use [initialValue] instead.
  final DateTime? initialDate;

  /// The earliest choosable date. Defaults to 1900.
  final DateTime? firstDate;

  /// The latest choosable date. Defaults to 2100.
  final DateTime? lastDate;

  final DateTime? currentDate;

  /// The initial time prefilled in the picker dialog when it is shown. Defaults
  /// to noon. Explicitly set this to `null` to use the current time.
  final TimeOfDay initialTime;

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
  final Locale? locale;

  /// Corresponds to the [showDatePicker()] parameter.
  final ui.TextDirection? textDirection;

  /// Corresponds to the [showDatePicker()] parameter.
  final bool useRootNavigator;

  /// Called when an enclosing form is submitted. The value passed will be
  /// `null` if [format] fails to parse the text.
  final ValueChanged<DateTime?>? onFieldSubmitted;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;

  /// Preset the widget's value.
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
  final MouseCursor? mouseCursor;

  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;

  final double cursorWidth;
  final TextCapitalization textCapitalization;

  final String? cancelText;
  final String? confirmText;
  final String? errorFormatText;
  final String? errorInvalidText;
  final String? fieldHintText;
  final String? fieldLabelText;
  final String? helpText;
  final DatePickerEntryMode initialEntryMode;
  final RouteSettings? routeSettings;

  final TimePickerEntryMode timePickerInitialEntryMode;
  final StrutStyle? strutStyle;
  final SelectableDayPredicate? selectableDayPredicate;
  final Offset? anchorPoint;
  final EntryModeChangeCallback? onEntryModeChanged;
  final bool barrierDismissible;

  /// If true, disables the picker so it's not shown when the field is tapped.
  final bool disablePicker;

  /// Creates field for `Date`, `Time` and `DateTime` input
  FormBuilderDateTimePicker({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.decoration,
    super.onChanged,
    super.valueTransformer,
    super.enabled,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.onReset,
    super.focusNode,
    super.restorationId,
    super.errorBuilder,
    this.inputType = InputType.both,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.cursorWidth = 2.0,
    this.enableInteractiveSelection = true,
    this.initialTime = const TimeOfDay(hour: 12, minute: 0),
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.expands = false,
    this.initialDatePickerMode = DatePickerMode.day,
    this.transitionBuilder,
    this.textCapitalization = TextCapitalization.none,
    this.useRootNavigator = true,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.timePickerInitialEntryMode = TimePickerEntryMode.dial,
    this.format,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.currentDate,
    this.locale,
    this.maxLength,
    this.textDirection,
    this.textAlignVertical,
    this.onFieldSubmitted,
    this.controller,
    this.style,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.inputFormatters,
    this.showCursor = false,
    this.minLines,
    this.textInputAction,
    this.onEditingComplete,
    this.buildCounter,
    this.mouseCursor,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.cancelText,
    this.confirmText,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldHintText,
    this.fieldLabelText,
    this.helpText,
    this.routeSettings,
    this.strutStyle,
    this.selectableDayPredicate,
    this.anchorPoint,
    this.onEntryModeChanged,
    this.disablePicker = false,
    this.barrierDismissible = true,
  }) : super(
         builder: (FormFieldState<DateTime?> field) {
           final state = field as _FormBuilderDateTimePickerState;

           return FocusTraversalGroup(
             policy: ReadingOrderTraversalPolicy(),
             child: TextField(
               onTap: disablePicker ? null : () => state.showPicker(),
               textDirection: textDirection,
               textAlign: textAlign,
               textAlignVertical: textAlignVertical,
               maxLength: maxLength,
               autofocus: autofocus,
               decoration: state.decoration,
               readOnly: true,
               enabled: state.enabled,
               autocorrect: autocorrect,
               controller: state._textFieldController,
               focusNode: state.effectiveFocusNode,
               inputFormatters: inputFormatters,
               keyboardType: keyboardType,
               maxLines: maxLines,
               obscureText: obscureText,
               showCursor: showCursor,
               minLines: minLines,
               expands: expands,
               style: style,
               onEditingComplete: onEditingComplete,
               buildCounter: buildCounter,
               mouseCursor: mouseCursor,
               cursorColor: cursorColor,
               cursorRadius: cursorRadius,
               cursorWidth: cursorWidth,
               enableInteractiveSelection: enableInteractiveSelection,
               keyboardAppearance: keyboardAppearance,
               scrollPadding: scrollPadding,
               strutStyle: strutStyle,
               textCapitalization: textCapitalization,
               textInputAction: textInputAction,
               maxLengthEnforcement: maxLengthEnforcement,
             ),
           );
         },
       );

  @override
  FormBuilderFieldDecorationState<FormBuilderDateTimePicker, DateTime>
  createState() => _FormBuilderDateTimePickerState();
}

class _FormBuilderDateTimePickerState
    extends
        FormBuilderFieldDecorationState<FormBuilderDateTimePicker, DateTime> {
  late TextEditingController _textFieldController;

  late DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _textFieldController = widget.controller ?? TextEditingController();
    _dateFormat = widget.format ?? _getDefaultDateTimeFormat();
    //setting this to value instead of initialValue here is OK since we handle initial value in the parent class
    final initVal = value;
    _textFieldController.text = initVal == null
        ? ''
        : _dateFormat.format(initVal);

    effectiveFocusNode.onKeyEvent = (node, event) {
      if (event is KeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.space &&
          node.hasFocus &&
          !widget.disablePicker) {
        showPicker();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    };
  }

  @override
  void dispose() {
    // Dispose the _textFieldController when initState created it
    if (null == widget.controller) {
      _textFieldController.dispose();
    }
    super.dispose();
  }

  DateFormat _getDefaultDateTimeFormat() {
    final languageCode = widget.locale?.languageCode;
    return switch (widget.inputType) {
      InputType.time => DateFormat.Hm(languageCode),
      InputType.date => DateFormat.yMd(languageCode),
      InputType.both => DateFormat.yMd(languageCode).add_Hms(),
    };
  }

  Future<void> showPicker() async {
    await onShowPicker(value);
  }

  Future<DateTime?> onShowPicker(DateTime? currentValue) async {
    currentValue = value;
    DateTime? newValue;
    switch (widget.inputType) {
      case InputType.date:
        newValue = await _showDatePicker(currentValue);
        break;
      case InputType.time:
        if (!context.mounted) break;
        newValue = convert(await _showTimePicker(currentValue));
        break;
      case InputType.both:
        if (!context.mounted) break;
        final date = await _showDatePicker(currentValue);
        if (date != null) {
          if (!mounted) break;
          final time = await _showTimePicker(currentValue);
          if (time == null) {
            newValue = null;
          } else {
            newValue = combine(date, time);
          }
        }
        break;
    }
    if (!mounted) return null;
    final finalValue = newValue ?? currentValue;
    didChange(finalValue);
    return finalValue;
  }

  Future<DateTime?> _showDatePicker(DateTime? currentValue) {
    return showDatePicker(
      context: context,
      selectableDayPredicate: widget.selectableDayPredicate,
      initialDatePickerMode: widget.initialDatePickerMode,
      initialDate: currentValue ?? widget.initialDate,
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      locale: widget.locale,
      textDirection: widget.textDirection,
      useRootNavigator: widget.useRootNavigator,
      builder: widget.transitionBuilder,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      errorFormatText: widget.errorFormatText,
      errorInvalidText: widget.errorInvalidText,
      fieldHintText: widget.fieldHintText,
      fieldLabelText: widget.fieldLabelText,
      helpText: widget.helpText,
      initialEntryMode: widget.initialEntryMode,
      routeSettings: widget.routeSettings,
      currentDate: widget.currentDate,
      anchorPoint: widget.anchorPoint,
      keyboardType: widget.keyboardType,
      barrierDismissible: widget.barrierDismissible,
    );
  }

  Future<TimeOfDay?> _showTimePicker(DateTime? currentValue) async {
    var builder = widget.transitionBuilder;
    if (widget.locale != null) {
      builder = (context, child) {
        var transitionBuilder = widget.transitionBuilder;
        return Localizations.override(
          context: context,
          locale: widget.locale,
          child: transitionBuilder == null
              ? child
              : transitionBuilder(context, child),
        );
      };
    }

    return await showTimePicker(
      context: context,
      initialTime: currentValue != null
          ? TimeOfDay.fromDateTime(currentValue)
          : widget.initialTime,
      builder: builder,
      useRootNavigator: widget.useRootNavigator,
      routeSettings: widget.routeSettings,
      initialEntryMode: widget.timePickerInitialEntryMode,
      helpText: widget.helpText,
      confirmText: widget.confirmText,
      cancelText: widget.cancelText,
      anchorPoint: widget.anchorPoint,
      errorInvalidText: widget.errorInvalidText,
      onEntryModeChanged: widget.onEntryModeChanged,
      barrierDismissible: widget.barrierDismissible,
    );
  }

  /// Sets the hour and minute of a [DateTime] from a [TimeOfDay].
  DateTime combine(DateTime date, TimeOfDay? time) => DateTime(
    date.year,
    date.month,
    date.day,
    time?.hour ?? 0,
    time?.minute ?? 0,
  );

  DateTime? convert(TimeOfDay? time) =>
      time == null ? null : DateTime(1, 1, 1, time.hour, time.minute);

  @override
  void didChange(DateTime? value) {
    super.didChange(value);
    _textFieldController.text = (value == null)
        ? ''
        : _dateFormat.format(value);
  }
}
