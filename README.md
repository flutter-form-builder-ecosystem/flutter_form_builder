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
  controls: [
    FormBuilderInput.textField(
      type: FormBuilderInput.TYPE_TEXT,
      attribute: "name",
      label: "Name",
      require: true,
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
      //require: true,
    ),
    FormBuilderInput.password(
      attribute: "password",
      label: "Password",
      //require: true,
    ),
    FormBuilderInput.datePicker(
      label: "Date of Birth",
      attribute: "dob",
    ),
    FormBuilderInput.timePicker(
      label: "Appointment Time",
      attribute: "time",
    ),
    FormBuilderInput.checkboxList(
      label: "My Languages",
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
      options: [
        FormBuilderInputOption(value: "Dart"),
        FormBuilderInputOption(value: "Kotlin"),
        FormBuilderInputOption(value: "Java"),
        FormBuilderInputOption(value: "Swift"),
        FormBuilderInputOption(value: "Objective-C"),
      ],
    ),
    FormBuilderInput.checkbox(
      label: "I accept the terms and conditions",
      attribute: "accept_terms",
      hint: "Kindly make sure you've read all the terms and conditions",
      validator: (value){
        if(!value)
          return "Accept terms to continue";
      }
    ),
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
      iconSize: 48.0,
      value: 1,
      max: 5,
      hint: "Hint",
    ),
    FormBuilderInput.segmentedControl(
        label: "Movie Rating (Archer)",
        attribute: "movie_rating",
        require: true,
        options: [
          FormBuilderInputOption(
            value: 1,
          ),
          FormBuilderInputOption(
            value: 2,
          ),
          FormBuilderInputOption(
            value: 3,
          ),
          FormBuilderInputOption(
            value: 4,
          ),
          FormBuilderInputOption(
            value: 5,
          ),
          FormBuilderInputOption(
            value: 6,
          ),
          FormBuilderInputOption(
            value: 7,
          ),
          FormBuilderInputOption(
            value: 8,
          ),
          FormBuilderInputOption(
            value: 9,
          ),
          FormBuilderInputOption(
            value: 10,
          ),
        ]),
  ],
  onChanged: () {
    print("Form Changed");
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
* Add more `FormBuilderInput` types

## KNOWN ISSUES - HELP NEEDED (Send help ;-P)
* Proper validation for URL [doesn't work without http(s)]
* Resetting the form doesn't clear all `FormField`s
* Overlay for ChipsInput doesn't move when input height changes i.e. when chips wrap
* For some reason Overlay for ChipsInput floats above AppBar when scrolling
* TypeAhead text gets cleared when Dropdown/ChipsInput value changes. What the Flip????

