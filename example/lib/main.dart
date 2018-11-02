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
              hint: "Select Option",
              options: [
                FormBuilderInputOption(value: "Option 1"),
                FormBuilderInputOption(value: "Option 2"),
                FormBuilderInputOption(value: "Option 3"),
              ],
            ),
            FormBuilderInput.number(
              attribute: "age",
              label: "Age",
              require: true,
              min: 18,
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
            FormBuilderInput.slider(
              label: "Slider",
              attribute: "slider",
              hint: "Hint",
              min: 0.0,
              require: true,
              max: 100.0,
              value: 10.0,
              divisions: 20,
            ),
            FormBuilderInput.stepper(
              label: "Stepper",
              attribute: "stepper",
              value: 10,
              step: 1,
              hint: "Hint",
            ),
            FormBuilderInput.rate(
              label: "Rate",
              attribute: "rate",
              iconSize: 48.0,
              value: 1,
              max: 5,
              hint: "Hint",
            ),
            FormBuilderInput.segmentedControl(
                label: "Movie Rating (Archer)",
                attribute: "movie_rating",
                require: true,
                options: [
                  FormBuilderInputOption(value: 1,),
                  FormBuilderInputOption(value: 2,),
                  FormBuilderInputOption(value: 3,),
                  FormBuilderInputOption(value: 4,),
                  FormBuilderInputOption(value: 5,),
                  FormBuilderInputOption(value: 6,),
                  FormBuilderInputOption(value: 7,),
                  FormBuilderInputOption(value: 8,),
                  FormBuilderInputOption(value: 9,),
                  FormBuilderInputOption(value: 10,),
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
