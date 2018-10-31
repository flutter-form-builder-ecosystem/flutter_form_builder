# Flutter FormBuilder - flutter_form_builder

This widget helps in generation of forms in [Flutter](https://flutter.io/)


## Usage
To use this plugin, add `flutter_form_builder` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).


### Example

```
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter FormBuilder Example'),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: FormBuilder(
          context,
          autovalidate: true,
          controls: [
            FormBuilderInput.dropdown(
              attribute: "dropdown",
              require: true,
              label: "Dropdown",
              placeholder: "Select Option",
              options: [
                FormBuilderInputOption(value: "Option 1"),
                FormBuilderInputOption(value: "Option 2"),
                FormBuilderInputOption(value: "Option 3"),
              ],
            ),
            FormBuilderInput(
              type: FormBuilderInput.TYPE_NUMBER,
              attribute: "age",
              label: "Age",
              require: true,
            ),
            FormBuilderInput(
              type: FormBuilderInput.TYPE_EMAIL,
              attribute: "email",
              label: "Email",
              require: true,
            ),
            FormBuilderInput(
              type: FormBuilderInput.TYPE_URL,
              attribute: "url",
              label: "URL",
              require: true,
            ),
            FormBuilderInput.datePicker(
              label: "Date of Birth",
              attribute: "dob",
            ),
            FormBuilderInput.timePicker(
              label: "Appointment Time",
              attribute: "time",
            ),
            FormBuilderInput.checkboxList(
                label: "My Languages",
                attribute: "languages",
                require: false,
                options: [
                  FormBuilderInputOption(label: "Dart", value: false),
                  FormBuilderInputOption(label: "Kotlin", value: false),
                  FormBuilderInputOption(label: "Java", value: false),
                  FormBuilderInputOption(label: "Swift", value: false),
                  FormBuilderInputOption(label: "Objective-C", value: false),
                ]),
            FormBuilderInput.radio(
                label: "My Best Language",
                attribute: "best_language",
                require: true,
                options: [
                  FormBuilderInputOption(value: "Dart"),
                  FormBuilderInputOption(value: "Kotlin"),
                  FormBuilderInputOption(value: "Java"),
                  FormBuilderInputOption(value: "Swift"),
                  FormBuilderInputOption(value: "Objective-C"),
                ]),
          ],
          onChanged: () {
            print("Form Changed");
          },
          onSubmit: (formValue) {
            if (formValue != null) {
              print(formValue);
            } else {
              print("Form invalid");
            }
          },
        ),
      ),
    );
  }
}
```

## TODO: 
* Improve documentation
* Add new `FormBuilderInput` types

