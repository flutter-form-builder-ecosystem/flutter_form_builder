import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import './form_builder_input_option.dart';
import './chips_input.dart';

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
  static const String TYPE_URL = "Url";
  static const String TYPE_TYPE_AHEAD = "TypeAhead"; //TODO: Needs some work
  static const String TYPE_PHONE = "Phone";
  static const String TYPE_STEPPER = "Stepper";
  static const String TYPE_RATE = "Rate";
  static const String TYPE_SEGMENTED_CONTROL = "SegmentedControl";
  static const String TYPE_CHIPS_INPUT = "ChipsInput";

  String label;
  String attribute;
  String type;
  String hint;
  dynamic value;
  bool require;
  num min;
  int divisions;
  num max;
  num step;
  IconData icon;
  double iconSize;
  DateTime firstDate;
  DateTime lastDate;
  FormFieldValidator<dynamic> validator;
  List<FormBuilderInputOption> options;
  SuggestionsCallback suggestionsCallback;
  ItemBuilder itemBuilder;
  ChipsBuilder suggestionBuilder;
  ChipsBuilder chipBuilder;

  FormBuilderInput.textField({
    @required this.label,
    @required this.type,
    @required this.attribute,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
    this.min,
    this.max,
    //TODO: Include maxLines for multiline text
  });

  FormBuilderInput.password({
    @required this.label,
    @required this.attribute,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
    this.min,
    this.max,
  }) {
    type = FormBuilderInput.TYPE_PASSWORD;
  }

  FormBuilderInput.typeAhead({
    @required this.label,
    @required this.attribute,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_TYPE_AHEAD;
  }

  FormBuilderInput.number({
    @required this.label,
    @required this.attribute,
    this.value,
    this.hint,
    this.min,
    this.max,
    this.require = false,
    this.validator,
  }) : assert(min == null || max == null || min <= max,
            "Min cannot be higher than Max") {
    type = FormBuilderInput.TYPE_NUMBER;
  }

  FormBuilderInput.stepper({
    @required this.label,
    @required this.attribute,
    this.value,
    this.hint,
    this.min,
    this.max,
    this.step,
    this.require = false,
    this.validator,
  }) : assert(min == null || max == null || min <= max,
            "Min cannot be higher than Max") {
    type = FormBuilderInput.TYPE_STEPPER;
  }

  FormBuilderInput.rate({
    @required this.label,
    @required this.attribute,
    @required this.max,
    this.value,
    this.icon,
    this.iconSize,
    this.hint,
    this.require = false,
    this.validator,
  }) : assert(max > value || value == null,
            "Initial value cannot be higher than Max") {
    type = FormBuilderInput.TYPE_RATE;
  }

  FormBuilderInput.slider({
    @required this.label,
    @required this.attribute,
    @required this.min,
    @required this.max,
    @required this.value,
    this.divisions,
    this.hint,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_SLIDER;
  }

  FormBuilderInput.dropdown({
    @required this.label,
    @required this.options,
    @required this.attribute,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_DROPDOWN;
  }

  FormBuilderInput.radio({
    @required this.label,
    @required this.attribute,
    @required this.options,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_RADIO;
  }

  FormBuilderInput.segmentedControl({
    @required this.label,
    @required this.attribute,
    @required this.options,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_SEGMENTED_CONTROL;
  }

  FormBuilderInput.checkbox({
    @required this.label,
    @required this.attribute,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is bool,
            "Initial value for a checkbox should be boolean") {
    type = FormBuilderInput.TYPE_CHECKBOX;
  }

  FormBuilderInput.switchInput({
    @required this.label,
    @required this.attribute,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is bool,
            "Initial value for a switch should be boolean") {
    type = FormBuilderInput.TYPE_SWITCH;
  }

  FormBuilderInput.checkboxList({
    @required this.label,
    @required this.options,
    @required this.attribute,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is List) {
    value == value ?? []; // ignore: unnecessary_statements
    type = FormBuilderInput.TYPE_CHECKBOX_LIST;
  }

  FormBuilderInput.datePicker({
    @required this.label,
    @required this.attribute,
    this.hint,
    this.firstDate,
    this.lastDate,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_DATE_PICKER;
  }

  FormBuilderInput.timePicker({
    @required this.label,
    @required this.attribute,
    this.hint,
    this.firstDate,
    this.lastDate,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_TIME_PICKER;
  }

  FormBuilderInput.chipsInput({
    @required this.label,
    @required this.attribute,
    @required this.suggestionsCallback,
    @required this.suggestionBuilder,
    @required this.chipBuilder,
    this.hint,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_CHIPS_INPUT;
  }

  hasHint() {
    return hint != null;
  }
}
