import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          // labelStyle: TextStyle(color: Colors.purple),
          border: OutlineInputBorder(
            gapPadding: 10,
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
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
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
      GlobalKey<FormFieldState>();

  ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FormBuilder Example"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(

          children: <Widget>[
            FormBuilder(
              // context,
              key: _fbKey,
              // autovalidate: true,
              initialValue: {
                'movie_rating': 3,
              },
              readOnly: false,
              child: Column(
                children: <Widget>[
                  FormBuilderFilterChip(
                    attribute: 'filter_chip',
                    decoration: InputDecoration(
                      labelText: 'Select many options',
                    ),
                    options: [
                      FormBuilderFieldOption(
                          value: 'Test', child: Text('Test')),
                      FormBuilderFieldOption(
                          value: 'Test 1', child: Text('Test 1')),
                      FormBuilderFieldOption(
                          value: 'Test 2', child: Text('Test 2')),
                      FormBuilderFieldOption(
                          value: 'Test 3', child: Text('Test 3')),
                      FormBuilderFieldOption(
                          value: 'Test 4', child: Text('Test 4')),
                    ],
                  ),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      labelText: 'Select an option',
                    ),
                    options: [
                      FormBuilderFieldOption(
                          value: 'Test', child: Text('Test')),
                      FormBuilderFieldOption(
                          value: 'Test 1', child: Text('Test 1')),
                      FormBuilderFieldOption(
                          value: 'Test 2', child: Text('Test 2')),
                      FormBuilderFieldOption(
                          value: 'Test 3', child: Text('Test 3')),
                      FormBuilderFieldOption(
                          value: 'Test 4', child: Text('Test 4')),
                    ],
                  ),
                  FormBuilderCustomField(
                    attribute: "name",
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    initialValue: "Argentina",
                    formField: FormField(
                      enabled: true,
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Select option",
                            contentPadding:
                                EdgeInsets.only(top: 10.0, bottom: 0.0),
                            border: InputBorder.none,
                            errorText: field.errorText,
                          ),
                          child: Container(
                            height: 200,
                            child: CupertinoPicker(
                              itemExtent: 30,
                              children:
                                  allCountries.map((c) => Text(c)).toList(),
                              onSelectedItemChanged: (index) {
                                print(index);
                                field.didChange(allCountries[index]);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  FormBuilderColorPicker(
                    attribute: 'color_picker',
                    // initialValue: Colors.yellow,
                    colorPickerType: ColorPickerType.SlidePicker,
                    decoration: InputDecoration(labelText: "Pick Color"),
                  ),
                  FormBuilderChipsInput(
                    decoration: InputDecoration(labelText: "Chips"),
                    attribute: 'chips_test',
                    onChanged: _onChanged,
                    initialValue: [
                      Contact('Andrew', 'stock@man.com',
                          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                    ],
                    maxChips: 5,
                    findSuggestions: (String query) {
                      if (query.length != 0) {
                        var lowercaseQuery = query.toLowerCase();
                        return contacts.where((profile) {
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
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
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
                    onChanged: _onChanged,
                    inputType: InputType.time,
                    decoration: InputDecoration(
                      labelText: "Appointment Time",
                    ),
                    validator: (val) => null,
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    // initialValue: DateTime.now(),
                    // readonly: true,
                  ),
                  FormBuilderDateRangePicker(
                    attribute: "date_range",
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2030),
                    format: DateFormat("yyyy-MM-dd"),
                    onChanged: _onChanged,
                    decoration: InputDecoration(
                      labelText: "Date Range",
                      helperText: "Helper text",
                      hintText: "Hint text",
                    ),
                  ),
                  FormBuilderSlider(
                    attribute: "slider",
                    validators: [FormBuilderValidators.min(6)],
                    onChanged: _onChanged,
                    min: 0.0,
                    max: 10.0,
                    initialValue: 7.0,
                    divisions: 20,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: InputDecoration(
                      labelText: "Number of things",
                    ),
                  ),
                  FormBuilderRangeSlider(
                    attribute: "range_slider",
                    validators: [FormBuilderValidators.min(6)],
                    onChanged: _onChanged,
                    min: 0.0,
                    max: 100.0,
                    initialValue: RangeValues(4, 7),
                    divisions: 20,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: InputDecoration(
                      labelText: "Price Range",
                    ),
                  ),
                  FormBuilderCheckbox(
                    attribute: 'accept_terms',
                    initialValue: false,
                    onChanged: _onChanged,
                    leadingInput: true,
                    label: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I have read and agree to the ',
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("launch url");
                              },
                          ),
                        ],
                      ),
                    ),
                    validators: [
                      FormBuilderValidators.requiredTrue(
                        errorText:
                            "You must accept terms and conditions to continue",
                      ),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "age",
                    decoration: InputDecoration(
                      labelText:
                          "This value is passed along to the [Text.maxLines] attribute of the [Text] widget used to display the hint text.",
                    ),
                    onChanged: _onChanged,
                    valueTransformer: (text) {
                      return text == null ? null : num.tryParse(text);
                    },
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      // FormBuilderValidators.max(70),
                      FormBuilderValidators.minLength(2, allowEmpty: true),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderDropdown(
                    attribute: "gender",
                    decoration: InputDecoration(
                      labelText: "Gender",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 20,
                        ),
                      ),
                    ),
                    // initialValue: 'Male',
                    hint: Text('Select Gender'),
                    validators: [FormBuilderValidators.required()],
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text('$gender'),
                            ))
                        .toList(),
                  ),
                  FormBuilderTypeAhead(
                    decoration: InputDecoration(
                      labelText: "Country",
                    ),
                    attribute: 'country',
                    onChanged: _onChanged,
                    itemBuilder: (context, country) {
                      return ListTile(
                        title: Text(country),
                      );
                    },
                    controller: TextEditingController(text: ''),
                    initialValue: "Uganda",
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
                  FormBuilderTypeAhead<Contact>(
                    decoration: InputDecoration(
                      labelText: "Contact Person",
                    ),
                    initialValue: contacts[0],
                    attribute: 'contact_person',
                    onChanged: _onChanged,
                    itemBuilder: (context, Contact contact) {
                      return ListTile(
                        title: Text(contact.name),
                        subtitle: Text(contact.email),
                      );
                    },
                    selectionToTextTransformer: (Contact c) => c.email,
                    suggestionsCallback: (query) {
                      if (query.length != 0) {
                        var lowercaseQuery = query.toLowerCase();
                        return contacts.where((contact) {
                          return contact.name
                              .toLowerCase()
                              .contains(lowercaseQuery);
                        }).toList(growable: false)
                          ..sort((a, b) => a.name
                              .toLowerCase()
                              .indexOf(lowercaseQuery)
                              .compareTo(b.name
                                  .toLowerCase()
                                  .indexOf(lowercaseQuery)));
                      } else {
                        return contacts;
                      }
                    },
                  ),
                  FormBuilderRadio(
                    decoration:
                        InputDecoration(labelText: 'My chosen language'),
                    attribute: "best_language",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options:
                        ["Dart", "Kotlin", "Java", "Swift", "Objective-C"]
                            .map((lang) => FormBuilderFieldOption(
                                  value: lang,
                                  child: Text('$lang'),
                                ))
                            .toList(growable: false),
                  ),
                  FormBuilderRadio(
                    decoration: InputDecoration(labelText: 'Pick a number'),
                    attribute: "number",
                    options: [
                      FormBuilderFieldOption(
                        value: 1,
                        child: Text('One'),
                      ),
                      FormBuilderFieldOption(
                        value: 2,
                        child: Text('Two'),
                      ),
                      FormBuilderFieldOption(
                        value: 3,
                        child: Text('Three'),
                      ),
                    ],
                  ),
                  FormBuilderSegmentedControl(
                    decoration:
                        InputDecoration(labelText: "Movie Rating (Archer)"),
                    attribute: "movie_rating",
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    options: List.generate(5, (i) => i + 1)
                        .map((number) => FormBuilderFieldOption(
                              value: number,
                              child: Text(
                                "$number",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                    onChanged: _onChanged,
                  ),
                  FormBuilderSwitch(
                    label: Text('I Accept the tems and conditions'),
                    attribute: "accept_terms_switch",
                    initialValue: true,
                    onChanged: _onChanged,
                  ),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Stepper"),
                    attribute: "stepper",
                    initialValue: 10,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.arrow_right),
                    subtractIcon: Icon(Icons.arrow_left),
                  ),
                  FormBuilderRate(
                    decoration: InputDecoration(labelText: "Rate this form"),
                    attribute: "rate",
                    iconSize: 32.0,
                    initialValue: 1.0,
                    max: 5.0,
                    onChanged: _onChanged,
                    // readOnly: true,
                    filledColor: Colors.red,
                    emptyColor: Colors.pink[100],
                    isHalfAllowed: true,
                  ),
                  FormBuilderCheckboxList(
                    decoration: InputDecoration(
                        labelText: "The language of my people"),
                    attribute: "languages",
                    initialValue: ["Dart"],
                    leadingInput: true,
                    options: [
                      FormBuilderFieldOption(value: "Dart"),
                      FormBuilderFieldOption(value: "Kotlin"),
                      FormBuilderFieldOption(value: "Java"),
                      FormBuilderFieldOption(value: "Swift"),
                      FormBuilderFieldOption(value: "Objective-C"),
                    ],
                    onChanged: _onChanged,
                  ),
                  FormBuilderCustomField(
                    attribute: 'custom',
                    valueTransformer: (val) {
                      if (val == "Other")
                        return _specifyTextFieldKey.currentState.value;
                      return val;
                    },
                    formField: FormField(
                      builder: (FormFieldState<String> field) {
                        var languages = [
                          "English",
                          "Spanish",
                          "Somali",
                          "Other"
                        ];
                        return InputDecorator(
                          decoration: InputDecoration(
                              labelText: "What's your preferred language?"),
                          child: Column(
                            children: languages
                                .map(
                                  (lang) => Row(
                                    children: <Widget>[
                                      Radio<dynamic>(
                                        value: lang,
                                        groupValue: field.value,
                                        onChanged: (dynamic value) {
                                          field.didChange(lang);
                                        },
                                      ),
                                      lang != "Other"
                                          ? Text(lang)
                                          : Expanded(
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    lang,
                                                  ),
                                                  SizedBox(width: 20),
                                                  Expanded(
                                                    child: TextFormField(
                                                      key:
                                                          _specifyTextFieldKey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                )
                                .toList(growable: false),
                          ),
                        );
                      },
                    ),
                  ),
                  FormBuilderImagePicker(
                    attribute: "images",
                    decoration: InputDecoration(
                      labelText: "Images",
                    ),
                    iconColor: Colors.red,
                    // readOnly: true,
                    validators: [
                      FormBuilderValidators.required(),
                      (images) {
                        if (images.length < 2) {
                          return "Two or more images required.";
                        }
                        return null;
                      }
                    ],
                  ),
                  FormBuilderSignaturePad(
                    decoration: InputDecoration(labelText: "Signature"),
                    attribute: "signature",
                    // height: 250,
                    clearButtonText: "Start Over",
                    onChanged: _onChanged,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey.currentState.value['contact_person'].runtimeType);
                        print(_fbKey.currentState.value);
                      } else {
                        print(_fbKey.currentState.value['contact_person'].runtimeType);
                        print(_fbKey.currentState.value);
                        print("validation failed");
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
