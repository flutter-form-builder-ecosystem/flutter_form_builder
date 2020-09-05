import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../data.dart';

class CompleteForm extends StatefulWidget {
  @override
  CompleteFormState createState() {
    return CompleteFormState();
  }
}

class CompleteFormState extends State<CompleteForm> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _genderHasError = false;

  final ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    print('Rebuilding...............');
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              autovalidate: true,
              initialValue: {
                'movie_rating': 5,
                'best_language': 'Dart',
                'age': '13',
                'gender': 'Male'
              },
              readOnly: false,
              child: Column(
                children: <Widget>[
                  FormBuilderSearchableDropdown(
                    name: 'searchable_dropdown',
                    items: allCountries,
                    onChanged: _onChanged,
                  ),
                  FormBuilderLocationField(
                    name: 'location',
                    decoration: InputDecoration(labelText: 'Location'),
                  ),
                  SizedBox(height: 15),
                  FormBuilderFilterChip(
                    name: 'filter_chip',
                    decoration: const InputDecoration(
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
                    name: 'choice_chip',
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
                  FormBuilderColorPickerField(
                    name: 'color_picker',
                    // initialValue: Colors.yellow,
                    colorPickerType: ColorPickerType.MaterialPicker,
                    decoration: const InputDecoration(labelText: 'Pick Color'),
                  ),
                  FormBuilderChipsInput(
                    decoration: const InputDecoration(labelText: 'Chips'),
                    name: 'chips_test',
                    onChanged: _onChanged,
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
                  FormBuilderDateTimePicker(
                    name: 'date',
                    initialValue: DateTime.now(),
                    inputType: InputType.time,
                    decoration: const InputDecoration(
                      labelText: 'Appointment Time',
                    ),
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    pickerType: PickerType.cupertino,
                  ),
                  FormBuilderDateRangePicker(
                    name: 'date_range',
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2030),
                    format: DateFormat('yyyy-MM-dd'),
                    onChanged: _onChanged,
                    decoration: const InputDecoration(
                      labelText: 'Date Range',
                      helperText: 'Helper text',
                      hintText: 'Hint text',
                    ),
                  ),
                  FormBuilderSlider(
                    name: 'slider',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.min(context, 6),
                    ]),
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
                  ),
                  FormBuilderRangeSlider(
                    name: 'range_slider',
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.min(context, 6)]),
                    onChanged: _onChanged,
                    min: 0.0,
                    max: 100.0,
                    initialValue: RangeValues(4, 7),
                    divisions: 20,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: const InputDecoration(labelText: 'Price Range'),
                  ),
                  FormBuilderCheckbox(
                    name: 'accept_terms',
                    initialValue: false,
                    onChanged: _onChanged,
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I have read and agree to the ',
                            style: TextStyle(color: Colors.black),
                          ),
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
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.equal(
                        context,
                        true,
                        errorText:
                            'You must accept terms and conditions to continue',
                      ),
                    ]),
                  ),
                  FormBuilderTextField(
                    autovalidate: true,
                    name: 'age',
                    decoration: InputDecoration(
                      labelText: 'Age',
                      suffixIcon: _ageHasError
                          ? Icon(Icons.error, color: Colors.red)
                          : Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _ageHasError =
                            !_fbKey.currentState.fields['age'].validate();
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.max(context, 70),
                    ]),
                    // initialValue: '12',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderDropdown(
                    // autovalidate: true,
                    name: 'gender',
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      suffix: _genderHasError
                          ? Icon(Icons.error)
                          : Icon(Icons.check),
                    ),
                    // initialValue: 'Male',
                    allowClear: true,
                    hint: Text('Select Gender'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text('$gender'),
                            ))
                        .toList(),
                    onChanged: (val) {
                      print(val);
                      setState(() {
                        _genderHasError =
                            !_fbKey.currentState.fields['gender'].validate();
                      });
                    },
                  ),
                  FormBuilderTypeAhead(
                    decoration: const InputDecoration(
                      labelText: 'Country',
                    ),
                    name: 'country',
                    onChanged: _onChanged,
                    itemBuilder: (context, country) {
                      return ListTile(
                        title: Text(country),
                      );
                    },
                    controller: TextEditingController(text: ''),
                    initialValue: 'Uganda',
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
                  FormBuilderRadioGroup(
                    decoration: const InputDecoration(
                      labelText: 'My chosen language',
                    ),
                    name: 'best_language',
                    onChanged: _onChanged,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                    controlAffinity: ControlAffinity.trailing,
                  ),
                  FormBuilderSegmentedControl(
                    decoration: const InputDecoration(
                      labelText: 'Movie Rating (Archer)',
                    ),
                    name: 'movie_rating',
                    // initialValue: 1,
                    // textStyle: TextStyle(fontWeight: FontWeight.bold),
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
                  FormBuilderSwitch(
                    title: const Text('I Accept the tems and conditions'),
                    name: 'accept_terms_switch',
                    initialValue: true,
                    onChanged: _onChanged,
                  ),
                  FormBuilderTouchSpin(
                    decoration: const InputDecoration(labelText: 'TouchSpin'),
                    name: 'touch_spin',
                    initialValue: 10,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.arrow_right),
                    subtractIcon: Icon(Icons.arrow_left),
                  ),
                  FormBuilderRating(
                    decoration:
                        const InputDecoration(labelText: 'Rate this form'),
                    name: 'rate',
                    iconSize: 32.0,
                    initialValue: 1.0,
                    max: 5.0,
                    onChanged: _onChanged,
                  ),
                  FormBuilderCheckboxGroup(
                    decoration: const InputDecoration(
                        labelText: 'The language of my people'),
                    name: 'languages',
                    initialValue: ['Dart'],
                    options: [
                      FormBuilderFieldOption(value: 'Dart'),
                      FormBuilderFieldOption(value: 'Kotlin'),
                      FormBuilderFieldOption(value: 'Java'),
                      FormBuilderFieldOption(value: 'Swift'),
                      FormBuilderFieldOption(value: 'Objective-C'),
                    ],
                    onChanged: _onChanged,
                    separator: VerticalDivider(
                      width: 10,
                      thickness: 5,
                      color: Colors.red,
                    ),
                  ),
                  FormBuilderSignaturePad(
                    decoration: const InputDecoration(
                      labelText: 'Signature',
                      border: OutlineInputBorder(),
                    ),
                    name: 'signature',
                    border: Border.all(color: Colors.green),
                    onChanged: _onChanged,
                  ),
                  FormBuilderImagePicker(
                    name: 'photos',
                    decoration: const InputDecoration(labelText: 'Pick Photos'),
                    maxImages: 1,
                  ),
                  SizedBox(height: 15),
                  // ignore: deprecated_member_use
                  FormBuilderCountryPicker(
                    initialValue: 'Germany',
                    name: 'country',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Country',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'This field required.'),
                    ]),
                  ),
                  SizedBox(height: 15),
                  FormBuilderPhoneField(
                    name: 'phone_number',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      hintText: 'Hint',
                    ),
                    onChanged: _onChanged,
                    priorityListByIsoCode: ['KE'],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context,
                          errorText: 'Invalid phone number'),
                      FormBuilderValidators.required(context,
                          errorText: 'This field required'),
                    ]),
                  ),
                  SizedBox(height: 15),
                  /*FormBuilderSearchableDropdown<Contact>(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    name: 'searchable',
                    items: contacts
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text('${e.name}'),
                            ))
                        .toList(),
                    hint: 'Select one',
                    searchHint: 'Select one',
                    isExpanded: true,
                    onChanged: _onChanged,
                  ),*/
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
                  child: OutlineButton(
                    focusNode: FocusNode(),
                    color: Theme.of(context).accentColor,
                    child: Text('Reset', style: TextStyle(color: Colors.white)),
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
