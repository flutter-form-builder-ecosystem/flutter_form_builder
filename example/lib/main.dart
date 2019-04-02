import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter FormBuilder Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                context,
                key: _fbKey,
                controls: [
                  FormBuilderField(
                    attribute: "name",
                    formField: FormField(
                      // key: _fieldKey,
                      enabled: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                      },
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            errorText: field.errorText,
                            contentPadding:
                                EdgeInsets.only(top: 10.0, bottom: 0.0),
                            border: InputBorder.none,
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            // hint: Text(formControl.hint ?? ''), //TODO: Dropdown may require hint
                            items: ["One", "Two"].map((option) {
                              return DropdownMenuItem(
                                child: Text("$option"),
                                value: option,
                              );
                            }).toList(),
                            value: field.value,
                            onChanged: (value) {
                              field.didChange(value);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  FormBuilderGroup(
                    header: Container(
                      child: Text("Header"),
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                    collapsible: false,
                    children: [
                      FormBuilderField(
                        attribute: "second_attribute",
                        validators: [
                          FormBuilderValidators.required(errorMessage: "Kindly enter something here"),
                        ],
                        formField: FormField(
                          // key: _fieldKey,
                          enabled: false,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Choose Something",
                                errorText: field.errorText,
                                contentPadding:
                                    EdgeInsets.only(top: 10.0, bottom: 0.0),
                                border: InputBorder.none,
                              ),
                              child: DropdownButton(
                                isExpanded: true,
                                // hint: Text(formControl.hint ?? ''), //TODO: Dropdown may require hint
                                items: ["One", "Two"].map((option) {
                                  return DropdownMenuItem(
                                    child: Text("$option"),
                                    value: option,
                                  );
                                }).toList(),
                                value: field.value,
                                onChanged: (value) {
                                  field.didChange(value);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text("Submit"),
                    onPressed: () {
                      _fbKey.currentState.save();
                      if (_fbKey.currentState.validate()) {
                        print(_fbKey.currentState.value);
                      }
                    },
                  ),
                  MaterialButton(
                    child: Text("Reset"),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
