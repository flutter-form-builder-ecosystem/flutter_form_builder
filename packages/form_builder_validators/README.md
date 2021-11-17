# FormBuilder Validators

Form Builder Validators provide a convenient way of validating data entered into any Flutter FormField. It provides common validation rules out of box (such as required, email, number, min, max, minLength, maxLength, date validations etc.) as well as a way to compose multiple validation rules into one FormFieldValidator.

Also included is the `l10n` / `i18n` of error text messages into multiple languages
___

[![Pub Version](https://img.shields.io/pub/v/form_builder_validators?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_validators)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/danvick/flutter_form_builder/Form%20Builder%20Validators?logo=github&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/actions/workflows/form_builder_validators.yaml)
[![Codecov](https://img.shields.io/codecov/c/github/danvick/flutter_form_builder?logo=codecov&style=for-the-badge)](https://codecov.io/gh/danvick/flutter_form_builder/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/danvick/flutter_form_builder?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/danvick/flutter_form_builder)
[![GitHub](https://img.shields.io/github/license/danvick/flutter_form_builder?logo=open+source+initiative&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/blob/master/LICENSE)
[![OSS Lifecycle](https://img.shields.io/osslifecycle/danvick/flutter_form_builder?style=for-the-badge)](#support)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)
___

### Example
```dart
import 'package:form_builder_validators/form_builder_validators.dart';

...

TextFormField(
  decoration: InputDecoration(labelText: 'Name'),
  autovalidateMode: AutovalidateMode.always,
  validator: FormBuilderValidators.required(context),
),
TextFormField(
  decoration: InputDecoration(labelText: 'Age'),
  keyboardType: TextInputType.number,
  autovalidateMode: AutovalidateMode.always,
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.numeric(context, errorText: 'La edad debe ser numérica.'),
    FormBuilderValidators.max(context, 70),
    (val) {
      var number = int.tryParse(val ?? '');
      if (number != null) if (number < 0)
        return 'We cannot have a negative age';
      return null;
    }
  ]),
),
```

## Built-in Validators
This package comes with several most common `FormFieldValidator`s such as required, numeric, mail,
URL, min, max, minLength, maxLength, IP, credit card etc. with default `errorText` messages.

Available built-in validators include:
* `FormBuilderValidators.creditCard()` - requires the field's value to be a valid credit card number.
* `FormBuilderValidators.date()` - requires the field's value to be a valid date string.
* `FormBuilderValidators.email()` - requires the field's value to be a valid email address.
* `FormBuilderValidators.equal()` - requires the field's value be equal to provided object.
* `FormBuilderValidators.integer()` - requires the field's value to be an integer.
* `FormBuilderValidators.ip()` - requires the field's value to be a valid IP address.
* `FormBuilderValidators.match()` - requires the field's value to match the provided regex pattern.
* `FormBuilderValidators.max()` - requires the field's value to be less than or equal to the provided number.
* `FormBuilderValidators.maxLength()` - requires the length of the field's value to be less than or equal to the provided maximum length.
* `FormBuilderValidators.min()` - requires the field's value to be greater than or equal to the provided number.
* `FormBuilderValidators.minLength()` - requires the length of the field's value to be greater than or equal to the provided minimum length.
* `FormBuilderValidators.numeric()` - requires the field's value to be a valid number.
* `FormBuilderValidators.required()` - requires the field have a non-empty value.
* ``FormBuilderValidators.url()`` - requires the field's value to be a valid url.

## Composing multiple validators
`FormBuilderValidators` class comes with a very useful static function named `compose()` which takes a list of `FormFieldValidator` functions. This allows you to create once and reuse validation rules across multiple fields, widgets or apps.

On validation each validator is run and if any one returns a non-null value (i.e. a String), validation fails and the `errorText` for the field is set as the
returned string.

Example:
```dart
TextFormField(
  decoration: InputDecoration(labelText: 'Age'),
  keyboardType: TextInputType.number,
  autovalidateMode: AutovalidateMode.always,
  validator: FormBuilderValidators.compose([
    /// Makes this field required
    FormBuilderValidators.required(context),

    /// Ensures the value entered is numeric - with custom error message
    FormBuilderValidators.numeric(context,
        errorText: 'La edad debe ser numérica.'),

    /// Sets a maximum value of 70
    FormBuilderValidators.max(context, 70),

    /// Include your own custom `FormFieldValidator` function, if you want
    /// Ensures positive values only. We could also have used `FormBuilderValidators.min(context, 0)` instead
    (val) {
      final number = int.tryParse(val);
      if (number == null) return null;
      if (number < 0) return 'We cannot have a negative age';
      return null;
    }
  ]),
),
```

## l10n
To allow for localization of default error messages within your app, add `FormBuilderLocalizations.delegate` in the list of your app's `localizationsDelegates`

```dart
  return MaterialApp(
      supportedLocales: [
        Locale('de'),
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('it'),
        ...
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
```
### Supported languages (default errorText messages)
- Arabic (ar)
- English (en)
- Farsi/Persian (fa)
- French (fr)
- German (de)
- Hungarian (hu)
- Indonesian (id)
- Italian (it)
- Japanese (ja)
- Korean (ko)  
- Polish (pl)
- Portuguese (pt)
- Slovak (sk)
- Spanish (es)

and you can still add your own custom error messages.

## Support
### Issues and PRs
Any kind of support in the form of reporting bugs, answering questions or PRs is always appreciated.

We especially welcome efforts to internationalize/localize the package by translating the default validation `errorText` strings for built-in validation rules.

### Localizing messages

#### 1. Add ARB files
Create one ARB file inside the `lib/l10n` folder for each of the locales you need to add support for. Name the files in the following way: `intl_<LOCALE_ISO_CODE>.arb`. For example: `intl_fr.arb` or `intl_fr_FR.arb`.

#### 2. Translate the error messages

Duplicate the contents of `intl_messages.arb` (or any other ARB file) into your newly created ARB file then translate the error messages by overwritting the default messages.

#### 3. Run command
To generate boilerplate code for localization, run the generate command inside package directory where `pubspec.yaml` file is located:

```
  flutter pub run intl_utils:generate
```

This will automagically create/update files inside `lib/localization` directory which will include support for your newly added locale.

#### 4. Update README
Remember to update README, adding the new language (and language code) under [Supported languages section](#supported-languages-default-errortext-messages) so that everyone knows your new language is now supported!

#### 5. Submit PR
Submit your PR and be of help to millions of developers all over the world!

### Coffee :-)
If this package was helpful to you in delivering your project or you just wanna to support this
package, a cup of coffee would be highly appreciated ;-)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)

