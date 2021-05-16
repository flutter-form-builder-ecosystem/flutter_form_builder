import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import 'data.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ValueChanged _onChanged = (dynamic val) => print(val);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Fields Example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                FormBuilderSearchableDropdown(
                  name: 'searchable_dropdown',
                  items: allCountries,
                  onChanged: _onChanged,
                ),
                const SizedBox(height: 15),
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
                FormBuilderCupertinoDateTimePicker(
                  name: 'date',
                  initialValue: DateTime.now(),
                  inputType: InputType.date,
                  decoration: const InputDecoration(
                    labelText: 'Appointment Time',
                  ),
                ),
                FormBuilderCupertinoDateTimePicker(
                  name: 'date_es',
                  initialValue: DateTime.now(),
                  inputType: InputType.both,
                  decoration: const InputDecoration(
                    labelText: 'Hora de la cita',
                  ),
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
                FormBuilderTouchSpin(
                  decoration: const InputDecoration(labelText: 'TouchSpin'),
                  name: 'touch_spin',
                  initialValue: 10,
                  step: 1,
                  iconSize: 48.0,
                  addIcon: const Icon(Icons.arrow_right),
                  subtractIcon: const Icon(Icons.arrow_left),
                  onChanged: _onChanged,
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
                FormBuilderSignaturePad(
                  decoration: const InputDecoration(
                    labelText: 'Signature',
                    border: OutlineInputBorder(),
                  ),
                  name: 'signature',
                  border: Border.all(color: Colors.green),
                  onChanged: _onChanged,
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                            print(_formKey.currentState?.value);
                          } else {
                            print(_formKey.currentState?.value);
                            print('validation failed');
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        // color: Theme.of(context).accentColor,
                        child: Text(
                          'Reset',
                          style: TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
