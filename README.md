# Flutter FormBuilder - flutter_form_builder

This package helps in generation of forms in [Flutter](https://flutter.io/) by providing the syntactic sugar for creating a Form Widget and reduce the boilerplate needed to build a form, validate fields, react to changes, and collect the value of the Form in the form of a map.

The package also comes with common validation functions that can be easily composable to enforce the DRY Principle in code-base.

## Simple Usage
To use this plugin, add `flutter_form_builder` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example
```dart
final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
```

```dart
Column(
  children: <Widget>[
    FormBuilder(
      context,
      key: _fbKey,
      autovalidate: true,
      child: Column(
        children: <Widget>[
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
            items: ['Male', 'Female', 'Other']
              .map((gender) => DropdownMenuItem(
                 value: gender,
                 child: Text("$gender")
            )).toList(),
          ),
          FormBuilderTextField(
            attribute: "age",
            decoration: InputDecoration(labelText: "Age"),
            validators: [
              FormBuilderValidators.numeric(),
              FormBuilderValidators.max(70),
            ],
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
              FormBuilderFieldOption(value: "Dart"),
              FormBuilderFieldOption(value: "Kotlin"),
              FormBuilderFieldOption(value: "Java"),
              FormBuilderFieldOption(value: "Swift"),
              FormBuilderFieldOption(value: "Objective-C"),
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

## Input widgets
The currently supported fields include:
* `FormBuilderCheckbox` - Single Checkbox field
* `FormBuilderCheckboxList` - List of Checkboxes for multiple selection
* `FormBuilderChipsInput` - Takes a list of `Chip`s as input
* `FormBuilderDateTimePicker` - For Date, Time and DateTime input
* `FormBuilderDropdown` - Allow selection of one value from a list as a Dropdown
* `FormBuilderRadio` - Allow selection of one value from a list of Radio Widgets 
* `FormBuilderRate` - For selection of a numerical value as a rating 
* `FormBuilderSegmentedControl` - For selection of a value from the `CupertinoSegmentedControl` as an input
* `FormBuilderSignaturePad` - Presents a drawing pad on which user can doodle
* `FormBuilderSlider` - For selection of a numerical value on a slider
* `FormBuilderStepper` - Selection of a number by tapping on a plus or minus symbol
* `FormBuilderSwitch` - On/Off switch
* `FormBuilderTextField` - For text input. Allows input of single-line text, multi-line text, password,
email, urls etc by using different configurations and validators
* `FormBuilderTypeAhead` - Auto-completes user input from a list of items

In order to create an input field in the form, along with the label, and any applicable validation,
there are several attributes that will be added to the different types of fields namely:

| Attribute | Type  | Default | Required | Description |
|-----------|-------|---------|-------------|----------|
| `attribute` | `String` | `null` | `true` | This will form the key in the form value Map |
| `initialValue` | `dynamic` | `null`  | `false` | The initial value of the input field |
| `readonly` | `bool` | `false` | `false` | Determines whether the field widget will accept user input. This value will be ignored if the `readonly` attribute of `FormBuilder` widget is set to `true` |
| `decoration` | `InputDecoration` | `InputDecoration()` | `false` | |
| `validators` | `List<FormFieldValidator>` | `[]` | `false` | List of `FormFieldValidator`s that will check the validity of value candidate in the `FormField` |
| `onChanged` | `ValueChanged<T>` | `null` | `false` | This event function will fire immediately the the field value changes |
| `valueTransformer` | `ValueTransformer<T>` | `null` | `false` | Function that transforms field value before saving to form value. e.g. transform TextField value for numeric field from `String` to `num` |

The rest of the attributes will be determined by the type of Widget being used as a `FormField`

### Building your own custom `FormField`
```dart
FormBuilderCustomField(
  attribute: "name",
  validators: [
    FormBuilderValidators.required(),
  ],
  formField: FormField(
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
```

## Validation
The `validators` attribute in fields take in any number of `FormFieldValidator` allowing composability 
of validation functions as well as allow reusability of already defined validator methods.

### Built-in Validators
The package comes with several most common `FormFieldValidator`s such as required, numeric, mail, URL, min, 
max, minLength, maxLength, IP, credit card etc. with default `errorText` in English but with 
ability to include you own error message that will display whenever validation fails.
Validation example:
```dart
FormBuilderTextField(
  attribute: "age",
  decoration: InputDecoration(labelText: "Age"),
  validators: [
    FormBuilderValidators.numeric(),
    FormBuilderValidators.max(70),
  ],
),
```

### Custom validator function
As well as the built-in validators any function of type `FormFieldValidator` will be accepted into the list of `validators`.
```dart
FormBuilderTextField(
    attribute: "over_18",
    decoration: InputDecoration(labelText: "Are you over 18?"),
    validators: [
        FormBuilderValidators.required(),
        (val){
            if(val.toLowerCase() != "yes")
                return "The answer must be Yes";
        },
    ],
),
```

## TODO: 
### Improvements
- [X] Allow addition of custom input types
- [X] Improve documentation by showing complete list of input types and their usage and options
- [ ] Create a `transformer` function option that will convert field value when field id saved - can be used to convert string to number, change to uppercase etc.
- [ ] Assert no duplicates in `FormBuilderInput`s `attribute` names
- [ ] Allow options for Checkboxes and Radios to appear left or right

### New FormBuilder inputs
- [X] SignaturePad
- [ ] MapInput
- [ ] ImagePicker
- [ ] DocumentPicker
- [ ] RangeSlider - https://pub.dartlang.org/packages/flutter_range_slider
- [ ] ColorPicker - https://pub.dartlang.org/packages/flutter_colorpicker
- [ ] DateRangePicker - https://pub.dartlang.org/packages/date_range_picker


