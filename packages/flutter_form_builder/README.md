# Flutter FormBuilder - flutter_form_builder

This package helps in creation of data collection forms in Flutter by removing the boilerplate needed to build a form, validate fields, react to changes,
and collect final user input.
___

[![Pub Version](https://img.shields.io/pub/v/flutter_form_builder?logo=flutter&style=for-the-badge)](https://pub.dev/packages/flutter_form_builder)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/danvick/flutter_form_builder/CI?logo=github&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/actions?query=workflow%3ACI)
[![Codecov](https://img.shields.io/codecov/c/github/danvick/flutter_form_builder?logo=codecov&style=for-the-badge)](https://codecov.io/gh/danvick/flutter_form_builder/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/danvick/flutter_form_builder?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/danvick/flutter_form_builder)
[![GitHub](https://img.shields.io/github/license/danvick/flutter_form_builder?logo=open+source+initiative&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/blob/master/LICENSE)
[![OSS Lifecycle](https://img.shields.io/osslifecycle/danvick/flutter_form_builder?style=for-the-badge)](#support)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)

___

### Example
```dart
final _formKey = GlobalKey<FormBuilderState>();

@override
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
      FormBuilder(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            
          ],
        ),
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _formKey.currentState.save();
                if (_formKey.currentState.validate()) {
                  print(_formKey.currentState.value);
                } else {
                  print("validation failed");
                }
              },
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _formKey.currentState.reset();
              },
            ),
          ),
        ],
      ),
    ],
  );
}
```

## FormBuilderField attributes

In order to create an input field in the form, along with the label, and any applicable validation, there are several attributes that are supported by all types of inputs namely:

| Attribute | Type  | Default | Required | Description |
|-----------|-------|---------|-------------|----------|
| `name` | `String` |  | `Yes` | This will form the key in the form value Map |
| `initialValue` | `T` | `null`  | `No` | The initial value of the input field |
| `enabled` | `bool` | `true` | `No` | Determines whether the field widget will accept user input. |
| `decoration` | `InputDecoration` | `InputDecoration()` | `No` | Defines the border, labels, icons, and styles used to decorate the field. |
| `validator` | `FormFieldValidator<T>` | `null` | `No` | A `FormFieldValidator` that will check the validity of value in the `FormField` |
| `onChanged` | `ValueChanged<T>` | `null` | `No` | This event function will fire immediately the the field value changes |
| `valueTransformer` | `ValueTransformer<T>` | `null` | `No` | Function that transforms field value before saving to form value. e.g. transform TextField value for numeric field from `String` to `num` |
The rest of the attributes will be determined by the type of Widget being used.

### Building your own custom field
To build your own field within a `FormBuilder`, we use `FormBuilderField` which will require that you define your own field.
```dart
var options = ["Option 1", "Option 2", "Option 3"];
```

```dart
FormBuilderField(
  name: "name",
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(context),
  ]),
  builder: (FormFieldState<dynamic> field) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: "Select option",
        contentPadding:
            EdgeInsets.only(top: 10.0, bottom: 0.0),
        border: InputBorder.none,
        errorText: field.errorText,
      ),
      child: Container(
        height: 200,
        child: CupertinoPicker(
          itemExtent: 30,
          children: options.map((c) => Text(c)).toList(),
          onSelectedItemChanged: (index) {
            field.didChange(options[index]);
          },
        ),
      ),
    );
  },
),
```

### Programmatically changing field value
You can either change the value of one field at a time like so:
```dart
_formKey.currentState.fields['color_picker'].didChange(Colors.black);
```
Or multiple fields value like so:
```dart
_formKey.currentState.patchValue({
  'age': '50',
  'slider': 6.7,
  'filter_chip': ['Test 1'],
  'choice_chip': 'Test 2',
  'rate': 4,
  'chips_test': [
    Contact('Andrew', 'stock@man.com', 'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
  ],
});
```

### Programmatically inducing an error
Declare a variable to hold your error:
```dart
String _emailError;
```

Use the variable as the `errorText` within `InputDecoration`
```dart
FormBuilderTextField(
  name: 'email',
  decoration: InputDecoration(
    labelText: 'Email',
    errorText: _emailError,
  ),
  validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(context),
      FormBuilderValidators.email(context),
  ]),
),
```

Set the error text
```dart
RaisedButton(
  child: Text('Submit'),
  onPressed: () async {
    setState(() => _emailError = null);
    if(checkIfEmailExists()){
      setState(() => _emailError = 'Email already taken.');
    }
  },
),
```

### Conditional validation
You can also validate a field based on the value of another field
```dart
FormBuilderRadioGroup(
  decoration: InputDecoration(labelText: 'My best language'),
  name: 'my_language',
  validator: FormBuilderValidators.required(context),
  options: [
    'Dart',
    'Kotlin',
    'Java',
    'Swift',
    'Objective-C',
    'Other'
  ]
    .map((lang) => FormBuilderFieldOption(value: lang))
    .toList(growable: false),
  ),
  FormBuilderTextField(
    name: 'specify',
    decoration:
        InputDecoration(labelText: 'If Other, please specify'),
    validator: (val) {
      if (_formKey.currentState.fields['my_language']?.value ==
              'Other' &&
          (val == null || val.isEmpty)) {
        return 'Kindly specify your language';
      }
      return null;
    },
  ),
```
### Ecosystem
Here are additional packages that you can use to extend `flutter_form_builder`'s functionality.
* [form_builder_fields](https://pub.dev/packages/form_builder_fields) - provides common ready-made form input fields compartible with `flutter_form_builder`.
* [form_builder_validators](https://pub.dev/packages/form_builder_validators) - provides a convenient way of validating data entered into any Flutter `FormField`.
* [form_builder_extra_fields](https://pub.dev/packages/form_builder_extra_fields) - provides additional ready-made form input fields compartible with `flutter_form_builder`.
* [form_builder_file_picker](https://pub.dev/packages/form_builder_file_picker) - A `FormbuilderField` that allows selecting image(s) from user device storage.
* [form_builder_image_picker](https://pub.dev/packages/form_builder_image_picker) - A `FormbuilderField` that allows selecting image(s) from device Gallery or Camera.
* [form_builder_map_field](https://pub.dev/packages/form_builder_map_field) - A `FormbuilderField` for geographic location input.
* [form_builder_phone_field](https://pub.dev/packages/form_builder_phone_field) - A `FormbuilderField` for international phone number input.

## Support
### Issues and PRs
Any kind of support in the form of reporting bugs, answering questions or PRs is always appreciated.

### Coffee :-)
If this package was helpful to you in delivering your project or you just wanna to support this
package, a cup of coffee would be highly appreciated ;-)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)
