# FormBuilder Fields

Form Builder Fields provides common ready-made form input fields for [`flutter_form_builder` package](https://pub.dev/packages/flutter_form_builder). The package gives you a convenient way of adding common ready-made input fields instead of creating your own FormBuilderField from scratch.

___

[![Pub Version](https://img.shields.io/pub/v/form_builder_fields?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_fields)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/danvick/flutter_form_builder/CI?logo=github&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/actions?query=workflow%3ACI)
[![Codecov](https://img.shields.io/codecov/c/github/danvick/flutter_form_builder?logo=codecov&style=for-the-badge)](https://codecov.io/gh/danvick/flutter_form_builder/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/danvick/flutter_form_builder?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/danvick/flutter_form_builder)
[![GitHub](https://img.shields.io/github/license/danvick/flutter_form_builder?logo=open+source+initiative&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/blob/master/LICENSE)
[![OSS Lifecycle](https://img.shields.io/osslifecycle/danvick/flutter_form_builder?style=for-the-badge)](#support)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)

___

### Example
```dart
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_fields/form_builder_fields.dart';

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


## Support
### Issues and PRs
Any kind of support in the form of reporting bugs, answering questions or PRs is always appreciated.

### Coffee :-)
If this package was helpful to you in delivering your project or you just wanna to support this
package, a cup of coffee would be highly appreciated ;-)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)

