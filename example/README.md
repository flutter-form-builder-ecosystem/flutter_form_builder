# example

An example project for `flutter_form_builder`.

## Sample Code

```
FormBuilder(
  key: _fbKey,
  autovalidate: true,
  // readonly: true,
  child: Column(
    children: <Widget>[
      FormBuilderCustomField(
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
                errorText: field.errorText,
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
        // readonly: true,
        onChanged: _onChanged,
        // valueTransformer: (val) => val.length > 0 ? val[0] : null,
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
        inputType: InputType.date,
        format: DateFormat("yyyy-MM-dd"),
        decoration:
            InputDecoration(labelText: "Appointment Time"),
        readonly: true,
      ),
      FormBuilderSlider(
        attribute: "slider",
        validators: [FormBuilderValidators.min(6)],
        onChanged: _onChanged,
        min: 0.0,
        max: 10.0,
        initialValue: 1.0,
        divisions: 20,
        decoration:
            InputDecoration(labelText: "Number of things"),
      ),
      FormBuilderCheckbox(
        attribute: 'accept_terms',
        initialValue: false,
        onChanged: _onChanged,
        leadingInput: true,
        label: Text(
            "I have read and agree to the terms and conditions"),
        validators: [
          FormBuilderValidators.requiredTrue(
            errorText:
                "You must accept terms and conditions to continue",
          ),
        ],
      ),
      FormBuilderDropdown(
        attribute: "gender",
        decoration: InputDecoration(labelText: "Gender"),
        // initialValue: 'Male',
        onChanged: _onChanged,
        hint: Text('Select Gender'),
        validators: [FormBuilderValidators.required()],
        items: ['Male', 'Female', 'Other']
            .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text('$gender'),
                ))
            .toList(),
      ),
      FormBuilderTextField(
        attribute: "age",
        decoration: InputDecoration(labelText: "Age"),
        onChanged: _onChanged,
        valueTransformer: (text) => num.tryParse(text),
        validators: [
          FormBuilderValidators.numeric(),
          FormBuilderValidators.max(70),
        ],
      ),
      FormBuilderTypeAhead(
        // initialValue: "Canada",
        decoration: InputDecoration(labelText: "Country"),
        attribute: 'country',
        onChanged: _onChanged,
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
        leadingInput: true,
        onChanged: _onChanged,
        validators: [FormBuilderValidators.required()],
        options: [
          "Dart",
          "Kotlin",
          "Java",
          "Swift",
          "Objective-C"
        ]
            .map((lang) => FormBuilderFieldOption(value: lang))
            .toList(growable: false),
      ),
      FormBuilderSegmentedControl(
        decoration:
            InputDecoration(labelText: "Movie Rating (Archer)"),
        attribute: "movie_rating",
        options: List.generate(5, (i) => i + 1)
            .map(
                (number) => FormBuilderFieldOption(value: number))
            .toList(),
        onChanged: _onChanged,
      ),
      FormBuilderSwitch(
        label: Text('I Accept the tems and conditions'),
        attribute: "accept_terms_switch",
        initialValue: true,
        onChanged: _onChanged,
      ),
      FormBuilderStepper(
        decoration: InputDecoration(labelText: "Stepper"),
        attribute: "stepper",
        initialValue: 10,
        step: 1,
        validators: [
          (val) {
            if (!_fbKey.currentState.fields["accept_terms_switch"]
                    .currentState.value &&
                val >= 10) {
              return "You can only put more than 10 if you've accepted terms";
            }
          }
        ],
      ),
      FormBuilderRate(
        decoration: InputDecoration(labelText: "Rate this form"),
        attribute: "rate",
        iconSize: 32.0,
        initialValue: 1,
        max: 5,
        onChanged: _onChanged,
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
          _fbKey.currentState.save();
          if (_fbKey.currentState.validate()) {
            print(_fbKey.currentState.value);
          } else {
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
)
```
