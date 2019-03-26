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

SingleChildScrollView(
  Column(
    children: <Widget>[
        FormBuilder(
          context,
          key: _fbKey,
          autovalidate: true,
          readonly: false,
          /*onChanged: (formValue) {
            print(formValue);
          },*/
          controls: [
            FormBuilderInput.typeAhead(
              decoration: InputDecoration(labelText: "Country"),
              attribute: 'country',
              // require: true,
              itemBuilder: (context, country) {
                return ListTile(
                  title: Text(country),
                );
              },
              suggestionsCallback: (query) {
                if (query.length != 0) {
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
            FormBuilderInput.chipsInput(
              decoration: InputDecoration(labelText: "Chils"),
              attribute: 'chips_test',
              // require: true,
              value: [
                Contact('Andrew', 'stock@man.com',
                    'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
              ],
              max: 1,
              suggestionsCallback: (String query) {
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
            FormBuilderInput.textField(
                type: FormBuilderInput.TYPE_TEXT,
                attribute: "name",
                decoration: InputDecoration(labelText: "Full Name"),
                value: "John Doe",
                // require: true,
                // readonly: true,
                require: true,
                // readonly: true,
                min: 3,
            FormBuilderInput.dropdown(
              attribute: "dropdown",
              // require: true,
              decoration: InputDecoration(labelText: "Select options"),
              options: [
                FormBuilderInputOption(value: "Option 1"),
                FormBuilderInputOption(value: "Option 2"),
                FormBuilderInputOption(value: "Option 3"),
              ],
            ),
            FormBuilderInput.number(
              attribute: "age",
              decoration: InputDecoration(labelText: "Your Age"),
              // require: true,
              // min: 18,
            ),
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_MULTILINE_TEXT,
              attribute: "story",
              decoration: InputDecoration(labelText: "Story"),
              value: "Here's my story",
              require: false,
              min: 25,
              maxLines: 10,
              autovalidate: true,
            ),
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_EMAIL,
              attribute: "email",
              decoration: InputDecoration(labelText: "Email"),
              require: true,
            ),
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_URL,
              attribute: "url",
              decoration: InputDecoration(labelText: "Website"),
              require: true,
            ),
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_PHONE,
              attribute: "phone",
              decoration: InputDecoration(labelText: "Phone Number"),
              //require: true,
            ),
            FormBuilderInput.password(
              attribute: "password",
              decoration: InputDecoration(labelText: "Password"),
              min: 8,
            ),
            FormBuilderInput.datePicker(
              decoration: InputDecoration(labelText: "Date of Birth"),
              readonly: true,
              attribute: "dob",
              firstDate: DateTime(1970),
              value: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 1)),
              format: 'dd, MM yyyy',
            ),
            FormBuilderInput.timePicker(
              decoration: InputDecoration(labelText: "Alarm Time"),
              attribute: "alarm",
              require: true,
            ),
            FormBuilderInput.dateTimePicker(
              decoration: InputDecoration(labelText: "Appointment Time"),
              attribute: "appointment_time",
              firstDate: DateTime(1970),
              lastDate: DateTime.now().add(Duration(days: 1)),
              // format: 'dd, MM yyyy hh:mm',
            ),
            FormBuilderInput.checkboxList(
              decoration:
                  InputDecoration(labelText: "The language of my people"),
              attribute: "languages",
              require: false,
              value: ["Dart"],
              options: [
                FormBuilderInputOption(value: "Dart"),
                FormBuilderInputOption(value: "Kotlin"),
                FormBuilderInputOption(value: "Java"),
                FormBuilderInputOption(value: "Swift"),
                FormBuilderInputOption(value: "Objective-C"),
              ],
            ),
            FormBuilderInput.radio(
              decoration:
                  InputDecoration(labelText: 'My chosen language'),
              attribute: "best_language",
              require: true,
              options: ["Dart", "Kotlin", "Java", "Swift", "Objective-C"]
                  .map((lang) => FormBuilderInputOption(value: lang))
                  .toList(growable: false),
            ),
            FormBuilderInput.checkbox(
                label: Text('I Accept the tems and conditions'),
                attribute: "accept_terms",
                validator: (value) {
                  if (!value) return "Accept terms to continue";
                }),
            FormBuilderInput.switchInput(
                label: Text('I Accept the tems and conditions'),
                attribute: "accept_terms_switch",
                value: true,
                validator: (value) {
                  if (!value) return "Accept terms to continue";
                }),
            FormBuilderInput.slider(
              decoration: InputDecoration(labelText: "Slider"),
              attribute: "slider",
              min: 0.0,
              require: true,
              max: 100.0,
              value: 10.0,
              divisions: 20,
            ),
            FormBuilderInput.stepper(
              decoration: InputDecoration(labelText: "Stepper"),
              attribute: "stepper",
              value: 10,
              step: 1,
            ),
            FormBuilderInput.signaturePad(
              decoration: InputDecoration(labelText: "Signature"),
              attribute: "signature",
              require: true,
            ),
            FormBuilderInput.rate(
              decoration: InputDecoration(labelText: "Rate this form"),
              attribute: "rate",
              iconSize: 32.0,
              value: 1,
              max: 5,
            ),
            FormBuilderInput.segmentedControl(
              decoration:
                  InputDecoration(labelText: "Movie Rating (Archer)"),
              attribute: "movie_rating",
              // value: 2,
              require: true,
              options: List.generate(5, (i) => i + 1)
                  .map((number) => FormBuilderInputOption(value: number))
                  .toList(),
            ),
          ],
      ),
      MaterialButton(
        child: Text('External submit'),
        onPressed: () {
          _fbKey.currentState.save();
          if (_fbKey.currentState.validate()) {
            print('validationSucceded');
            print(_fbKey.currentState.value);
          } else {
            print("External FormValidation failed");
          }
        },
      ),
    ],
  ),
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


