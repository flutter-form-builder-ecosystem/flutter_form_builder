# FormBuilder Validators

Form Builder Validators provide a convenient way of validating data entered into any Flutter FormField. It provides common validation rules out of box (such as required, email, number, min, max, minLength, maxLength, date validations etc.) as well as a way to compose multiple validation rules into one FormFieldValidator.

Also included is the `l10n` / `i18n` of error text messages into multiple languages
___

[![Pub Version](https://img.shields.io/pub/v/form_builder_validators?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_validators)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/danvick/flutter_form_builder/CI?logo=github&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/actions?query=workflow%3ACI)
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
  validator: FormBuilderValidators.required(context),
),
TextFormField(
  decoration: InputDecoration(labelText: 'Age'),
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.numeric(context, errorText: 'La edad debe ser numérica.'),
    FormBuilderValidators.max(context, 70),
    (val) {
      var number = double.tryParse(val ?? '');
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
`FormBuilderValidators` class comes with a very useful static function named `compose()` which takes any number of `FormFieldValidator` functions. This allows you to create once and reuse validation rules across multiple fields.

On validation each validator is run and if any one returns a non-null value (i.e. a String), validation fails and the `errorText` for the field is set as the
returned string.

Example:
```dart
TextFormField(
  name: 'age',
  decoration: InputDecoration(labelText: 'Age'),
  validator: FormBuilderValidators.compose([
    /// Ensures the value entered is numeric
    FormBuilderValidators.numeric(context, errorText: 'La edad debe ser numérica.'),

    /// Sets a maximum value of 70
    FormBuilderValidators.max(context, 70),

    /// Include your own custom `FormFieldValidator` function if you want
    /// Ensures postive values only. We could also have used `FormBuilderValidators.min(context, 0)`
    (val){
      if(val < 0)
        return 'We cannot have a negative age';
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
        Locale('en'),
        Locale('it'),
        Locale('fr'),
        Locale('es'),
      ],
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
```
### Languages supported (default errorText messages)
- English (en)
- French (fr)
- German (de)
- Hungarian (hu)
- Italian (it)
- Japanese (ja)
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
1. With the app’s root directory as the current directory, generate `l10n/intl_messages.arb`
from `lib/localization/form_builder_localizations.dart`:

    ```flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localization/form_builder_localizations.dart```

2. The `intl_messages.arb` file is a JSON format map with one entry for each `Intl.message()`
function defined in `lib/localization/form_builder_localizations.dart`. This file serves as a template for the different translations
(for example `intl_en.arb` and `intl_es.arb` are English and Spanish translations respectively). You are therefore you are required to copy the `intl_messages.arb` and put the content in a new file with the name of your locale with a name with format `intl_<locale>.arb` (e.g. `intl_fr.arb` for French Translations).

3. Translate the messages in the new file to the required language.

4. With the app’s root directory as the current directory, generate `intl_messages_<locale>.dart` for your `intl_<locale>.arb` file and update `intl_messages_all.dart`, which imports all of the messages files:

  ```flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localization/form_builder_localizations.dart lib/l10n/intl_<en>.arb lib/l10n/intl_messages.arb```

  e.g. To generate for French run: ```flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localization/form_builder_localizations.dart lib/l10n/intl_fr.arb lib/l10n/intl_messages.arb```

  - Alternatively you could run the following command to generate Dart translation files for all the `intl_<locale>.arb` files in the `l10n/` directory:

  ```flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localization/form_builder_localizations.dart lib/l10n/intl_*.arb```

5. Include your new language to `FormBuilderLocalization`'s supported languages. Go to `lib/localization/form_builder_localizations.dart` and include the language like so:

<pre>
<code>
@override
  bool isSupported(Locale locale) {
    return ['en', 'es', <strong>'fr'</strong>].contains(locale.languageCode);
  }
</code>
</pre>

6. Submit your PR and be of help to millions of people all over the world!

### Coffee :-)
If this package was helpful to you in delivering your project or you just wanna to support this
package, a cup of coffee would be highly appreciated ;-)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)

