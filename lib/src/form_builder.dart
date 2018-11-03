import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

import './form_builder_input.dart';
import './form_builder_type_ahead.dart';

class FormBuilder extends StatefulWidget {
  final BuildContext context;
  final VoidCallback onChanged;
  final WillPopCallback onWillPop;
  final List<FormBuilderInput> controls;
  final Function onSubmit;
  final bool autovalidate;
  final bool showResetButton;
  final Widget submitButtonContent;
  final Widget resetButtonContent;

  const FormBuilder(
    this.context, {
    @required this.controls,
    @required this.onSubmit,
    this.onChanged,
    this.autovalidate = false,
    this.showResetButton = false,
    this.onWillPop,
    this.submitButtonContent,
    this.resetButtonContent,
  }): assert(resetButtonContent == null || showResetButton);

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
      onChanged: widget.onChanged,
      //TODO: Allow user to update field value or validate based on changes in others (e.g. Summations, Confirm Password)
      onWillPop: widget.onWillPop,
      autovalidate: widget.autovalidate,
      child: ListView(
        children: formControlsToForm(),
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
            //TODO: add min and max validation for non-numeric text to validate character count
            decoration: InputDecoration(
              labelText: formControl.label,
              hintText: formControl.hint ?? "",
            ),
            initialValue:
                formControl.value != null ? "${formControl.value}" : null,
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
          formControlsList.add(_generateDatePicker(formControl, count));
          break;

        case FormBuilderInput.TYPE_TIME_PICKER:
          formControlsList.add(_generateTimePicker(formControl, count));
          break;

        case FormBuilderInput.TYPE_TYPE_AHEAD:
          formControlsList.add(FormBuilderTypeAhead(
            formControl: formControl,
            count: count,
            onSaved: (value) {
              formData[formControl.attribute] = value;
            },
          ));
          break;

        case FormBuilderInput.TYPE_DROPDOWN:
          // dropdownHasError =
          formControlsList.add(FormField(
            initialValue: formControl.value,
            validator: (value) {
              if (formControl.require && value == null)
                return "${formControl.label} is required";
              if (formControl.validator != null)
                return formControl.validator(value);
            },
            // autovalidate: ,
            onSaved: (value) {
              formData[formControl.attribute] = value;
            },
            builder: (FormFieldState<dynamic> field) {
              return Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      formControl.label,
                      style: TextStyle(color: Colors.grey),
                    ),
                    DropdownButton(
                      isExpanded: true,
                      hint: Text(formControl.hint ?? ''),
                      items: formControls[count].options.map((option) {
                        return DropdownMenuItem(
                          child: Text(option.label ?? option.value),
                          value: option.value,
                        );
                      }).toList(),
                      value: formControl.value,
                      onChanged: (value) {
                        setState(() {
                          formControls[count].value = value;
                        });
                        field.didChange(value);
                      },
                    ),
                    field.hasError
                        ? Text(
                            field.errorText,
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          )
                        : SizedBox(),
                  ],
                ),
              );
            },
          ));
          break;

        //TODO: For TYPE_CHECKBOX, TYPE_CHECKBOX_LIST, TYPE_RADIO allow user to choose if checkbox/radio to appear before or after Label
        case FormBuilderInput.TYPE_RADIO:
          formControlsList.add(FormField(
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
                radioList.add(ListTile(
                  title: Text(formControls[count].options[i].label ??
                      formControls[count].options[i].value),
                  trailing: Radio<dynamic>(
                    value: formControls[count].options[i].value,
                    groupValue: formControls[count].value,
                    onChanged: (dynamic value) {
                      setState(() {
                        formControls[count].value = value;
                      });
                      field.didChange(value);
                    },
                  ),
                  onTap: () {
                    var selectedValue = formControls[count].value =
                        formControls[count].options[i].value;
                    setState(() {
                      formControls[count].value = selectedValue;
                    });
                    field.didChange(selectedValue);
                  },
                ));
              }
              return Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      formControl.label,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Column(
                      children: radioList,
                    ),
                    field.hasError
                        ? Text(
                            field.errorText,
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            ),
                          )
                        : SizedBox(),
                    Divider(),
                  ],
                ),
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_SEGMENTED_CONTROL:
          formControlsList.add(FormField(
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
              return Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      formControl.label,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: CupertinoSegmentedControl(
                        borderColor: Theme.of(context).primaryColor,
                        selectedColor: Theme.of(context).primaryColor,
                        pressedColor: Theme.of(context).primaryColor,
                        groupValue: field.value,
                        children: Map.fromIterable(
                          formControls[count].options,
                          key: (v) => v.value,
                          value: (v) => Text(
                              v.label != null ? "${v.label}" : "${v.value}"),
                        ),
                        onValueChanged: (dynamic value) {
                          setState(() {
                            formControls[count].value = value;
                          });
                          field.didChange(value);
                        },
                      ),
                    ),
                    field.hasError
                        ? Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              field.errorText,
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          )
                        : SizedBox(),
                    formControl.hasHint()
                        ? Text(
                            formControl.hint,
                            style: Theme.of(context).textTheme.caption,
                          )
                        : SizedBox(),
                  ],
                ),
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_SWITCH:
          formControlsList.add(FormField(
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
                if (formControl.value == null) {
                  setState(() {
                    formControls[count].value = false;
                  });
                }
                return Column(children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          formControl.label,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Switch(
                          value: formControl.value,
                          onChanged: (bool value) {
                            setState(() {
                              formControls[count].value = value;
                            });
                            field.didChange(value);
                          })
                    ],
                  ),
                  field.hasError
                      ? Text(
                          field.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        )
                      : SizedBox(),
                ]);
              }));
          break;

        case FormBuilderInput.TYPE_STEPPER:
          formControlsList.add(FormField(
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(formControl.label ?? formControl.hint),
                      ),
                      SyStepper(
                        value: field.value ?? 0,
                        step: formControl.step ?? 1,
                        min: formControl.min ?? 0,
                        max: formControl.max ?? 9999999,
                        size: 24.0,
                        onChange: (value) {
                          setState(() {
                            formControls[count].value = value;
                          });
                          field.didChange(value);
                        },
                      ),
                    ],
                  ),
                  formControl.hint != null
                      ? Text(
                          formControl.hint,
                          style: Theme.of(context).textTheme.caption,
                        )
                      : SizedBox(),
                  field.hasError
                      ? Text(
                          field.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        )
                      : SizedBox(),
                  Divider(),
                ],
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_RATE:
          formControlsList.add(FormField(
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formControl.label ?? formControl.hint),
                  SyRate(
                    value: field.value,
                    total: formControl.max,
                    icon: formControl.icon,
                    iconSize: formControl.iconSize ?? 24.0,
                    onTap: (value) {
                      setState(() {
                        formControls[count].value = value;
                      });
                      field.didChange(value);
                    },
                  ),
                  formControl.hint != null
                      ? Text(
                          formControl.hint,
                          style: Theme.of(context).textTheme.caption,
                        )
                      : SizedBox(),
                  field.hasError
                      ? Text(
                          field.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        )
                      : SizedBox(),
                  Divider(),
                ],
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_CHECKBOX:
          formControlsList.add(FormField(
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      formControl.label,
                      style: TextStyle(color: Colors.grey),
                    ),
                    subtitle: formControl.hasHint()
                        ? Text(
                            formControl.hint,
                            style: Theme.of(context).textTheme.caption,
                          )
                        : SizedBox(),
                    trailing: Checkbox(
                      value: field.value ?? false,
                      onChanged: (bool value) {
                        setState(() {
                          formControls[count].value = value;
                        });
                        field.didChange(value);
                      },
                    ),
                    onTap: () {
                      var newValue = !(field.value ?? false);
                      setState(() {
                        formControls[count].value = newValue;
                      });
                      field.didChange(newValue);
                    },
                  ),
                  field.hasError
                      ? Text(
                          field.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        )
                      : SizedBox(),
                  Divider(),
                ],
              );
            },
          ));
          break;

        case FormBuilderInput.TYPE_SLIDER:
          formControlsList.add(FormField(
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
                return Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formControl.label,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Slider(
                          value: formControl.value,
                          min: formControl.min,
                          max: formControl.max,
                          divisions: formControl.divisions,
                          onChanged: (double value) {
                            setState(() {
                              formControls[count].value = value.roundToDouble();
                            });
                            field.didChange(value);
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("${formControl.min}"),
                          Text("${formControl.value}"),
                          Text("${formControl.max}"),
                        ],
                      ),
                      field.hasError
                          ? Text(
                              field.errorText,
                              style: TextStyle(
                                  color: Theme.of(context).errorColor),
                            )
                          : SizedBox(),
                      formControl.hasHint()
                          ? Text(
                              formControl.hint,
                              style: Theme.of(context).textTheme.caption,
                            )
                          : SizedBox(),
                      Divider(),
                    ],
                  ),
                );
              }));
          break;

        case FormBuilderInput.TYPE_CHECKBOX_LIST:
          formControlsList.add(FormField(
              initialValue: formControl.value ?? [],
              onSaved: (value) {
                formData[formControl.attribute] = value;
              },
              // validator: formControl.validator,
              builder: (FormFieldState<dynamic> field) {
                List<Widget> checkboxList = [];
                for (int i = 0; i < formControls[count].options.length; i++) {
                  checkboxList.add(ListTile(
                    leading: Checkbox(
                      value: field.value
                          .contains(formControls[count].options[i].value),
                      onChanged: (bool value) {
                        setState(() {
                          if (value)
                            formControls[count]
                                .value
                                .add(formControls[count].options[i].value);
                          else
                            formControls[count]
                                .value
                                .remove(formControls[count].options[i].value);
                        });
                        field.didChange(formControls[count].value);
                      },
                    ),
                    title: Text(
                        "${formControls[count].options[i].label ?? formControls[count].options[i].value}"),
                    onTap: () {
                      setState(() {
                        formControls[count]
                            .value
                            .add(formControls[count].options[i].value);
                      });
                      field.didChange(formControls[count].value);
                    },
                  ));
                }
                return Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        formControl.label,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Column(
                        children: checkboxList,
                      ),
                      field.hasError
                          ? Text(
                              field.errorText,
                              style: TextStyle(
                                  color: Theme.of(context).errorColor),
                            )
                          : SizedBox(),
                      Divider(),
                    ],
                  ),
                );
              }));
          break;
      }
    }

    formControlsList.add(Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          widget.showResetButton ? Expanded(
            child: OutlineButton(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
              textColor: Theme.of(context).accentColor,
              onPressed: () {
                _formKey.currentState.reset(); //FIXME: only resets TextField based inputs
              },
              child: widget.resetButtonContent ?? Text('Reset'),
            ),
          ) : SizedBox(),
          Expanded(
            child: MaterialButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
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

  _generateDatePicker(FormBuilderInput formControl, int count) {
    TextEditingController _inputController =
        new TextEditingController(text: formControl.value);
    return GestureDetector(
      onTap: () {
        _showDatePickerDialog(
          context,
          initialDate: DateTime.tryParse(_inputController.value.text),
        ).then((selectedDate) {
          if (selectedDate != null) {
            String selectedDateFormatted = DateFormat('yyyy-MM-dd')
                .format(selectedDate); //TODO: Ask user for format
            setState(() {
              formControls[count].value = selectedDateFormatted;
            });
            _inputController.value =
                TextEditingValue(text: selectedDateFormatted);
          }
        });
      },
      child: AbsorbPointer(
        child: TextFormField(
          validator: (value) {
            if (formControl.require && (value.isEmpty || value == null))
              return "${formControl.label} is required";
            if (formControl.validator != null)
              return formControl.validator(value);
          },
          controller: _inputController,
          decoration: InputDecoration(
            labelText: formControl.label,
            hintText: formControl.hint ?? "",
          ),
          onSaved: (value) {
            setState(() {
              formControls[count].value = value;
            });
            formData[formControl.attribute] = value;
          },
        ),
      ),
    );
  }

  _generateTimePicker(FormBuilderInput formControl, int count) {
    TextEditingController _inputController =
        new TextEditingController(text: formControl.value);
    return GestureDetector(
      onTap: () {
        _showTimePickerDialog(
          context,
          // initialTime: new Time, //FIXME: Parse time from string
        ).then((selectedTime) {
          if (selectedTime != null) {
            String selectedDateFormatted = selectedTime.format(context);
            setState(() {
              formControls[count].value = selectedDateFormatted;
            });
            _inputController.value =
                TextEditingValue(text: selectedDateFormatted);
          }
        });
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: _inputController,
          validator: (value) {
            if (formControl.require && (value.isEmpty || value == null))
              return "${formControl.label} is required";
            if (formControl.validator != null)
              return formControl.validator(value);
          },
          decoration: InputDecoration(
            labelText: formControl.label,
            hintText: formControl.hint ?? "",
          ),
          onSaved: (value) {
            setState(() {
              formControls[count].value = value;
            });
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
      firstDate:
          firstDate ?? DateTime.now().subtract(new Duration(days: 10000)),
      lastDate: lastDate ?? DateTime.now().add(new Duration(days: 10000)),
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
