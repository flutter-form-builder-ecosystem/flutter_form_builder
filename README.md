# Flutter FormBuilder - flutter_form_builder

This widget helps in generation of forms in [Flutter](https://flutter.io/). 
Wraps common input types with FormField allowing validation, change detection, setting input value etc and have them in a single form

Saves you some common validations  such as: required fields, number, email & url validity, `min` and `max` values for numbers, `min` and `max` character length for string based fields
as well as allow you to include your own custom validation

On submission, the form returns a `Map<String, dynamic>` of form values if the form is valid or `null` otherwise.


## Usage
To use this plugin, add `flutter_form_builder` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).


### Example

```dart
GlobalKey<FormBuilderState> _fbKey = GlobalKey();

          Column(
            children: <Widget>[
              FormBuilder(
                context,
                key: _fbKey,
                autovalidate: true,
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
                              errorText: field.errorText,
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
                      // require: true,
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
          )
```

## TODO: 
### Improvements
- [ ] Improve documentation by showing complete list of input types and their usage and options
- [ ] Assert no duplicates in `FormBuilderInput`s `attribute` names
- [ ] Allow options for Checkboxes and Radios to appear left or right
- [ ] Allow addition of custom input types
- [ ] Proper validation for URL - does not work without protocol - http(s)

### New FormBuilder inputs
- [X] SignaturePad
- [ ] MapInput
- [ ] ImagePicker
- [ ] DocumentPicker
- [ ] RangeSlider - https://pub.dartlang.org/packages/flutter_range_slider
- [ ] ColorPicker - https://pub.dartlang.org/packages/flutter_colorpicker
- [ ] DateRangePicker - https://pub.dartlang.org/packages/date_range_picker
- [ ] CodeInput - https://pub.dartlang.org/packages/code_input#-readme-tab- (Not Important)
- [ ] MaskedText - https://pub.dartlang.org/packages/flutter_masked_text#-changelog-tab- (Not Important)


