# packages.form_builder_phone_field

Phone input field for [flutter_form_builder](https://pub.dev/packages/flutter_form_builder) package

Compatible with flutter_form_builder 7.1.1 and below

# Usage
```dart
FormBuilderPhoneField(
  name: 'phone_number',
  decoration: const InputDecoration(
    labelText: 'Phone Number',
    hintText: 'Hint',
  ),
  priorityListByIsoCode: ['KE'],
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(context),
  ]),
),
```
