import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:form_builder/src/form_builder_type_ahead.dart';

import './src/form_builder_input.dart';

class FormBuilder extends StatefulWidget {
  final BuildContext context;
  final VoidCallback onChanged;
  final WillPopCallback onWillPop;
  final List<FormBuilderInput> controls;
  final Function onSubmit;
  final bool autovalidate;
  final Widget submitButtonContent;

  const FormBuilder(
    this.context, {
    @required this.controls,
    @required this.onSubmit,
    this.onChanged,
    this.autovalidate = false,
    this.onWillPop,
    this.submitButtonContent,
  });

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
      //TODO: Allow user to update field value based on changes in others
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
        case FormBuilderInput.TYPE_EMAIL:
        case FormBuilderInput.TYPE_URL:
        case FormBuilderInput.TYPE_MULTILINE_TEXT:
          formControlsList.add(TextFormField(
            decoration: InputDecoration(
              labelText: formControl.label,
              hintText: formControl.placeholder ?? "",
            ),
            initialValue:
                formControl.value != null ? "${formControl.value}" : null,
            maxLines:
                formControl.type == FormBuilderInput.TYPE_MULTILINE_TEXT ? 5 : 1,
            keyboardType: formControl.type == FormBuilderInput.TYPE_NUMBER
                ? TextInputType.number
                : TextInputType.text,
            obscureText: formControl.type == FormBuilderInput.TYPE_PASSWORD
                ? true
                : false,
            onSaved: (value) {
              formData[formControl.attribute] = formControl.type == FormBuilderInput.TYPE_NUMBER ? num.tryParse(value) : value;;
            },
            validator: (value) {
              if (formControl.require && value.isEmpty)
                return "This field is required";

              if (formControl.type == FormBuilderInput.TYPE_NUMBER &&
                  num.tryParse(value) == null &&
                  value.isNotEmpty) return "$value is not a valid number";

              if (formControl.type == FormBuilderInput.TYPE_EMAIL &&
                  value.isNotEmpty) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                if (!RegExp(pattern).hasMatch(value))
                  return 'Please enter a valid email address';
              }

              if (formControl.type == FormBuilderInput.TYPE_URL &&
                  value.isNotEmpty) {
                Pattern pattern =
                    r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                if (!RegExp(pattern, caseSensitive: false).hasMatch(value))
                  return 'Please enter a valid URL link';
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
                return "This field is required";
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
                      hint: Text(formControl.placeholder ?? ''),
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

        case FormBuilderInput.TYPE_RADIO:
          formControlsList.add(FormField(
              initialValue: formControl.value,
              onSaved: (value) {
                formData[formControl.attribute] = value;
              },
              validator: (value) {
                if (formControl.require && value == null)
                  return "This field is required";
                if (formControl.validator != null)
                  return formControl.validator(value);
              },
              builder: (FormFieldState<dynamic> field) {
                List<Widget> radioList = [];
                for (int i = 0; i < formControls[count].options.length; i++) {
                  radioList.add(Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(formControls[count].options[i].label ??
                            formControls[count].options[i].value),
                      ),
                      Radio<dynamic>(
                        value: formControls[count].options[i].value,
                        groupValue: formControls[count].value,
                        onChanged: (dynamic value) {
                          setState(() {
                            formControls[count].value = value;
                          });
                          field.didChange(value);
                        },
                      ),
                    ],
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
                    ],
                  ),
                );
              }));
          break;

        case FormBuilderInput.TYPE_SWITCH:
          formControlsList.add(FormField(
              initialValue: formControl.value,
              validator: (value) {
                if (formControl.require && value == null)
                  return "This field is required";
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

        case FormBuilderInput.TYPE_CHECKBOX:
          formControlsList.add(FormField(
              initialValue: formControl.value,
              validator: (value) {
                if (formControl.require && value == null)
                  return "This field is required";
                if (formControl.validator != null)
                  return formControl.validator(value);
              },
              onSaved: (value) {
                formData[formControl.attribute] = value;
              },
              builder: (FormFieldState<dynamic> field) {
                return Column(children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          formControl.label,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Checkbox(
                          value: formControl.value ?? false,
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

        case FormBuilderInput.TYPE_SLIDER:
          formControlsList.add(FormField(
              initialValue: formControl.value,
              validator: (value) {
                if (formControl.require && (value.isEmpty || value == null))
                  return "This field is required";
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
                  checkboxList.add(Row(
                    children: <Widget>[
                      Checkbox(
                        value: formControls[count].options[i].value,
                        onChanged: (bool value) {
                          setState(() {
                            formControls[count].options[i].value = value;
                          });
                          List<dynamic> chosenItems = formControls[count]
                              .options
                              .where((option) => option.value == true)
                              .map((option) => option.label)
                              .toList();
                          field.didChange(chosenItems);
                        },
                      ),
                      Expanded(
                        child: Text(formControls[count].options[i].label),
                      ),
                    ],
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
                    ],
                  ),
                );
              }));
          break;
      }
    }

    formControlsList.add(Container(
      margin: EdgeInsets.only(top: 10.0),
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
            String selectedDateFormatted =
                DateFormat('yyyy-MM-dd').format(selectedDate);
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
              return "This field is required";
            if (formControl.validator != null)
              return formControl.validator(value);
          },
          controller: _inputController,
          decoration: InputDecoration(
            labelText: formControl.label,
            hintText: formControl.placeholder ?? "",
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
          // initialTime: new Tim, //FIXME: Parse time from string
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
              return "This field is required";
            if (formControl.validator != null)
              return formControl.validator(value);
          },
          decoration: InputDecoration(
            labelText: formControl.label,
            hintText: formControl.placeholder ?? "",
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
