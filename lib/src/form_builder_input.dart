import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import './form_builder_input_option.dart';

class FormBuilderInput {
  static const String TYPE_TEXT = "Text";
  static const String TYPE_PASSWORD = "Password";
  static const String TYPE_NUMBER = "Number";
  static const String TYPE_EMAIL = "Text";
  static const String TYPE_MULTILINE_TEXT = "MultilineText";
  static const String TYPE_RADIO = "Radio";
  static const String TYPE_CHECKBOX_LIST = "CheckboxList";
  static const String TYPE_CHECKBOX = "Checkbox";
  static const String TYPE_SWITCH = "Switch";
  static const String TYPE_SLIDER = "Slider";
  static const String TYPE_DROPDOWN = "Dropdown";
  static const String TYPE_DATE_PICKER = "DatePicker";
  static const String TYPE_TIME_PICKER = "TimePicker";
  static const String TYPE_URL = "Url";
  static const String TYPE_TYPE_AHEAD = "TypeAhead";

  String label;
  String attribute;
  String type;
  String placeholder;
  dynamic value;
  bool require;
  dynamic min;
  dynamic max;
  DateTime firstDate;
  DateTime lastDate;
  FormFieldValidator<String> validator;
  List<FormBuilderInputOption> options;
  SuggestionsCallback suggestionsCallback;
  ItemBuilder itemBuilder;

  FormBuilderInput({
    @required this.label,
    @required this.type,
    @required this.attribute,
    this.placeholder,
    this.options,
    this.value,
    this.require = false,
    this.validator,
    this.min,
    this.max,
    this.firstDate,
    this.lastDate,
    this.suggestionsCallback,
    this.itemBuilder,
  });

  FormBuilderInput.typeAhead({
    @required this.label,
    @required this.attribute,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
    this.placeholder,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_TYPE_AHEAD;
  }

  FormBuilderInput.dropdown({
    @required this.label,
    @required this.options,
    @required this.attribute,
    this.placeholder,
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
    this.placeholder,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_RADIO;
  }

  FormBuilderInput.slider({
    @required this.label,
    @required this.attribute,
    @required this.min,
    @required this.max,
    this.placeholder,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_SLIDER;
  }

  FormBuilderInput.checkboxList({
    @required this.label,
    @required this.options,
    @required this.attribute,
    this.placeholder,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_CHECKBOX_LIST;
  }

  FormBuilderInput.datePicker({
    @required this.label,
    @required this.attribute,
    this.placeholder,
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
    this.placeholder,
    this.firstDate,
    this.lastDate,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_TIME_PICKER;
  }
}