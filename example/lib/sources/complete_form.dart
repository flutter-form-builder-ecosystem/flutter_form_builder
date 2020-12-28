import 'package:flutter/cupertino.dart';
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
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _genderHasError = false;

  final ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              // enabled: false,
              autovalidateMode: AutovalidateMode.disabled,
              initialValue: {
                'movie_rating': 5,
                'best_language': 'Dart',
                'age': '13',
                'gender': 'Male'
              },
              skipDisabled: true,
              child: Column(
                children: <Widget>[
                  FormBuilderSearchableDropdown(
                    name: 'searchable_dropdown',
                    items: allCountries,
                    onChanged: _onChanged,
                  ),
                  const SizedBox(height: 15),
                  FormBuilderFilterChip(
                    name: 'filter_chip',
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Select many options',
                    ),
                    initialValue: ['Test', 'Test 1', 'Test 2'],
                    maxChips: 3,
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
                    initialValue: Colors.yellow,
                    // readOnly: true,
                    colorPickerType: ColorPickerType.MaterialPicker,
                    decoration: const InputDecoration(labelText: 'Pick Color'),
                  ),
                  FormBuilderChipsInput<Contact>(
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
                    inputType: InputType.both,
                    decoration: const InputDecoration(
                      labelText: 'Appointment Time',
                    ),
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    pickerType: PickerType.cupertino,
                    //locale: Locale.fromSubtags(languageCode: 'fr'),
                  ),
                  FormBuilderDateTimePicker(
                    name: 'date_es',
                    initialValue: DateTime.now(),
                    inputType: InputType.both,
                    decoration: const InputDecoration(
                      labelText: 'Hora de la cita',
                    ),
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    pickerType: PickerType.cupertino,
                    locale: Locale.fromSubtags(languageCode: 'es'),
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
                    // validator: FormBuilderValidators.compose([FormBuilderValidators.min(context, 6)]),
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
                            // Flutter doesn't allow a button inside a button
                            // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                            /*
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('launch url');
                              },
                            */
                          ),
                        ],
                      ),
                    ),
                    validator: FormBuilderValidators.equal(
                      context,
                      true,
                      errorText:
                          'You must accept terms and conditions to continue',
                    ),
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.always,
                    name: 'age',
                    decoration: InputDecoration(
                      labelText: 'Age',
                      suffixIcon: _ageHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _ageHasError =
                            !_formKey.currentState.fields['age'].validate();
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
                  FormBuilderDropdown<String>(
                    // autovalidate: true,
                    name: 'gender',
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      suffix: _genderHasError
                          ? const Icon(Icons.error)
                          : const Icon(Icons.check),
                    ),
                    // initialValue: 'Male',
                    allowClear: true,
                    hint: Text('Select Gender'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (val) {
                      print(val);
                      setState(() {
                        _genderHasError =
                            !_formKey.currentState.fields['gender'].validate();
                      });
                    },
                  ),
                  FormBuilderTypeAhead<String>(
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
                  FormBuilderRadioGroup<String>(
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
                              child: Text(lang),
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
                                number.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
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
                    addIcon: const Icon(Icons.arrow_right),
                    subtractIcon: const Icon(Icons.arrow_left),
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
                    initialValue: const ['Dart'],
                    options: const [
                      FormBuilderFieldOption(value: 'Dart'),
                      FormBuilderFieldOption(value: 'Kotlin'),
                      FormBuilderFieldOption(value: 'Java'),
                      FormBuilderFieldOption(value: 'Swift'),
                      FormBuilderFieldOption(value: 'Objective-C'),
                    ],
                    onChanged: _onChanged,
                    separator: const VerticalDivider(
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
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.saveAndValidate()) {
                        print(_formKey.currentState.value);
                      } else {
                        print(_formKey.currentState.value);
                        print('validation failed');
                      }
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlineButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    onPressed: () {
                      _formKey.currentState.reset();
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
