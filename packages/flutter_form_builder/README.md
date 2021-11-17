# Flutter FormBuilder - flutter_form_builder

This package helps in creation of data collection forms in Flutter by removing the boilerplate needed to build a form, validate fields, react to changes,
and collect final user input.

Also included are common ready-made form input fields for FormBuilder. This gives you a convenient way of adding common ready-made input fields instead of creating your own FormBuilderField from scratch.
___

[![Pub Version](https://img.shields.io/pub/v/flutter_form_builder?logo=flutter&style=for-the-badge)](https://pub.dev/packages/flutter_form_builder)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/danvick/flutter_form_builder/Form%20Builder%20Core?logo=github&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/actions/workflows/form_builder_core.yaml)
[![Codecov](https://img.shields.io/codecov/c/github/danvick/flutter_form_builder?logo=codecov&style=for-the-badge)](https://codecov.io/gh/danvick/flutter_form_builder/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/danvick/flutter_form_builder?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/danvick/flutter_form_builder)
[![GitHub](https://img.shields.io/github/license/danvick/flutter_form_builder?logo=open+source+initiative&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/blob/master/LICENSE)
[![OSS Lifecycle](https://img.shields.io/osslifecycle/danvick/flutter_form_builder?style=for-the-badge)](#support)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)

___

### Example
```dart
import 'package:flutter_form_builder/flutter_form_builder.dart';

...

final _formKey = GlobalKey<FormBuilderState>();

...

@override
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
      FormBuilder(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            FormBuilderFilterChip(
              name: 'filter_chip',
              decoration: InputDecoration(
                labelText: 'Select many options',
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
            FormBuilderChoiceChip(
              name: 'choice_chip',
              decoration: InputDecoration(
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
            FormBuilderDateTimePicker(
              name: 'date',
              // onChanged: _onChanged,
              inputType: InputType.time,
              decoration: InputDecoration(
                labelText: 'Appointment Time',
              ),
              initialTime: TimeOfDay(hour: 8, minute: 0),
              // initialValue: DateTime.now(),
              // enabled: true,
            ),
            FormBuilderDateRangePicker(
              name: 'date_range',
              firstDate: DateTime(1970),
              lastDate: DateTime(2030),
              format: DateFormat('yyyy-MM-dd'),
              onChanged: _onChanged,
              decoration: InputDecoration(
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
              decoration: InputDecoration(
                labelText: 'Number of things',
              ),
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
              name: 'age',
              decoration: InputDecoration(
                labelText:
                    'This value is passed along to the [Text.maxLines] attribute of the [Text] widget used to display the hint text.',
              ),
              onChanged: _onChanged,
              // valueTransformer: (text) => num.tryParse(text),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.numeric(context),
                FormBuilderValidators.max(context, 70),
              ]),
              keyboardType: TextInputType.number,
            ),
            FormBuilderDropdown(
              name: 'gender',
              decoration: InputDecoration(
                labelText: 'Gender',
              ),
              // initialValue: 'Male',
              allowClear: true,
              hint: Text('Select Gender'),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              items: genderOptions
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text('$gender'),
                      ))
                  .toList(),
            ),
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
      )
    ],
  );
}
```

## Input widgets
The currently supported fields include:
* `FormBuilderCheckbox` - Single Checkbox field
* `FormBuilderCheckboxGroup` - List of Checkboxes for multiple selection
* `FormBuilderChoiceChip` - Creates a chip that acts like a radio button.
* `FormBuilderDateRangePicker` - For selection of a range of dates
* `FormBuilderDateTimePicker` - For `Date`, `Time` and `DateTime` input
* `FormBuilderDropdown` - Used to select one value from a list as a Dropdown
* `FormBuilderFilterChip` - Creates a chip that acts like a checkbox.
* `FormBuilderRadioGroup` - Used to select one value from a list of Radio Widgets
* `FormBuilderRangeSlider` - Used to select a range from a range of values
* `FormBuilderSegmentedControl` - For selection of a value using the `CupertinoSegmentedControl` widget as an input
* `FormBuilderSlider` - For selection of a numerical value on a slider
* `FormBuilderSwitch` - On/Off switch field
* `FormBuilderTextField` - A Material Design text field input.

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
#### Option 1 - Using FormBuilder / FieldBuilderField key
```dart
final _formKey = GlobalKey<FormBuilderState>();
final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
...
FormBuilder(
  key: _formKey,
  child: Column(
    children: [
      FormBuilderTextField(
        key: _emailFieldKey
        name: 'email',
        decoration: InputDecoration(labelText: 'Email'),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.email(context),
        ]),
      ),
      RaisedButton(
        child: Text('Submit'),
        onPressed: () async {
          if(await checkIfEmailExists()){
            // Either invalidate using Form Key
            _formKey.currentState?.invalidateField(name: 'email', errorText: 'Email already taken.');
            // OR invalidate using Field Key
            _emailFieldKey.currentState?.invalidate('Email already taken.');
          }
        },
      ),
    ],
  ),
),

```

#### Option 2 - Using InputDecoration.errorText
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
    if(await checkIfEmailExists()){
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
