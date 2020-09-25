import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        // brightness: Brightness.dark,
        inputDecorationTheme: const InputDecorationTheme(
          // labelStyle: TextStyle(color: Colors.purple),
          border: OutlineInputBorder(gapPadding: 10),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // locale: Locale('ru'),
      supportedLocales: [
        Locale('en', 'GB'),
        Locale('en', 'US'),
        Locale('es', ''),
        Locale('ru'),
      ],
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

  final ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];
  final _ageController = TextEditingController(text: '45');
  bool _ageHasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormBuilder Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            FormBuilder(
              // context,
              key: _fbKey,
              // autovalidate: true,
              initialValue: {
                'movie_rating': 3,
                'filter_chip': ['Test', 'Test 1'],
                'date': DateTime.now(),
              },
              readOnly: false,
              child: Column(
                children: <Widget>[
                  FormBuilderFilterChip(
                    attribute: 'filter_chip',
                    decoration: const InputDecoration(labelText: 'Filter Chip'),
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
                  SizedBox(height: 15),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: const InputDecoration(
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
                  SizedBox(height: 15),
                  SizedBox(height: 15),
                  FormBuilderColorPicker(
                    attribute: 'color_picker',
                    // initialValue: Colors.yellow,
                    colorPickerType: ColorPickerType.BlockPicker,
                    decoration: const InputDecoration(labelText: 'Pick Color'),
                  ),
                  SizedBox(height: 15),
                  FormBuilderChipsInput(
                    decoration: const InputDecoration(labelText: 'Chips'),
                    attribute: 'chips_test',
                    onChanged: _onChanged,
                    initialValue: [
                      Contact('Andrew', 'stock@man.com',
                          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                    ],
                    maxChips: 5,
                    findSuggestions: (String query) {
                      if (query.isNotEmpty) {
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
                  SizedBox(height: 15),
                  FormBuilderDateTimePicker(
                    attribute: 'date',
                    onChanged: _onChanged,
                    inputType: InputType.both,
                    decoration: const InputDecoration(
                      labelText: 'Appointment Time',
                    ),
                    validator: (val) => null,
                    // locale: Locale('ru'),
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    // initialValue: DateTime.now(),
                    // readonly: true,
                  ),
                  SizedBox(height: 15),
                  FormBuilderDateRangePicker(
                    attribute: 'date_range',
                    firstDate: DateTime(1970),
                    lastDate: DateTime.now(),
                    initialValue: [
                      DateTime.now().subtract(Duration(days: 30)),
                      DateTime.now().subtract(Duration(seconds: 10))
                    ],
                    format: DateFormat('yyyy-MM-dd'),
                    onChanged: _onChanged,
                    decoration: const InputDecoration(
                      labelText: 'Date Range',
                      helperText: 'Helper text',
                      hintText: 'Hint text',
                    ),
                  ),
                  SizedBox(height: 15),
                  FormBuilderSlider(
                    attribute: 'slider',
                    validators: [FormBuilderValidators.min(6)],
                    onChanged: _onChanged,
                    min: 0.0,
                    max: 10.0,
                    initialValue: 7.0,
                    divisions: 20,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: const InputDecoration(
                      labelText: 'Number of things',
                    ),
                    displayValues: DisplayValues.current,
                  ),
                  SizedBox(height: 15),
                  FormBuilderRangeSlider(
                    attribute: 'range_slider',
                    validators: [FormBuilderValidators.min(6)],
                    onChanged: _onChanged,
                    min: 0.0,
                    max: 100.0,
                    initialValue: RangeValues(4, 7),
                    divisions: 20,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: const InputDecoration(
                      labelText: 'Price Range',
                    ),
                    displayValues: DisplayValues.minMax,
                  ),
                  SizedBox(height: 15),
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
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('launch url');
                              },
                          ),
                        ],
                      ),
                    ),
                    validators: [
                      FormBuilderValidators.requiredTrue(
                        errorText:
                            'You must accept terms and conditions to continue',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  FormBuilderTextField(
                    attribute: 'age',
                    // autovalidate: true,
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      suffixIcon: _ageHasError
                          ? Icon(Icons.error, color: Colors.red)
                          : Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      print(val);
                      setState(() {
                        _ageHasError = !_fbKey
                            .currentState.fields['age'].currentState
                            .validate();
                      });
                    },
                    valueTransformer: (text) {
                      return text == null ? null : num.tryParse(text);
                    },
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 15),
                  FormBuilderDropdown(
                    attribute: 'gender',
                    decoration: const InputDecoration(
                      labelText: 'Gender',
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
                    // isExpanded: false,
                    allowClear: true,
                  ),
                  SizedBox(height: 15),
                  FormBuilderTypeAhead(
                    decoration: const InputDecoration(
                      labelText: 'Country',
                    ),
                    attribute: 'country',
                    onChanged: _onChanged,
                    itemBuilder: (context, country) {
                      return ListTile(
                        title: Text(country),
                      );
                    },
                    controller: TextEditingController(text: ''),
                    initialValue: 'Kenya',
                    suggestionsCallback: (query) {
                      if (query.isNotEmpty) {
                        var lowercaseQuery = query.toLowerCase();
                        return allCountries.where((country) {
                          return country.toLowerCase().contains(lowercaseQuery);
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
                  SizedBox(height: 15),
                  FormBuilderTypeAhead<Contact>(
                    decoration: const InputDecoration(
                      labelText: 'Contact Person',
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
                      if (query.isNotEmpty) {
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
                  SizedBox(height: 15),
                  FormBuilderRadioGroup(
                    orientation: GroupedRadioOrientation.wrap,
                    decoration:
                        InputDecoration(labelText: 'My chosen language'),
                    attribute: 'best_language',
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: [
                      'Dart',
                      'Kotlin',
                      'Java',
                      'Swift',
                      'Objective-C',
                      'A Very long text that would overflow to the next line and crash'
                    ]
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  SizedBox(height: 15),
                  SizedBox(height: 15),
                  FormBuilderSegmentedControl(
                    decoration:
                        InputDecoration(labelText: 'Movie Rating (Archer)'),
                    attribute: 'movie_rating',
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    options: List.generate(5, (i) => i + 1)
                        .map((number) => FormBuilderFieldOption(
                              value: number,
                              child: Text(
                                '$number',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                    onChanged: _onChanged,
                  ),
                  SizedBox(height: 15),
                  FormBuilderSwitch(
                    label: Text('I Accept the tems and conditions'),
                    attribute: 'accept_terms_switch',
                    initialValue: true,
                    onChanged: _onChanged,
                  ),
                  SizedBox(height: 15),
                  FormBuilderTouchSpin(
                    decoration: const InputDecoration(labelText: 'Stepper'),
                    attribute: 'stepper',
                    initialValue: 10,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: const Icon(Icons.arrow_right),
                    subtractIcon: const Icon(Icons.arrow_left),
                  ),
                  SizedBox(height: 15),
                  FormBuilderRate(
                    decoration:
                        const InputDecoration(labelText: 'Rate this form'),
                    attribute: 'rate',
                    iconSize: 32.0,
                    initialValue: 1.0,
                    max: 5.0,
                    onChanged: _onChanged,
                    // readOnly: true,
                    filledColor: Colors.red,
                    emptyColor: Colors.pink[100],
                    isHalfAllowed: true,
                  ),
                  SizedBox(height: 15),
                  FormBuilderCheckboxGroup(
                    decoration:
                        InputDecoration(labelText: 'The language of my people'),
                    attribute: 'languages',
                    initialValue: ['Dart'],
                    options: [
                      FormBuilderFieldOption(value: 'Dart'),
                      FormBuilderFieldOption(value: 'Kotlin'),
                      FormBuilderFieldOption(value: 'Java'),
                      FormBuilderFieldOption(value: 'Swift'),
                      FormBuilderFieldOption(value: 'Objective-C'),
                    ],
                    onChanged: _onChanged,
                  ),
                  SizedBox(height: 15),
                  FormBuilderImagePicker(
                    attribute: 'images',
                    decoration: const InputDecoration(
                      labelText: 'Images',
                    ),
                    defaultImage: NetworkImage(
                        'https://cohenwoodworking.com/wp-content/uploads/2016/09/image-placeholder-500x500.jpg'),
                    maxImages: 3,
                    iconColor: Colors.red,
                    // readOnly: true,
                    validators: [
                      FormBuilderValidators.required(),
                      (images) {
                        if (images.length < 2) {
                          return 'Two or more images required.';
                        }
                        return null;
                      }
                    ],
                    onChanged: _onChanged,
                  ),
                  SizedBox(height: 15),
                  FormBuilderCountryPicker(
                    // initialValue: 'Germany',
                    attribute: 'country',
                    // readOnly: true,
                    // style: TextStyle(color: Colors.black, fontSize: 18),
                    priorityListByIsoCode: ['US'],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Country',
                    ),
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'This field required.'),
                    ],
                  ),
                  SizedBox(height: 15),
                  FormBuilderPhoneField(
                    attribute: 'phone_number',
                    initialValue: '+25443534543567',
                    // defaultSelectedCountryIsoCode: 'KE',
                    cursorColor: Colors.black,
                    // style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    onChanged: _onChanged,
                    priorityListByIsoCode: ['US'],
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'This field required')
                    ],
                  ),
                  SizedBox(height: 15),
                  FormBuilderSignaturePad(
                    initialValue: sampleSignature,
                    decoration: const InputDecoration(labelText: 'Signature'),
                    attribute: 'signature',
                    // height: 250,
                    clearButtonText: 'Start Over',
                    onChanged: _onChanged,
                  ),
                  SizedBox(height: 15),
                  FormBuilderRadioGroup(
                    attribute: 'radio_group',
                    decoration: const InputDecoration(labelText: 'Radio Group'),
                    onChanged: _onChanged,
                    options: [
                      FormBuilderFieldOption(value: 'M', child: Text('Male')),
                      FormBuilderFieldOption(value: 'F', child: Text('Female')),
                    ],
                  ),
                  SizedBox(height: 15),
                  FormBuilderCustomField(
                    attribute: 'name',
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    initialValue: 'Argentina',
                    formField: FormField(
                      enabled: true,
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'FormBuilderCustomField',
                            contentPadding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 0.0,
                            ),
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
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey.currentState.value);
                      } else {
                        print(_fbKey.currentState.value);
                        print('validation failed');
                      }
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                    child: MaterialButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'Reset',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _fbKey.currentState.reset();
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
