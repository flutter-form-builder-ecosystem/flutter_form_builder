import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import './data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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
        title: Text("FormBuilder Example"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                context,
                key: _fbKey,
                autovalidate: true,
                readonly: true,
                child: Column(
                  children: <Widget>[
                    FormBuilderField(
                      attribute: "name",
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                      formField: FormField(
                        // key: _fieldKey,
                        enabled: true,
                        builder: (FormFieldState<dynamic> field) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: "Select option",
                              contentPadding:
                                  EdgeInsets.only(top: 10.0, bottom: 0.0),
                              border: InputBorder.none,
                            ),
                            child: DropdownButton(
                              isExpanded: true,
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
                    FormBuilderChipsInput(
                      decoration: InputDecoration(labelText: "Chips"),
                      attribute: 'chips_test',
                      readonly: true,
                      initialValue: [
                        Contact('Andrew', 'stock@man.com',
                            'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                      ],
                      maxChips: 5,
                      findSuggestions: (String query) {
                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();
                          return mockResults.where((profile) {
                            return profile.name
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                                profile.email
                                    .toLowerCase()
                                    .contains(query.toLowerCase());
                          }).toList(growable: false)
                            ..sort((a, b) => a.name
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(b.name
                                .toLowerCase()
                                .indexOf(lowercaseQuery)));
                        } else {
                          return const <Contact>[];
                        }
                      },
                      chipBuilder: (context, state, profile) {
                        return InputChip(
                          key: ObjectKey(profile),
                          label: Text(profile.name),
                          avatar: CircleAvatar(
                            backgroundImage: NetworkImage(profile.imageUrl),
                          ),
                          onDeleted: () => state.deleteChip(profile),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        );
                      },
                      suggestionBuilder: (context, state, profile) {
                        return ListTile(
                          key: ObjectKey(profile),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(profile.imageUrl),
                          ),
                          title: Text(profile.name),
                          subtitle: Text(profile.email),
                          onTap: () => state.selectSuggestion(profile),
                        );
                      },
                    ),
                    FormBuilderDateTimePicker(
                      attribute: "date",
                      inputType: InputType.date,
                      format: DateFormat("yyyy-MM-dd"),
                      decoration:
                          InputDecoration(labelText: "Appointment Time"),
                      readonly: true,
                    ),
                    FormBuilderSlider(
                      attribute: "slider",
                      validators: [FormBuilderValidators.min(6)],
                      min: 0.0,
                      max: 10.0,
                      initialValue: 1.0,
                      divisions: 20,
                      decoration:
                          InputDecoration(labelText: "Number of somethings"),
                    ),
                    FormBuilderCheckbox(
                      attribute: 'accept_terms',
                      initialValue: false,
                      label: Text(
                          "I have read and agree to the terms and conditions"),
                      validators: [
                        FormBuilderValidators.requiredTrue(
                          errorMessage:
                              "You must accept terms and conditions to continue",
                        ),
                      ],
                    ),
                    FormBuilderDropdown(
                      attribute: "gender",
                      decoration: InputDecoration(labelText: "Gender"),
                      // initialValue: 'Male',
                      hint: Text('Select Gender'),
                      validators: [FormBuilderValidators.required()],
                      items: [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Other'),
                        ),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "age",
                      decoration: InputDecoration(labelText: "Age"),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(70)
                      ],
                    ),
                    FormBuilderTypeAhead(
                      decoration: InputDecoration(labelText: "Country"),
                      attribute: 'country',
                      itemBuilder: (context, country) {
                        return ListTile(
                          title: Text(country),
                        );
                      },
                      suggestionsCallback: (query) {
                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();
                          return allCountries.where((country) {
                            return country
                                .toLowerCase()
                                .contains(lowercaseQuery);
                          }).toList(growable: false)
                            ..sort((a, b) => a
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(
                                    b.toLowerCase().indexOf(lowercaseQuery)));
                        } else {
                          return allCountries;
                        }
                      },
                    ),
                    FormBuilderRadio(
                      decoration:
                          InputDecoration(labelText: 'My chosen language'),
                      attribute: "best_language",
                      validators: [FormBuilderValidators.required()],
                      options: [
                        "Dart",
                        "Kotlin",
                        "Java",
                        "Swift",
                        "Objective-C"
                      ]
                          .map((lang) => FormBuilderInputOption(value: lang))
                          .toList(growable: false),
                    ),
                    FormBuilderSegmentedControl(
                      decoration:
                          InputDecoration(labelText: "Movie Rating (Archer)"),
                      attribute: "movie_rating",
                      options: List.generate(5, (i) => i + 1)
                          .map(
                              (number) => FormBuilderInputOption(value: number))
                          .toList(),
                    ),
                    FormBuilderSwitch(
                      label: Text('I Accept the tems and conditions'),
                      attribute: "accept_terms_switch",
                      initialValue: true,
                    ),
                    FormBuilderStepper(
                      decoration: InputDecoration(labelText: "Stepper"),
                      attribute: "stepper",
                      initialValue: 10,
                      step: 1,
                    ),
                    FormBuilderRate(
                      decoration: InputDecoration(labelText: "Rate this form"),
                      attribute: "rate",
                      iconSize: 32.0,
                      initialValue: 1,
                      max: 5,
                    ),
                    FormBuilderCheckboxList(
                      decoration:
                      InputDecoration(labelText: "The language of my people"),
                      attribute: "languages",
                      initialValue: ["Dart"],
                      options: [
                        FormBuilderInputOption(value: "Dart"),
                        FormBuilderInputOption(value: "Kotlin"),
                        FormBuilderInputOption(value: "Java"),
                        FormBuilderInputOption(value: "Swift"),
                        FormBuilderInputOption(value: "Objective-C"),
                      ],
                    ),
                    FormBuilderSignaturePad(
                      decoration: InputDecoration(labelText: "Signature"),
                      attribute: "signature",
                      height: 100,
                    ),
                  ],
                ),
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
