import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:signature/signature.dart';

import './form_builder_input_option.dart';

//TODO: Consider adding RangeSlider - https://pub.dartlang.org/packages/flutter_range_slider
//TODO: Consider adding ColorPicker - https://pub.dartlang.org/packages/flutter_colorpicker
//TODO: Consider adding masked_text - https://pub.dartlang.org/packages/code_input#-readme-tab- (Not Important)
//TODO: Consider adding code_input - https://pub.dartlang.org/packages/flutter_masked_text#-changelog-tab- (Not Important)
//TODO: Add autovalidate attribute type
class FormBuilderInput {
  static const String TYPE_TEXT = "Text";
  static const String TYPE_NUMBER = "Number";
  static const String TYPE_EMAIL = "Email";
  static const String TYPE_MULTILINE_TEXT = "MultilineText";
  static const String TYPE_PASSWORD = "Password";
  static const String TYPE_RADIO = "Radio";
  static const String TYPE_CHECKBOX_LIST = "CheckboxList";
  static const String TYPE_CHECKBOX = "Checkbox";
  static const String TYPE_SWITCH = "Switch";
  static const String TYPE_SLIDER = "Slider";
  static const String TYPE_DROPDOWN = "Dropdown";
  static const String TYPE_DATE_PICKER = "DatePicker";
  static const String TYPE_TIME_PICKER = "TimePicker";
  static const String TYPE_DATE_TIME_PICKER = "DateTimePicker";
  static const String TYPE_URL = "Url";
  static const String TYPE_TYPE_AHEAD = "TypeAhead";
  static const String TYPE_PHONE = "Phone";
  static const String TYPE_STEPPER = "Stepper";
  static const String TYPE_RATE = "Rate";
  static const String TYPE_SEGMENTED_CONTROL = "SegmentedControl";
  static const String TYPE_CHIPS_INPUT = "ChipsInput";
  static const String TYPE_SIGNATURE_PAD = "DrawingPad";

  Widget label;
  String attribute;
  String type;
  bool readonly;
  String helperText;
  InputDecoration decoration;
  dynamic value;
  bool require;
  dynamic min;
  dynamic max;
  int divisions;
  Color penColor;
  Color backgroundColor;
  double penStrokeWidth;
  double height;
  double width;
  List<Point> points;
  num step;
  String format;
  IconData icon;
  double iconSize;
  DateTime firstDate; //TODO: Use min?
  DateTime lastDate; //TODO: Use max?
  FormFieldValidator<dynamic> validator;
  List<FormBuilderInputOption> options;
  SuggestionsCallback suggestionsCallback;
  ItemBuilder itemBuilder;
  ChipsBuilder suggestionBuilder;
  ChipsBuilder chipBuilder;
  int maxLines;
  bool autovalidate;
  ValueChanged<dynamic> onChanged;

  //Inputs for typeahead
  bool getImmediateSuggestions;
  ErrorBuilder errorBuilder;
  WidgetBuilder noItemsFoundBuilder;
  WidgetBuilder loadingBuilder;
  Duration debounceDuration;
  SuggestionsBoxDecoration suggestionsBoxDecoration;
  double suggestionsBoxVerticalOffset;
  AnimationTransitionBuilder transitionBuilder;
  Duration animationDuration;
  double animationStart;
  AxisDirection direction;
  bool hideOnLoading;
  bool hideOnEmpty;
  bool hideOnError;
  bool hideSuggestionsOnKeyboardHide;
  bool keepSuggestionsOnLoading;

  FormBuilderInput.textField({
    @required this.decoration,
    @required this.type,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
    this.min,
    this.max,
    this.maxLines = 5,
    this.autovalidate = false,
    this.onChanged,
  })  : assert(min == null || min is int),
        assert(max == null || max is int);

  FormBuilderInput.password({
    @required this.decoration,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
    this.min,
    this.max,
  })  : assert(min == null || min is int),
        assert(max == null || max is int) {
    type = FormBuilderInput.TYPE_PASSWORD;
  }

  FormBuilderInput.typeAhead({
    @required this.decoration,
    this.label,
    @required this.attribute,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
    this.getImmediateSuggestions = false,
    this.errorBuilder,
    this.noItemsFoundBuilder,
    this.loadingBuilder,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.suggestionsBoxDecoration = const SuggestionsBoxDecoration(),
    this.suggestionsBoxVerticalOffset = 5.0,
    this.transitionBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationStart = 0.25,
    this.direction = AxisDirection.down,
    this.hideOnLoading = false,
    this.hideOnEmpty = false,
    this.hideOnError = false,
    this.hideSuggestionsOnKeyboardHide = true,
    this.keepSuggestionsOnLoading = true,
  }) {
    type = FormBuilderInput.TYPE_TYPE_AHEAD;
  }

  FormBuilderInput.signaturePad({
    @required this.decoration,
    @required this.attribute,
    this.readonly = false,
    this.penColor = Colors.black,
    this.penStrokeWidth = 3,
    this.width,
    this.points,
    this.height = 250,
    this.backgroundColor = Colors.white70,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_SIGNATURE_PAD;
  }

  FormBuilderInput.number({
    @required this.decoration,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.min,
    this.max,
    this.require = false,
    this.validator,
  })  : assert(min == null || min is num),
        assert(max == null || max is num),
        assert(min == null || max == null || min <= max,
            "Min cannot be higher than Max") {
    type = FormBuilderInput.TYPE_NUMBER;
  }

  FormBuilderInput.stepper({
    @required this.decoration,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.min,
    this.max,
    this.step,
    this.require = false,
    this.validator,
  })  : assert(min == null || min is num),
        assert(max == null || max is num),
        assert(min == null || max == null || min <= max,
            "Min cannot be higher than Max") {
    type = FormBuilderInput.TYPE_STEPPER;
  }

  FormBuilderInput.rate({
    @required this.decoration,
    @required this.attribute,
    @required this.max,
    this.readonly = false,
    this.value,
    this.icon,
    this.iconSize,
    this.require = false,
    this.validator,
  })  : assert(max == null || max is num),
        assert(max > value || value == null,
            "Initial value cannot be higher than Max") {
    type = FormBuilderInput.TYPE_RATE;
  }

  FormBuilderInput.slider({
    @required this.decoration,
    @required this.attribute,
    @required this.min,
    @required this.max,
    @required this.value,
    this.readonly = false,
    this.divisions,
    this.require = false,
    this.validator,
  })  : assert(min == null || min is num),
        assert(max == null || max is num) {
    type = FormBuilderInput.TYPE_SLIDER;
  }

  FormBuilderInput.dropdown({
    @required this.decoration,
    @required this.options,
    @required this.attribute,
    this.helperText,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_DROPDOWN;
  }

  FormBuilderInput.radio({
    @required this.decoration,
    @required this.attribute,
    @required this.options,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_RADIO;
  }

  FormBuilderInput.segmentedControl({
    @required this.decoration,
    @required this.attribute,
    @required this.options,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_SEGMENTED_CONTROL;
  }

  FormBuilderInput.checkbox({
    this.decoration = const InputDecoration(),
    @required this.label,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is bool,
            "Initial value for a checkbox should be boolean") {
    type = FormBuilderInput.TYPE_CHECKBOX;
  }

  FormBuilderInput.switchInput({
    this.decoration = const InputDecoration(),
    @required this.label,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is bool,
            "Initial value for a switch should be boolean") {
    type = FormBuilderInput.TYPE_SWITCH;
  }

  FormBuilderInput.checkboxList({
    @required this.decoration,
    @required this.options,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is List) {
    value == value ?? []; // ignore: unnecessary_statements
    type = FormBuilderInput.TYPE_CHECKBOX_LIST;
  }

  FormBuilderInput.datePicker({
    @required this.decoration,
    @required this.attribute,
    this.readonly = false,
    // @Deprecated('Use attribute: min')
    this.firstDate,
    // this.min,
    // @Deprecated('Use attribute: max')
    this.lastDate,
    this.max,
    this.format,
    this.value,
    this.require = false,
    this.validator,
  }) /*: assert(min == null || min is DateTime),
        assert(max == null || max is DateTime),
        assert(min == null || firstDate == null),
        assert(max == null || lastDate == null)*/
  {
    type = FormBuilderInput.TYPE_DATE_PICKER;
  }

  FormBuilderInput.dateTimePicker({
    @required this.decoration,
    @required this.attribute,
    this.readonly = false,
    // @Deprecated('Use attribute: min')
    this.firstDate,
    // this.min,
    // @Deprecated('Use attribute: max')
    this.lastDate,
    // this.max,
    this.format,
    this.value,
    this.require = false,
    this.validator,
  }) /*: assert(min == null || min is DateTime),
        assert(max == null || max is DateTime),
        assert(min == null || firstDate == null),
        assert(max == null || lastDate == null) */
  {
    type = FormBuilderInput.TYPE_DATE_TIME_PICKER;
  }

  FormBuilderInput.timePicker({
    @required this.decoration,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_TIME_PICKER;
  }

  FormBuilderInput.chipsInput({
    @required this.decoration,
    @required this.attribute,
    @required this.suggestionsCallback,
    @required this.suggestionBuilder,
    @required this.chipBuilder,
    this.readonly = false,
    this.value,
    this.require = false,
    this.max,
    this.validator,
  })  : assert(value == null || value is List),
        assert(max == null || max is int) {
    type = FormBuilderInput.TYPE_CHIPS_INPUT;
  }
}
