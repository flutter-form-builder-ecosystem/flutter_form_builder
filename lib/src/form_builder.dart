import 'dart:typed_data';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_form_builder/src/form_builder_input.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

import './form_builder_input.dart';

//TODO: Refactor this spaghetti code
class FormBuilder extends StatefulWidget {
  final BuildContext context;
  final Function(Map<String, dynamic>) onChanged;
  final WillPopCallback onWillPop;
  final List<FormBuilderInput> controls;
  final bool readonly;
  final bool autovalidate;
  final Key key;

  const FormBuilder(
    this.context, {
    @required this.controls,
    this.readonly = false,
    this.key,
    this.onChanged,
    this.autovalidate = false,
    this.onWillPop,
  }) : super(key: key);

  // assert(duplicateAttributes(controls).length == 0, "Duplicate attribute names not allowed");

  //FIXME: Find way to assert no duplicates in control attributes
  /*Function duplicateAttributes = (List<FormBuilderInput> controls) {
    List<String> attributeList = [];
    controls.forEach((c) {
      attributeList.add(c.attribute);
    });
    List<String> uniqueAttributes = Set.from(attributeList).toList(growable: false);
    //attributeList.
  };*/

  @override
  FormBuilderState createState() => FormBuilderState(controls);
}

class FormBuilderState extends State<FormBuilder> {
  final List<FormBuilderInput> formControls;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> value = {};
  Map<String, GlobalKey<FormFieldState>> _fieldKeys = {};
  final _dateTimeFormats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  FormBuilderState(this.formControls);

  save() {
    _formKey.currentState.save();
  }

  GlobalKey<FormFieldState> findFieldByAttribute(String attribute) {
    return _fieldKeys[attribute];
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  reset() {
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      //TODO: Allow user to update field value or validate based on changes in others (e.g. Summations, Confirm Password)
      onChanged: () {
        if (widget.onChanged != null) {
          _formKey.currentState.save();
          widget.onChanged(value);
        }
      },
      onWillPop: widget.onWillPop,
      autovalidate: widget.autovalidate,
        child: Column(
          children: this.formControls.map((FormBuilderInput formControl) {
            GlobalKey<FormFieldState> _fieldKey =
                GlobalKey(debugLabel: formControl.attribute);
            _fieldKeys[formControl.attribute] = _fieldKey;
            switch (formControl.type) {
              case FormBuilderInput.TYPE_TEXT:
              case FormBuilderInput.TYPE_PASSWORD:
              case FormBuilderInput.TYPE_NUMBER:
              case FormBuilderInput.TYPE_PHONE:
              case FormBuilderInput.TYPE_EMAIL:
              case FormBuilderInput.TYPE_URL:
              case FormBuilderInput.TYPE_MULTILINE_TEXT:
                TextInputType keyboardType;
                switch (formControl.type) {
                  case FormBuilderInput.TYPE_NUMBER:
                    keyboardType = TextInputType.number;
                    break;
                  case FormBuilderInput.TYPE_EMAIL:
                    keyboardType = TextInputType.emailAddress;
                    break;
                  case FormBuilderInput.TYPE_URL:
                    keyboardType = TextInputType.url;
                    break;
                  case FormBuilderInput.TYPE_PHONE:
                    keyboardType = TextInputType.phone;
                    break;
                  case FormBuilderInput.TYPE_MULTILINE_TEXT:
                    keyboardType = TextInputType.multiline;
                    break;
                  default:
                    keyboardType = TextInputType.text;
                    break;
                }
                return TextFormField(
                  key: _fieldKey,
                  enabled: !(widget.readonly || formControl.readonly),
                  style: (widget.readonly || formControl.readonly)
                      ? Theme.of(context).textTheme.subhead.copyWith(
                            color: Theme.of(context).disabledColor,
                          )
                      : null,
                  focusNode: (widget.readonly || formControl.readonly)
                      ? AlwaysDisabledFocusNode()
                      : null,
                  decoration: formControl.decoration.copyWith(
                    enabled: !(widget.readonly || formControl.readonly),
                  ),
                  autovalidate: formControl.autovalidate ?? false,
                  initialValue:
                      formControl.value != null ? "${formControl.value}" : '',
                  maxLines:
                      formControl.type == FormBuilderInput.TYPE_MULTILINE_TEXT
                          ? formControl.maxLines
                          : 1,
                  keyboardType: keyboardType,
                  obscureText:
                      formControl.type == FormBuilderInput.TYPE_PASSWORD
                          ? true
                          : false,
                  onSaved: (val) {
                    value[formControl.attribute] =
                        formControl.type == FormBuilderInput.TYPE_NUMBER
                            ? num.tryParse(val)
                            : val;
                  },
                  onFieldSubmitted: (data) {
                    if (formControl.onChanged != null)
                      formControl.onChanged(data);
                  },
                  validator: (val) {
                    if (formControl.require && val.isEmpty)
                      return "${formControl.attribute} is required";

                    if (formControl.type == FormBuilderInput.TYPE_NUMBER) {
                      if (num.tryParse(val) == null && val.isNotEmpty)
                        return "$val is not a valid number";
                      if (formControl.max != null &&
                          num.tryParse(val) > formControl.max)
                        return "${formControl.attribute} should not be greater than ${formControl.max}";
                      if (formControl.min != null &&
                          num.tryParse(val) < formControl.min)
                        return "${formControl.attribute} should not be less than ${formControl.min}";
                    } else {
                      if (formControl.max != null &&
                          val.length > formControl.max)
                        return "${formControl.attribute} should have ${formControl.max} character(s) or less";
                      if (formControl.min != null &&
                          val.length < formControl.min)
                        return "${formControl.attribute} should have ${formControl.min} character(s) or more";
                    }

                    if (formControl.type == FormBuilderInput.TYPE_EMAIL &&
                        val.isNotEmpty) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      if (!RegExp(pattern).hasMatch(val))
                        return '$val is not a valid email address';
                    }

                    if (formControl.type == FormBuilderInput.TYPE_URL &&
                        val.isNotEmpty) {
                      Pattern pattern =
                          r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                      if (!RegExp(pattern, caseSensitive: false).hasMatch(val))
                        return '$val is not a valid URL';
                    }

                    if (formControl.validator != null)
                      return formControl.validator(val);
                  },
                  // autovalidate: ,
                );
                break;

              case FormBuilderInput.TYPE_DATE_TIME_PICKER:
                return DateTimePickerFormField(
                  inputType: InputType.both,
                  initialValue: formControl.value,
                  format: formControl.format != null
                      ? DateFormat(formControl.format)
                      : _dateTimeFormats[InputType.both],
                  enabled: !(formControl.readonly || widget.readonly),
                  firstDate: formControl.firstDate,
                  lastDate: formControl.lastDate,
                  decoration: formControl.decoration.copyWith(
                    enabled: !(widget.readonly || formControl.readonly),
                  ),
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  validator: (val) {
                    if (formControl.require && val == null)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(val);
                  },
                );
                break;

              case FormBuilderInput.TYPE_DATE_PICKER:
                return DateTimePickerFormField(
                  inputType: InputType.date,
                  initialValue: formControl.value,
                  format: formControl.format != null
                      ? DateFormat(formControl.format)
                      : _dateTimeFormats[InputType.date],
                  enabled: !(formControl.readonly || widget.readonly),
                  firstDate: formControl.firstDate,
                  lastDate: formControl.lastDate,
                  decoration: formControl.decoration.copyWith(
                    enabled: !(widget.readonly || formControl.readonly),
                  ),
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  validator: (val) {
                    if (formControl.require && val == null)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(val);
                  },
                );
                break;

              case FormBuilderInput.TYPE_TIME_PICKER:
                return DateTimePickerFormField(
                  inputType: InputType.time,
                  initialValue: formControl.value,
                  format: formControl.format != null
                      ? DateFormat(formControl.format)
                      : _dateTimeFormats[InputType.time],
                  enabled: !(formControl.readonly || widget.readonly),
                  decoration: formControl.decoration.copyWith(
                    enabled: !(widget.readonly || formControl.readonly),
                  ),
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  validator: (val) {
                    if (formControl.require && val == null)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(val);
                  },
                );
                break;

              case FormBuilderInput.TYPE_TYPE_AHEAD:
                TextEditingController _typeAheadController =
                    TextEditingController(text: formControl.value);
                return TypeAheadFormField(
                  key: _fieldKey,
                  textFieldConfiguration: TextFieldConfiguration(
                    enabled: !(widget.readonly || formControl.readonly),
                    controller: _typeAheadController,
                    style: (widget.readonly || formControl.readonly)
                        ? Theme.of(context).textTheme.subhead.copyWith(
                              color: Theme.of(context).disabledColor,
                            )
                        : null,
                    focusNode: (widget.readonly || formControl.readonly)
                        ? AlwaysDisabledFocusNode()
                        : null,
                    decoration: formControl.decoration.copyWith(
                      enabled: !(widget.readonly || formControl.readonly),
                    ),
                  ),
                  suggestionsCallback: formControl.suggestionsCallback,
                  itemBuilder: formControl.itemBuilder,
                  transitionBuilder: (context, suggestionsBox, controller) =>
                      suggestionsBox,
                  onSuggestionSelected: (suggestion) {
                    _typeAheadController.text = suggestion;
                  },
                  validator: (val) {
                    if (formControl.require && val.isEmpty)
                      return '${formControl.attribute} is required';

                    if (formControl.validator != null)
                      return formControl.validator(val);
                  },
                  onSaved: (val) => value[formControl.attribute] = val,
                  getImmediateSuggestions: formControl.getImmediateSuggestions,
                  errorBuilder: formControl.errorBuilder,
                  noItemsFoundBuilder: formControl.noItemsFoundBuilder,
                  loadingBuilder: formControl.loadingBuilder,
                  debounceDuration: formControl.debounceDuration,
                  suggestionsBoxDecoration:
                      formControl.suggestionsBoxDecoration,
                  suggestionsBoxVerticalOffset:
                      formControl.suggestionsBoxVerticalOffset,
                  // transitionBuilder: formControl.transitionBuilder,
                  animationDuration: formControl.animationDuration,
                  animationStart: formControl.animationStart,
                  direction: formControl.direction,
                  hideOnLoading: formControl.hideOnLoading,
                  hideOnEmpty: formControl.hideOnEmpty,
                  hideOnError: formControl.hideOnError,
                  hideSuggestionsOnKeyboardHide:
                      formControl.hideSuggestionsOnKeyboardHide,
                  keepSuggestionsOnLoading:
                      formControl.keepSuggestionsOnLoading,
                );
                break;

              case FormBuilderInput.TYPE_DROPDOWN:
                return FormField(
                  key: _fieldKey,
                  enabled: !(widget.readonly || formControl.readonly),
                  initialValue: formControl.value,
                  validator: (val) {
                    if (formControl.require && val == null)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(val);
                  },
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: formControl.decoration.copyWith(
                        enabled: !(widget.readonly || formControl.readonly),
                        errorText: field.errorText,
                        contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                        border: InputBorder.none,
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        // hint: Text(formControl.hint ?? ''), //TODO: Dropdown may require hint
                        items: formControl.options.map((option) {
                          return DropdownMenuItem(
                            child: Text("${option.label ?? option.value}"),
                            value: option.value,
                          );
                        }).toList(),
                        value: field.value,
                        onChanged: (widget.readonly || formControl.readonly)
                            ? null
                            : (value) {
                                field.didChange(value);
                              },
                      ),
                    );
                  },
                );
                break;

              //TODO: For TYPE_CHECKBOX, TYPE_CHECKBOX_LIST, TYPE_RADIO allow user to choose if checkbox/radio to appear before or after Label
              case FormBuilderInput.TYPE_RADIO:
                return FormField(
                  key: _fieldKey,
                  enabled: !widget.readonly && !formControl.readonly,
                  initialValue: formControl.value,
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  validator: (value) {
                    if (formControl.require && value == null)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(value);
                  },
                  builder: (FormFieldState<dynamic> field) {
                    List<Widget> radioList = [];
                    for (int i = 0; i < formControl.options.length; i++) {
                      radioList.addAll([
                        ListTile(
                          dense: true,
                          isThreeLine: false,
                          contentPadding: EdgeInsets.all(0.0),
                          leading: null,
                          title: Text(
                              "${formControl.options[i].label ?? formControl.options[i].value}"),
                          trailing: Radio<dynamic>(
                            value: formControl.options[i].value,
                            groupValue: field.value,
                            onChanged: (widget.readonly || formControl.readonly)
                                ? null
                                : (dynamic value) {
                                    field.didChange(value);
                                  },
                          ),
                          onTap: (widget.readonly || formControl.readonly)
                              ? null
                              : () {
                                  field.didChange(formControl.options[i].value);
                                },
                        ),
                        Divider(
                          height: 0.0,
                        ),
                      ]);
                    }
                    return InputDecorator(
                      decoration: formControl.decoration.copyWith(
                        enabled: !(widget.readonly || formControl.readonly),
                        errorText: field.errorText,
                        contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                        border: InputBorder.none,
                      ),
                      child: Column(
                        children: radioList,
                      ),
                    );
                  },
                );
                break;

              case FormBuilderInput.TYPE_SEGMENTED_CONTROL:
                return FormField(
                  key: _fieldKey,
                  initialValue: formControl.value,
                  enabled: !(widget.readonly || formControl.readonly),
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  validator: (value) {
                    if (formControl.require && value == null)
                      return "${formControl.require} is required";
                    if (formControl.validator != null)
                      return formControl.validator(value);
                  },
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: formControl.decoration.copyWith(
                        enabled: !(widget.readonly || formControl.readonly),
                        errorText: field.errorText,
                        contentPadding:
                            EdgeInsets.only(top: 10.0, bottom: 10.0),
                        border: InputBorder.none,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: CupertinoSegmentedControl(
                          borderColor: (widget.readonly || formControl.readonly)
                              ? Theme.of(context).disabledColor
                              : Theme.of(context).primaryColor,
                          selectedColor:
                              (widget.readonly || formControl.readonly)
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor,
                          pressedColor:
                              (widget.readonly || formControl.readonly)
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor,
                          groupValue: field.value,
                          children: Map.fromIterable(
                            formControl.options,
                            key: (v) => v.value,
                            value: (v) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text("${v.label ?? v.value}"),
                                ),
                          ),
                          onValueChanged: (dynamic value) {
                            if (widget.readonly || formControl.readonly) {
                              field.reset();
                            } else
                              field.didChange(value);
                          },
                        ),
                      ),
                    );
                  },
                );
                break;

              case FormBuilderInput.TYPE_SWITCH:
                return FormField(
                    key: _fieldKey,
                    enabled: !(widget.readonly || formControl.readonly),
                    initialValue: formControl.value ?? false,
                    validator: (value) {
                      if (formControl.require && value == null)
                        return "${formControl.attribute} is required";
                      /*if (formControl.validator != null)
                    return formControl.validator(value);*/
                    },
                    onSaved: (val) {
                      value[formControl.attribute] = val;
                    },
                    builder: (FormFieldState<dynamic> field) {
                      return InputDecorator(
                        decoration: formControl.decoration.copyWith(
                          enabled: !(widget.readonly || formControl.readonly),
                          errorText: field.errorText,
                        ),
                        child: ListTile(
                          dense: true,
                          isThreeLine: false,
                          contentPadding: EdgeInsets.all(0.0),
                          title: formControl.label,
                          trailing: Switch(
                            value: field.value,
                            onChanged: (widget.readonly || formControl.readonly)
                                ? null
                                : (bool value) {
                                    field.didChange(value);
                                  },
                          ),
                          onTap: (widget.readonly || formControl.readonly)
                              ? null
                              : () {
                                  bool newValue = !(field.value ?? false);
                                  field.didChange(newValue);
                                },
                        ),
                      );
                    });
                break;

              case FormBuilderInput.TYPE_STEPPER:
                return FormField(
                  enabled: !(widget.readonly || formControl.readonly),
                  key: _fieldKey,
                  initialValue: formControl.value,
                  validator: (value) {
                    if (formControl.require && value == null)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(value);
                  },
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: formControl.decoration.copyWith(
                        enabled: !(widget.readonly || formControl.readonly),
                        errorText: field.errorText,
                      ),
                      child: SyStepper(
                        value: field.value ?? 0,
                        step: formControl.step ?? 1,
                        min: formControl.min ?? 0,
                        max: formControl.max ?? 9999999,
                        size: 24.0,
                        onChange: (widget.readonly || formControl.readonly)
                            ? null
                            : (value) {
                                field.didChange(value);
                              },
                      ),
                    );
                  },
                );
                break;

              case FormBuilderInput.TYPE_RATE:
                return FormField(
                  enabled: !(widget.readonly || formControl.readonly),
                  key: _fieldKey,
                  initialValue: formControl.value ?? 1,
                  validator: (value) {
                    if (formControl.require && value == null)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(value);
                  },
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: formControl.decoration.copyWith(
                        enabled: !(widget.readonly || formControl.readonly),
                        errorText: field.errorText,
                      ),
                      child: SyRate(
                        value: field.value,
                        total: formControl.max,
                        icon: formControl.icon,
                        //TODO: When disabled change icon color (Probably deep grey)
                        iconSize: formControl.iconSize ?? 24.0,
                        onTap: (widget.readonly || formControl.readonly)
                            ? null
                            : (value) {
                                field.didChange(value);
                              },
                      ),
                    );
                  },
                );
                break;

              case FormBuilderInput.TYPE_CHECKBOX:
                return FormField(
                  key: _fieldKey,
                  enabled: !(widget.readonly || formControl.readonly),
                  initialValue: formControl.value ?? false,
                  validator: (value) {
                    if (formControl.require && value == null)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(value);
                  },
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: formControl.decoration.copyWith(
                        enabled: !(widget.readonly || formControl.readonly),
                        errorText: field.errorText,
                      ),
                      child: ListTile(
                        dense: true,
                        isThreeLine: false,
                        contentPadding: EdgeInsets.all(0.0),
                        title: formControl.label,
                        trailing: Checkbox(
                          value: field.value ?? false,
                          onChanged: (widget.readonly || formControl.readonly)
                              ? null
                              : (bool value) {
                                  field.didChange(value);
                                },
                        ),
                        onTap: (widget.readonly || formControl.readonly)
                            ? null
                            : () {
                                bool newValue = !(field.value ?? false);
                                field.didChange(newValue);
                              },
                      ),
                    );
                  },
                );
                break;

              case FormBuilderInput.TYPE_SLIDER:
                return FormField(
                  key: _fieldKey,
                  enabled: !(widget.readonly || formControl.readonly),
                  initialValue: formControl.value,
                  validator: (value) {
                    if (formControl.require && value == null)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(value);
                  },
                  onSaved: (val) {
                    value[formControl.attribute] = val;
                  },
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: formControl.decoration.copyWith(
                        enabled: !(widget.readonly || formControl.readonly),
                        errorText: field.errorText,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Slider(
                              value: field.value,
                              min: formControl.min,
                              max: formControl.max,
                              divisions: formControl.divisions,
                              onChanged:
                                  (widget.readonly || formControl.readonly)
                                      ? null
                                      : (double value) {
                                          field.didChange(value);
                                        },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("${formControl.min}"),
                                Text("${field.value}"),
                                Text("${formControl.max}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                break;

              case FormBuilderInput.TYPE_CHECKBOX_LIST:
                return FormField(
                    key: _fieldKey,
                    enabled: !(widget.readonly || formControl.readonly),
                    initialValue: formControl.value ?? [],
                    onSaved: (val) {
                      value[formControl.attribute] = val;
                    },
                    validator: formControl.validator,
                    builder: (FormFieldState<dynamic> field) {
                      List<Widget> checkboxList = [];
                      for (int i = 0; i < formControl.options.length; i++) {
                        checkboxList.addAll([
                          ListTile(
                            dense: true,
                            isThreeLine: false,
                            contentPadding: EdgeInsets.all(0.0),
                            leading: Checkbox(
                              value: field.value
                                  .contains(formControl.options[i].value),
                              onChanged: (widget.readonly ||
                                      formControl.readonly)
                                  ? null
                                  : (bool value) {
                                      var currValue = field.value;
                                      if (value)
                                        currValue
                                            .add(formControl.options[i].value);
                                      else
                                        currValue.remove(
                                            formControl.options[i].value);
                                      field.didChange(currValue);
                                    },
                            ),
                            title: Text(
                                "${formControl.options[i].label ?? formControl.options[i].value}"),
                            onTap: (widget.readonly || formControl.readonly)
                                ? null
                                : () {
                                    var currentValue = field.value;
                                    if (!currentValue
                                        .contains(formControl.options[i].value))
                                      currentValue
                                          .add(formControl.options[i].value);
                                    else
                                      currentValue
                                          .remove(formControl.options[i].value);
                                    field.didChange(currentValue);
                                  },
                          ),
                          Divider(
                            height: 0.0,
                          ),
                        ]);
                      }
                      return InputDecorator(
                        decoration: formControl.decoration.copyWith(
                          enabled: !(widget.readonly || formControl.readonly),
                          errorText: field.errorText,
                          contentPadding:
                              EdgeInsets.only(top: 10.0, bottom: 0.0),
                          border: InputBorder.none,
                        ),
                        child: Column(
                          children: checkboxList,
                        ),
                      );
                    });
                break;
              case FormBuilderInput.TYPE_CHIPS_INPUT:
                return SizedBox(
                  // height: 200.0,
                  child: FormField(
                    key: _fieldKey,
                    enabled: !(widget.readonly || formControl.readonly),
                    initialValue: formControl.value ?? [],
                    onSaved: (val) {
                      value[formControl.attribute] = val;
                    },
                    validator: (value) {
                      if (formControl.require && value.length == 0)
                        return "${formControl.attribute} is required";
                      if (formControl.validator != null)
                        return formControl.validator(value);
                    },
                    builder: (FormFieldState<dynamic> field) {
                      return ChipsInput(
                        initialValue: field.value,
                        enabled: !(widget.readonly || formControl.readonly),
                        decoration: formControl.decoration.copyWith(
                          enabled: !(widget.readonly || formControl.readonly),
                          errorText: field.errorText,
                        ),
                        findSuggestions: formControl.suggestionsCallback,
                        onChanged: (data) {
                          field.didChange(data);
                        },
                        chipBuilder: formControl.chipBuilder,
                        suggestionBuilder: formControl.suggestionBuilder,
                      );
                    },
                  ),
                );
                break;

              case FormBuilderInput.TYPE_SIGNATURE_PAD:
                var _signatureCanvas = Signature(
                  points: formControl.points,
                  width: formControl.width,
                  height: formControl.height,
                  backgroundColor: formControl.backgroundColor,
                  penColor: formControl.penColor,
                  penStrokeWidth: formControl.penStrokeWidth,
                );

                return FormField<Image>(
                  key: Key(formControl.attribute),
                  enabled: !(widget.readonly || formControl.readonly),
                  initialValue: formControl.value,
                  onSaved: (val) async {
                    Uint8List signature = await _signatureCanvas.exportBytes();
                    var image = Image.memory(signature).image;
                    value[formControl.attribute] = image;
                  },
                  validator: (value) {
                    if (formControl.require && _signatureCanvas.isEmpty)
                      return "${formControl.attribute} is required";
                    if (formControl.validator != null)
                      return formControl.validator(value);
                  },
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: formControl.decoration.copyWith(
                        enabled: !(widget.readonly || formControl.readonly),
                        errorText: field.errorText,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: GestureDetector(
                              onVerticalDragUpdate: (_) {},
                              child: _signatureCanvas,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: SizedBox()),
                              FlatButton(
                                  onPressed: () {
                                    _signatureCanvas.clear();
                                    field.didChange(null);
                                  },
                                  child: Text('Clear')),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );

                break;
            }
          }).toList(),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
