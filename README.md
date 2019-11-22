# Flutter FormBuilder - flutter_form_builder

This package helps in creation of Flutter Forms by providing the syntactic sugar for creating a Form Widget and reduce the boilerplate needed to build a form, validate fields, react to changes, and collect the value of the Form.

## Simple Usage
To use this plugin, add `flutter_form_builder` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example
```dart
final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
```
**Note:** Avoid defining the GlobalKey inside your build method because this will create a new GlobalKey on every build cycle bringing about some erratic behavior.

```dart
Column(
  children: <Widget>[
    FormBuilder(
      key: _fbKey,
      initialValue: {
        'date': DateTime.now(),
        'accept_terms': false,
      },
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
                InputDecoration(labelText: "Number of things"),
          ),
          FormBuilderCheckbox(
            attribute: 'accept_terms',
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
            if (_fbKey.currentState.saveAndValidate()) {
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
* `FormBuilderDateRangePicker` - For selection of a range of dates
* `FormBuilderDateTimePicker` - For Date, Time and DateTime input
* `FormBuilderDropdown` - Used to select one value from a list as a Dropdown
* `FormBuilderRadio` - Used to select one value from a list of Radio Widgets 
* `FormBuilderRangeSlider` - Used to select a range from a range of values
* `FormBuilderRate` - For selection of a numerical value as a rating 
* `FormBuilderSegmentedControl` - For selection of a value from the `CupertinoSegmentedControl` as an input
* `FormBuilderSignaturePad` - Presents a drawing pad on which user can doodle
* `FormBuilderSlider` - For selection of a numerical value on a slider
* `FormBuilderStepper` - Selection of a number by tapping on a plus or minus symbol
* `FormBuilderSwitch` - On/Off switch
* `FormBuilderTextField` - For text input. Accepts input of single-line text, multi-line text, password,
email, urls etc by using different configurations and validators
* `FormBuilderTypeAhead` - Auto-completes user input from a list of items

In order to create an input field in the form, along with the label, and any applicable validation, there are several attributes that are supported by all types of inputs namely:

| Attribute | Type  | Default | Required | Description |
|-----------|-------|---------|-------------|----------|
| `attribute` | `String` | `null` | `true` | This will form the key in the form value Map |
| `initialValue` | `dynamic` | `null`  | `false` | The initial value of the input field |
| `readOnly` | `bool` | `false` | `false` | Determines whether the field widget will accept user input. This value will be ignored if the `readOnly` attribute of `FormBuilder` widget is set to `true` |
| `decoration` | `InputDecoration` | `InputDecoration()` | `false` | |
| `validators` | `List<FormFieldValidator>` | `[]` | `false` | List of `FormFieldValidator`s that will check the validity of value candidate in the `FormField` |
| `onChanged` | `ValueChanged<T>` | `null` | `false` | This event function will fire immediately the the field value changes |
| `valueTransformer` | `ValueTransformer<T>` | `null` | `false` | Function that transforms field value before saving to form value. e.g. transform TextField value for numeric field from `String` to `num` |
The rest of the attributes will be determined by the type of Widget being used.

### Building your own custom field
To build your own field within a `FormBuilder`, we use `FormBuilderCustomField` which will require that you define your own `FormField`.
The `FormField` will not require a `validator` if the `validators` property is already defined in the `FormBuilderCustomField`.

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
```

## Validation
The `validators` attribute in fields take in any number of `FormFieldValidator` allowing composability 
of validation functions as well as allow reusability of already defined validator methods.

### Built-in Validators
The package comes with several most common `FormFieldValidator`s such as required, numeric, mail, URL, min, 
max, minLength, maxLength, IP, credit card etc. with default `errorText` in English but with 
ability to include you own error message that will display whenever validation fails.

Available built-in validators include:
* `FormBuilderValidators.required()` - requires the field have a non-empty value.
* `FormBuilderValidators.numeric()` - requires the field's value to be a valid number.
* `FormBuilderValidators.min()` - requires the field's value to be greater than or equal to the provided number.
* `FormBuilderValidators.max()` - requires the field's value to be less than or equal to the provided number.
* `FormBuilderValidators.minLength()` - requires the length of the field's value to be greater than or equal to the provided minimum length.
* `FormBuilderValidators.maxLength()` - requires the length of the field's value to be less than or equal to the provided maximum length.
* `FormBuilderValidators.pattern()` - requires the field's value to match the provided regex pattern.
* `FormBuilderValidators.email()` - requires the field's value to be a valid email address.
* ``FormBuilderValidators.url()`` - requires the field's value to be a valid url.
* `FormBuilderValidators.IP()` - requires the field's value to be a valid IP address.
* `FormBuilderValidators.creditCard()` - requires the field's value to be a valid credit card number.
* `FormBuilderValidators.date()` - requires the field's value to be a valid date string.
* `FormBuilderValidators.requiredTrue()` - requires the field's value be true.

Validation example:
```dart
FormBuilderTextField(
  attribute: "age",
  decoration: InputDecoration(labelText: "Age"),
  validators: [
    FormBuilderValidators.numeric(errorText: "La edad debe ser numérica."),
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

### Conditional validation
You can also validate a field based on the value of another field
```
FormBuilderRadio(
  decoration: InputDecoration(labelText: 'My best language'),
  attribute: "best_language",
  validators: [FormBuilderValidators.required()],
  options: [
    "Dart",
    "Kotlin",
    "Java",
    "Swift",
    "Objective-C",
    "Other"
  ]
      .map((lang) => FormBuilderFieldOption(value: lang))
      .toList(growable: false),
),
FormBuilderTextField(
    attribute: "specify",
    decoration: InputDecoration(labelText: "If Other, please specify"),
    validators: [
        (val){
            if(_fbKey.currentState.fields['best_language'].currentState.value == "Other" && (val == null || val.isEmpty))
                return "Kindly specify your language";
        },
    ],
),
```

## CREDITS
This package is dependent on the following packages and plugins:
* [flutter_typeahead](https://pub.dartlang.org/packages/flutter_typeahead) by [AbdulRahmanAlHamali](https://github.com/AbdulRahmanAlHamali)
* [sy_flutter_widgets](https://pub.dartlang.org/packages/sy_flutter_widgets) by [Li Shuhao](https://github.com/lishuhao)
* [datetime_picker_formfield](https://pub.dartlang.org/packages/datetime_picker_formfield) by [Jacob Phillips](https://github.com/jifalops)
* [date_range_picker](https://github.com/anicdh/date_range_picker) by [anicdh](https://github.com/anicdh)
* [validators](https://pub.dartlang.org/packages/validators) by [dart-league](https://github.com/dart-league)
* [intl](https://pub.dartlang.org/packages/intl) - Dart Package
* [signature](https://pub.dartlang.org/packages/signature) by [4Q s.r.o.](https://github.com/4Q-s-r-o) with some minor improvements to fit our usage
* [flutter_chips_input](https://pub.dartlang.org/packages/flutter_chips_input) by [Yours trully :-)](https://github.com/danvick)

## TODO: 
### Improvements
- [X] Allow addition of custom input types
- [X] Improve documentation by showing complete list of input types and their usage and options
- [X] Create a `transformer` function option that will convert field value when field is saved - can be used to convert string to number, change to uppercase etc.
- [X] Assert no duplicates in `FormBuilderInput`s `attribute` names
- [X] Allow options for Checkboxes and Radios to appear left or right - Done via `leadingInput` by [Sven Schöne](https://github.com/SvenSchoene)

### New FormBuilder inputs
- [X] RangeSlider
- [X] SignaturePad - Based on [https://pub.dartlang.org/packages/signature](https://pub.dartlang.org/packages/signature)
- [ ] ColorPicker - https://pub.dartlang.org/packages/flutter_colorpicker
- [X] DateRangePicker - https://pub.dartlang.org/packages/date_range_picker
- [ ] MapInput
- [ ] ImagePicker
- [ ] DocumentPicker

## KNOWN ISSUES
Form's `reset()` doesn't clear SignaturePad - You'll be forced to clear manually

## Support
If this package was helpful to you in delivering on your project or you just wanna to support this project, a cup of coffee would be highly appreciated ;-)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)


