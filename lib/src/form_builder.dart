import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

import './form_builder_input.dart';

//TODO: Refactor this spaghetti code
class FormBuilder extends StatefulWidget {
  final BuildContext context;
  final Function(Map<String, dynamic>) onChanged;
  final WillPopCallback onWillPop;
  final List<FormBuilderInput> controls;
  final Function onSubmit;
  final bool autovalidate;
  final bool showResetButton;
  final Widget submitButtonContent;
  final Widget resetButtonContent;
  final bool readonly;

  const FormBuilder(
    this.context, {
    @required this.controls,
    @required this.onSubmit,
    this.readonly = false,
    this.onChanged,
    this.autovalidate = false,
    this.showResetButton = false,
    this.onWillPop,
    this.submitButtonContent,
    this.resetButtonContent,
  }) : assert(resetButtonContent == null || showResetButton);

  // assert(duplicateAttributes(controls).length == 0, "Duplicate attribute names not allowed");

  //TODO: Find way to assert no duplicates in control attributes
  /*Function duplicateAttributes = (List<FormBuilderInput> controls) {
    List<String> attributeList = [];
    controls.forEach((c) {
      attributeList.add(c.attribute);
    });
    List<String> uniqueAttributes = Set.from(attributeList).toList(growable: false);
    //attributeList.
  };*/

  @override
  _FormBuilderState createState() => _FormBuilderState(controls);
}

class _FormBuilderState extends State<FormBuilder> {
  final List<FormBuilderInput> formControls;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};

  _FormBuilderState(this.formControls);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        if (widget.onChanged != null) {
          _formKey.currentState.save();
          widget.onChanged(formData);
        }
      },
      //TODO: Allow user to update field value or validate based on changes in others (e.g. Summations, Confirm Password)
      onWillPop: widget.onWillPop,
      autovalidate: widget.autovalidate,
      child: SingleChildScrollView(
        child: Column(
          children: formControlsToForm(),
        ),
      ),
    );
  }

  List<Widget> formControlsToForm() {
    List<Widget> formControlsList = List<Widget>();

    for (var count = 0; count < formControls.length; count++) {
      FormBuilderInput formControl = formControls[count];
      
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
          formControlsList.add(TextFormField(
            key: Key(formControl.attribute),
            enabled: !(widget.readonly || formControl.readonly),
            style: (widget.readonly || formControl.readonly)
                ? Theme.of(context).textTheme.subhead.copyWith(
                      color: Theme.of(context).disabledColor,
                    )
                : null,
            focusNode: (widget.readonly || formControl.readonly)
                ? AlwaysDisabledFocusNode()
                : null,
            decoration: InputDecoration(
              labelText: formControl.label,
              enabled: !(widget.readonly || formControl.readonly),
              hintText: formControl.hint,
              helperText: formControl.hint,
            ),
            initialValue:
                formControl.value != null ? "${formControl.value}" : '',
            maxLines: formControl.type == FormBuilderInput.TYPE_MULTILINE_TEXT
                ? 5
                : 1,
            keyboardType: keyboardType,
            obscureText: formControl.type == FormBuilderInput.TYPE_PASSWORD
                ? true
                : false,
            onSaved: (value) {
              formData[formControl.attribute] =
                  formControl.type == FormBuilderInput.TYPE_NUMBER
                      ? num.tryParse(value)
                      : value;
            },
            validator: (value) {
              if (formControl.require && value.isEmpty)
                return "${formControl.label} is required";

              if (formControl.type == FormBuilderInput.TYPE_NUMBER) {
                if (num.tryParse(value) == null && value.isNotEmpty)
                  return "$value is not a valid number";
                if (formControl.max != null &&
                    num.tryParse(value) > formControl.max)
                  return "${formControl.label} should not be greater than ${formControl.max}";
                if (formControl.min != null &&
                    num.tryParse(value) < formControl.min)
                  return "${formControl.label} should not be less than ${formControl.min}";
              } else {
                if (formControl.max != null && value.length > formControl.max)
                  return "${formControl.label} should have ${formControl.max} character(s) or less";
                if (formControl.min != null && value.length < formControl.min)
                  return "${formControl.label} should have ${formControl.min} character(s) or more";
              }

              if (formControl.type == FormBuilderInput.TYPE_EMAIL &&
                  value.isNotEmpty) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                if (!RegExp(pattern).hasMatch(value))
                  return '$value is not a valid email address';
              }

              if (formControl.type == FormBuilderInput.TYPE_URL &&
                  value.isNotEmpty) {
                Pattern pattern =
                    r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                if (!RegExp(pattern, caseSensitive: false).hasMatch(value))
                  return '$value is not a valid URL';
              }

              if (formControl.validator != null)
                return formControl.validator(value);
            },
            // autovalidate: ,
          ));
          break;

        case FormBuilderInput.TYPE_DATE_PICKER:
          formControlsList.add(_generateDatePicker(widget, formControl, count));
          break;

        case FormBuilderInput.TYPE_TIME_PICKER:
          formControlsList.add(_generateTimePicker(widget, formControl, count));
          break;

        case FormBuilderInput.TYPE_TYPE_AHEAD:
          TextEditingController _typeAheadController =
              TextEditingController(text: formControl.value);
          formControlsList.add(TypeAheadFormField(
            key: Key(formControl.attribute),
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
              decoration: InputDecoration(
                labelText: formControl.label,
                enabled: !(widget.readonly || formControl.readonly),
                hintText: formControl.hint,
              ),
            ),
            suggestionsCallback: formControl.suggestionsCallback,
            itemBuilder: formControl.itemBuilder,
            transitionBuilder: (context, suggestionsBox, controller) =>
                suggestionsBox,
            onSuggestionSelected: (suggestion) {
              _typeAheadController.text = suggestion;
            },
            validator: (value) {
              if (formControl.require && value.isEmpty)
                return '${formControl.label} is required';

              if (formControl.validator != null)
                return formControl.validator(value);
            },
            onSaved: (value) => formData[formControl.attribute] = value,
          ));
          break;

        case FormBuilderInput.TYPE_DROPDOWN:
          formControlsList.add(FormField(
            key: Key(formControl.attribute),
            enabled: !(widget.readonly || formControl.readonly),
            initialValue: formControl.value,
            validator: (value) {
              if (formControl.require && value == null)
                return "${formControl.label} is required";
              if (formControl.validator != null)
                return formControl.validator(value);
            },
            onSaved: (value) {
              formData[formControl.attribute] = value;
            },
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  labelText: formControl.label,
                  enabled: !(widget.readonly || formControl.readonly),
                  helperText: formControl.hint,
                  errorText: field.errorText,
                  contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  border: InputBorder.none,
                ),
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(formControl.hint ?? ''),
                  items: formControls[count].options.map((option) {
                    return DropdownMenuItem(
                      child: Text("${option.label ?? option.value}"),
                      value: option.value,
                    );
                  }).toList(),
                  value: field.value,
                  onChanged: (widget.readonly || formControl.readonly) ? null : (value) {
                    field.didChange(value);
                  },
                ),
              );
            },
          ));
          break;

        //TODO: For TYPE_CHECKBOX, TYPE_CHECKBOX_LIST, TYPE_RADIO allow user to choose if checkbox/radio to appear before or after Label
        case FormBuilderInput.TYPE_RADIO:
          formControlsList.add(FormField(
            key: Key(formControl.attribute),
            enabled: !widget.readonly && !formControl.readonly,
            initialValue: formControl.value,
            onSaved: (value) {
              formData[formControl.attribute] = value;
            },
            validator: (value) {
              if (formControl.require && value == null)
                return "${formControl.label} is required";
              if (formControl.validator != null)
                return formControl.validator(value);
            },
            builder: (FormFieldState<dynamic> field) {
              List<Widget> radioList = [];
              for (int i = 0; i < formControls[count].options.length; i++) {
                radioList.addAll([
                  ListTile(
                    dense: true,
                    isThreeLine: false,
                    contentPadding: EdgeInsets.all(0.0),
                    leading: null,
                    title: Text(
                        "${formControls[count].options[i].label ?? formControls[count].options[i].value}"),
                    trailing: Radio<dynamic>(
                      value: formControls[count].options[i].value,
                      groupValue: field.value,
                      onChanged: (widget.readonly || formControl.readonly) ? null : (dynamic value) {
                        field.didChange(value);
                      },
                    ),
                    onTap: (widget.readonly || formControl.readonly) ? null : () {
                      var selectedValue = formControls[count].value =
                          formControls[count].options[i].value;
                      field.didChange(selectedValue);
                    },
                  ),
                  Divider(
                    height: 0.0,
                  ),
                ]);
              }
              return InputDecorator(
                decoration: InputDecoration(
                  labelText: formControl.label,
                  enabled: !(widget.readonly || formControl.readonly),
                  helperText: formControl.hint ?? "",
                  errorText: field.errorText,
                  contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  border: InputBorder.none,
                ),
                child: Column(
                  children: radioList,
                ),
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_SEGMENTED_CONTROL:
          formControlsList.add(FormField(
            key: Key(formControl.attribute),
            initialValue: formControl.value,
            enabled: !(widget.readonly || formControl.readonly),
            onSaved: (value) {
              formData[formControl.attribute] = value;
            },
            validator: (value) {
              if (formControl.require && value == null)
                return "${formControl.label} is required";
              if (formControl.validator != null)
                return formControl.validator(value);
            },
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  labelText: formControl.label,
                  enabled: !(widget.readonly || formControl.readonly),
                  helperText: formControl.hint,
                  errorText: field.errorText,
                  contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  border: InputBorder.none,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: CupertinoSegmentedControl(
                    borderColor: (widget.readonly || formControl.readonly) ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
                    selectedColor: (widget.readonly || formControl.readonly) ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
                    pressedColor: (widget.readonly || formControl.readonly) ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
                    groupValue: field.value,
                    children: Map.fromIterable(
                      formControls[count].options,
                      key: (v) => v.value,
                      value: (v) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text("${v.label ?? v.value}"),
                          ),
                    ),
                    onValueChanged: (dynamic value) {
                      if(widget.readonly || formControl.readonly) {
                        field.reset();
                      }else
                        field.didChange(value);
                    },
                  ),
                ),
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_SWITCH:
          formControlsList.add(FormField(
              key: Key(formControl.attribute),
              enabled: !(widget.readonly || formControl.readonly),
              initialValue: formControl.value ?? false,
              validator: (value) {
                if (formControl.require && value == null)
                  return "${formControl.label} is required";
                /*if (formControl.validator != null)
                  return formControl.validator(value);*/
              },
              onSaved: (value) {
                formData[formControl.attribute] = value;
              },
              builder: (FormFieldState<dynamic> field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    // labelText: formControl.label,
                    enabled: !(widget.readonly || formControl.readonly),
                    helperText: formControl.hint ?? "",
                    errorText: field.errorText,
                  ),
                  child: ListTile(
                    dense: true,
                    isThreeLine: false,
                    contentPadding: EdgeInsets.all(0.0),
                    title: Text(
                      formControl.label,
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Switch(
                      value: field.value,
                      onChanged: (widget.readonly || formControl.readonly) ? null : (bool value) {
                        field.didChange(value);
                      },
                    ),
                    onTap: (widget.readonly || formControl.readonly) ? null : () {
                      bool newValue = !(field.value ?? false);
                      field.didChange(newValue);
                    },
                  ),
                );
              }));
          break;

        case FormBuilderInput.TYPE_STEPPER:
          formControlsList.add(FormField(
            enabled: !(widget.readonly || formControl.readonly),
            key: Key(formControl.attribute),
            initialValue: formControl.value,
            validator: (value) {
              if (formControl.require && value == null)
                return "${formControl.label} is required";
              if (formControl.validator != null)
                return formControl.validator(value);
            },
            onSaved: (value) {
              formData[formControl.attribute] = value;
            },
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  labelText: formControl.label,
                  enabled: !(widget.readonly || formControl.readonly),
                  helperText: formControl.hint ?? "",
                  errorText: field.errorText,
                ),
                child: SyStepper(
                  value: field.value ?? 0,
                  step: formControl.step ?? 1,
                  min: formControl.min ?? 0,
                  max: formControl.max ?? 9999999,
                  size: 24.0,
                  onChange: (widget.readonly || formControl.readonly) ? null : (value) {
                    field.didChange(value);
                  },
                ),
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_RATE:
          formControlsList.add(FormField(
            enabled: !(widget.readonly || formControl.readonly),
            key: Key(formControl.attribute),
            initialValue: formControl.value ?? 1,
            validator: (value) {
              if (formControl.require && value == null)
                return "${formControl.label} is required";
              if (formControl.validator != null)
                return formControl.validator(value);
            },
            onSaved: (value) {
              formData[formControl.attribute] = value;
            },
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  labelText: formControl.label,
                  enabled: !(widget.readonly || formControl.readonly),
                  helperText: formControl.hint ?? "",
                  errorText: field.errorText,
                ),
                child: SyRate(
                  value: field.value,
                  total: formControl.max,
                  icon: formControl.icon, //TODO: When disabled change icon color (Probably deep grey)
                  iconSize: formControl.iconSize ?? 24.0,
                  onTap: (widget.readonly || formControl.readonly) ? null : (value) {
                    field.didChange(value);
                  },
                ),
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_CHECKBOX:
          formControlsList.add(FormField(
            key: Key(formControl.attribute),
            enabled: !(widget.readonly || formControl.readonly),
            initialValue: formControl.value ?? false,
            validator: (value) {
              if (formControl.require && value == null)
                return "${formControl.label} is required";
              if (formControl.validator != null)
                return formControl.validator(value);
            },
            onSaved: (value) {
              formData[formControl.attribute] = value;
            },
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  // labelText: formControl.label,
                  enabled: !(widget.readonly || formControl.readonly),
                  helperText: formControl.hint ?? "",
                  errorText: field.errorText,
                ),
                child: ListTile(
                  dense: true,
                  isThreeLine: false,
                  contentPadding: EdgeInsets.all(0.0),
                  title: Text(
                    formControl.label,
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Checkbox(
                    value: field.value ?? false,
                    onChanged: (widget.readonly || formControl.readonly) ? null : (bool value) {
                      field.didChange(value);
                    },
                  ),
                  onTap: (widget.readonly || formControl.readonly) ? null : () {
                    bool newValue = !(field.value ?? false);
                    field.didChange(newValue);
                  },
                ),
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_SLIDER:
          formControlsList.add(FormField(
            key: Key(formControl.attribute),
            enabled: !(widget.readonly || formControl.readonly),
            initialValue: formControl.value,
            validator: (value) {
              if (formControl.require && value == null)
                return "${formControl.label} is required";
              if (formControl.validator != null)
                return formControl.validator(value);
            },
            onSaved: (value) {
              formData[formControl.attribute] = value;
            },
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  labelText: formControl.label,
                  enabled: !(widget.readonly || formControl.readonly),
                  helperText: formControl.hint,
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
                        onChanged: (widget.readonly || formControl.readonly) ? null : (double value) {
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
          ));
          break;

        case FormBuilderInput.TYPE_CHECKBOX_LIST:
          formControlsList.add(FormField(
              key: Key(formControl.attribute),
              enabled: !(widget.readonly || formControl.readonly),
              initialValue: formControl.value ?? [],
              onSaved: (value) {
                formData[formControl.attribute] = value;
              },
              validator: formControl.validator,
              builder: (FormFieldState<dynamic> field) {
                List<Widget> checkboxList = [];
                for (int i = 0; i < formControls[count].options.length; i++) {
                  checkboxList.addAll([
                    ListTile(
                      dense: true,
                      isThreeLine: false,
                      contentPadding: EdgeInsets.all(0.0),
                      leading: Checkbox(
                        value: field.value
                            .contains(formControls[count].options[i].value),
                        onChanged: (widget.readonly || formControl.readonly) ? null : (bool value) {
                          if (value)
                            formControls[count]
                                .value
                                .add(formControls[count].options[i].value);
                          else
                            formControls[count]
                                .value
                                .remove(formControls[count].options[i].value);
                          field.didChange(formControls[count].value);
                        },
                      ),
                      title: Text(
                          "${formControls[count].options[i].label ?? formControls[count].options[i].value}"),
                      onTap: (widget.readonly || formControl.readonly) ? null : () {
                        bool newValue = field.value
                            .contains(formControls[count].options[i].value);
                        if (!newValue)
                          formControls[count]
                              .value
                              .add(formControls[count].options[i].value);
                        else
                          formControls[count]
                              .value
                              .remove(formControls[count].options[i].value);
                        field.didChange(formControls[count].value);
                      },
                    ),
                    Divider(
                      height: 0.0,
                    ),
                  ]);
                }
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: formControl.label,
                    enabled: !(widget.readonly || formControl.readonly),
                    helperText: formControl.hint ?? "",
                    errorText: field.errorText,
                    contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                    border: InputBorder.none,
                  ),
                  child: Column(
                    children: checkboxList,
                  ),
                );
              }));
          break;
        case FormBuilderInput.TYPE_CHIPS_INPUT:
          formControlsList.add(SizedBox(
            // height: 200.0,
            child: FormField(
              key: Key(formControl.attribute),
              enabled: !(widget.readonly || formControl.readonly),
              initialValue: formControl.value ?? [],
              onSaved: (value) {
                formData[formControl.attribute] = value;
              },
              validator: (value) {
                if (formControl.require && value.length == 0)
                  return "${formControl.label} is required";
                if (formControl.validator != null)
                  return formControl.validator(value);
              },
              builder: (FormFieldState<dynamic> field) {
                return ChipsInput(
                  initialValue: field.value,
                  enabled: !(widget.readonly || formControl.readonly),
                  decoration: InputDecoration(
                    // prefixIcon: Icon(Icons.search),
                    enabled: !(widget.readonly || formControl.readonly),
                    hintText: formControl.hint,
                    labelText: formControl.label,
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
          ));
          break;
      }
    }

    formControlsList.add(Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          widget.showResetButton
              ? Expanded(
                  child: OutlineButton(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      _formKey.currentState.reset();
                    },
                    child: widget.resetButtonContent ?? Text('Reset'),
                  ),
                )
              : SizedBox(),
          Expanded(
            child: MaterialButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: () {
                _formKey.currentState.save();
                if (_formKey.currentState.validate()) {
                  widget.onSubmit(formData);
                } else {
                  debugPrint("Validation failed");
                  widget.onSubmit(null);
                }
              },
              child: widget.submitButtonContent ?? Text('Submit'),
            ),
          ),
        ],
      ),
    ));

    return formControlsList;
  }

  _generateDatePicker(
      FormBuilder formWidget, FormBuilderInput formControl, int count) {
    TextEditingController _inputController =
        new TextEditingController(text: formControl.value);
    FocusNode _focusNode = FocusNode();
    return GestureDetector(
      onTap: (formWidget.readonly || formControl.readonly) ? null : () {
        FocusScope.of(context).requestFocus(_focusNode);
        _showDatePickerDialog(
          context,
          initialDate: DateTime.tryParse(_inputController.value.text),
          firstDate: formControl.firstDate,
          lastDate: formControl.lastDate,
        ).then((selectedDate) {
          if (selectedDate != null) {
            String selectedDateFormatted =
                DateFormat(formControl.format ?? 'yyyy-MM-dd')
                    .format(selectedDate);
            _inputController.value =
                TextEditingValue(text: selectedDateFormatted);
          }
        });
      },
      child: AbsorbPointer(
        child: TextFormField(
          key: Key(formControl.attribute),
          enabled: !(formWidget.readonly || formControl.readonly),
          style: (formWidget.readonly || formControl.readonly)
              ? Theme.of(context).textTheme.subhead.copyWith(
                    color: Theme.of(context).disabledColor,
                  )
              : null,
          focusNode: (formWidget.readonly || formControl.readonly)
              ? AlwaysDisabledFocusNode()
              : _focusNode,
          validator: (value) {
            if (formControl.require && (value.isEmpty || value == null))
              return "${formControl.label} is required";
            if (formControl.validator != null)
              return formControl.validator(value);
          },
          controller: _inputController,
          decoration: InputDecoration(
            labelText: formControl.label,
            enabled: !(formWidget.readonly || formControl.readonly),
            hintText: formControl.hint ?? "",
          ),
          onSaved: (value) {
            formData[formControl.attribute] = value;
          },
        ),
      ),
    );
  }

  _generateTimePicker(
      FormBuilder formWidget, FormBuilderInput formControl, int count) {
    TextEditingController _inputController =
        new TextEditingController(text: formControl.value);
    FocusNode _focusNode = new FocusNode();
    return GestureDetector(
      onTap: (formWidget.readonly || formControl.readonly) ? null : () {
        FocusScope.of(context).requestFocus(_focusNode);
        _showTimePickerDialog(
          context,
          // initialTime: new Time, //FIXME: Parse time from string
        ).then((selectedTime) {
          if (selectedTime != null) {
            String selectedDateFormatted = selectedTime.format(context);
            _inputController.value =
                TextEditingValue(text: selectedDateFormatted);
          }
        });
      },
      child: AbsorbPointer(
        child: TextFormField(
          key: Key(formControl.attribute),
          enabled: !(formWidget.readonly || formControl.readonly),
          style: (formWidget.readonly || formControl.readonly)
              ? Theme.of(context).textTheme.subhead.copyWith(
                    color: Theme.of(context).disabledColor,
                  )
              : null,
          controller: _inputController,
          focusNode: (formWidget.readonly || formControl.readonly)
              ? AlwaysDisabledFocusNode()
              : _focusNode,
          validator: (value) {
            if (formControl.require && (value.isEmpty || value == null))
              return "${formControl.label} is required";
            if (formControl.validator != null)
              return formControl.validator(value);
          },
          decoration: InputDecoration(
            labelText: formControl.label,
            enabled: !(formWidget.readonly || formControl.readonly),
            hintText: formControl.hint ?? "",
          ),
          onSaved: (value) {
            formData[formControl.attribute] = value;
          },
        ),
      ),
    );
  }

  Future<DateTime> _showDatePickerDialog(BuildContext context,
      {DateTime initialDate, DateTime firstDate, DateTime lastDate}) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now().subtract(Duration(days: 100000)),
      lastDate: lastDate ?? DateTime.now().add(Duration(days: 100000)),
    );
    return picked;
  }

  Future<TimeOfDay> _showTimePickerDialog(BuildContext context,
      {TimeOfDay initialTime}) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    return picked;
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
