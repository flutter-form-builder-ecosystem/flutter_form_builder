# Flutter FormBuilder - flutter_form_builder

This widget helps in generation of forms in [Flutter](https://flutter.io/). 
Wraps common input types with FormField allowing validation, change detection, setting input value etc and have them in a single form

Saves you some common validations  such as: required fields, number, email & url validity, `min` and `max` values for numbers, `min` and `max` character length for string based fields
as well as allow you to include your own custom validation

On submission, the form returns a `Map<String, dynamic>` of form values if the form is valid or `null` otherwise.


## Usage
To use this plugin, add `flutter_form_builder` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).


### Example

```
FormBuilder(
  context,
  autovalidate: true,
  // readonly: true,
  showResetButton: true,
  // resetButtonContent: Text("Clear Form"),
  controls: [
    FormBuilderInput.typeAhead(
      label: 'Country',
      attribute: 'country',
      require: true,
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
                .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
        } else {
          return allCountries;
        }
      },
    ),
    FormBuilderInput.chipsInput(
      label: 'Chips',
      attribute: 'chips_test',
      require: true,
      value: [
        Contact('Andrew', 'stock@man.com',
            'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
      ],
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
                .compareTo(
                    b.name.toLowerCase().indexOf(lowercaseQuery)));
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
      label: "Name",
      value: "John Doe",
      require: true,
      readonly: true,
      min: 3,
    ),
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
    FormBuilderInput.textField(
      type: FormBuilderInput.TYPE_EMAIL,
      attribute: "email",
      label: "Email",
      require: true,
    ),
    FormBuilderInput.textField(
      type: FormBuilderInput.TYPE_URL,
      attribute: "url",
      label: "URL",
      require: true,
    ),
    FormBuilderInput.textField(
        type: FormBuilderInput.TYPE_PHONE,
        attribute: "phone",
        label: "Phone",
        hint: "Including country code (+254)"
        //require: true,
        ),
    FormBuilderInput.password(
      attribute: "password",
      label: "Password",
      min: 8,
    ),
    FormBuilderInput.datePicker(
        label: "Date of Birth",
        readonly: true,
        attribute: "dob",
        firstDate: DateTime(1970),
        lastDate: DateTime.now().add(Duration(days: 1)),
        format: 'dd, MM yyyy'),
    FormBuilderInput.timePicker(
      label: "Appointment Time",
      attribute: "time",
    ),
    FormBuilderInput.checkboxList(
      label: "The Languages of my people",
      hint: "The Languages of my people",
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
      label: "My Best Language",
      attribute: "best_language",
      require: true,
      options: ["Dart", "Kotlin", "Java", "Swift", "Objective-C"]
          .map((lang) => FormBuilderInputOption(value: lang))
          .toList(growable: false),
    ),
    FormBuilderInput.checkbox(
        label: "I accept the terms and conditions",
        attribute: "accept_terms",
        hint:
            "Kindly make sure you've read all the terms and conditions",
        validator: (value) {
          if (!value) return "Accept terms to continue";
        }),
    FormBuilderInput.switchInput(
        label: "I accept the terms and conditions",
        attribute: "accept_terms_switch",
        value: true,
        hint:
            "Kindly make sure you've read all the terms and conditions",
        validator: (value) {
          if (!value) return "Accept terms to continue";
        }),
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
      iconSize: 32.0,
      value: 1,
      max: 5,
      hint: "Hint",
    ),
    FormBuilderInput.segmentedControl(
      label: "Movie Rating (Archer)",
      attribute: "movie_rating",
      // value: 2,
      require: true,
      options: List.generate(5, (i) => i + 1)
          .map((number) => FormBuilderInputOption(value: number))
          .toList(),
    ),
  ],
  onChanged: (formValue) {
    print(formValue);
  },
  onSubmit: (formValue) {
    if (formValue != null) {
      print(formValue);
    } else {
      print("Form invalid");
    }
  },
),
```

## TODO: 
* Improve documentation by showing complete list of input types and their usage and options
* Assert no duplicates in `FormBuilderInput`s `attribute` names
* Add more `FormBuilderInput` types:
    * RangeSlider
    * ColorPicker
    * MaskedText
* Allow options for Checkboxes and Radios to appear left or right
* Allow addition of custom input types

## KNOWN ISSUES - HELP NEEDED (Send help ;-P)
* Proper validation for URL [doesn't work without protocol - http(s)]

