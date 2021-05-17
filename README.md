
# Flutter Form Builder
---
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/danvick/flutter_form_builder/CI?logo=github&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/actions?query=workflow%3ACI)
[![Codecov](https://img.shields.io/codecov/c/github/danvick/flutter_form_builder?logo=codecov&style=for-the-badge)](https://codecov.io/gh/danvick/flutter_form_builder/)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/danvick/flutter_form_builder?logo=codefactor&style=for-the-badge)](https://www.codefactor.io/repository/github/danvick/flutter_form_builder)
[![GitHub](https://img.shields.io/github/license/danvick/flutter_form_builder?logo=open+source+initiative&style=for-the-badge)](https://github.com/danvick/flutter_form_builder/blob/master/LICENSE)
[![OSS Lifecycle](https://img.shields.io/osslifecycle/danvick/flutter_form_builder?style=for-the-badge)](#support)
<!-- [![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-FC60A8?logo=awesome-lists&style=for-the-badge)](https://github.com/Solido/awesome-flutter#widgets) -->

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)

___

Flutter Form Builder provides an easy way of working with forms in Flutter by removing the boilerplate needed to build a form, validate fields, react to changes, and collect final user input.

## Plugins

**Table of contents:**

- [FormBuilder Core (`flutter_form_builder`)](#flutter_form_builder)
- [FormBuilder Extra Fields (`form_builder_extra_fields`)](#form_builder_extra_fields)
- [FormBuilder Fields (`form_builder_fields`)](#form_builder_fields)
- [FormBuilder Validators (`form_builder_validators`)](#form_builder_validators)

### flutter_form_builder
> [![Pub Version](https://img.shields.io/pub/v/flutter_form_builder?logo=flutter&style=for-the-badge)](https://pub.dev/packages/flutter_form_builder)

FormBuilder helps in creation of data collection forms in Flutter by removing the boilerplate needed to build a form, validate fields, react to changes,
and collect final user input.
This package provides APIs to manage your Form and generating a FormBuilder compliant FormField. It is required by `form_builder_fields` and `form_builder_extra_fields` packages.

[[View Documentation][core_docs]] [[View Source][core_code]]

### form_builder_extra_fields
> [![Pub Version](https://img.shields.io/pub/v/form_builder_extra_fields?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_extra_fields)

Form Builder Fields provides ready-made form input fields. Just like the form_builder_fields package, it gives you a convenient way of adding fields instead of creating your own FormBuilderField from scratch.

Unlike form_builder_fields package which depends purely on Flutter provided input fields, flutter_extra_fields depends on external libraries to provide input widgets and extends them to be FormBuilderFields.

[[View Documentation][extra_fields_docs]] [[View Source][extra_fields_code]]


### form_builder_fields
> [![Pub Version](https://img.shields.io/pub/v/form_builder_fields?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_fields)

Form Builder Fields provides common ready-made form input fields. The package gives you a convenient way of adding fields instead of creating your own FormBuilderField from scratch.

[[View Documentation][fields_docs]] [[View Source][fields_code]]


### form_builder_validators
> [![Pub Version](https://img.shields.io/pub/v/form_builder_validators?logo=flutter&style=for-the-badge)](https://pub.dev/packages/form_builder_validators)

Form Builder Validators provide a convenient way of validating data entered into any Flutter FormField. It provides common validation rules out of box (such as required, email, number, min, max, minLength, maxLength, date validations) as well as a way to compose multiple validation rules into one FormFieldValidator.

Also included is the `l10n` / `i18n` of error text messages into multiple languages

[[View Documentation][validators_docs]] [[View Source][validators_code]]


## Support
If this set of packages was helpful to you in delivering your on project or you just wanna to support this
repo, a cup of coffee would go a long way ;-)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)


## Credits
**Contributors**

<a href="https://github.com/danvick/flutter_form_builder/graphs/contributors">
  <img src="https://contributors-img.firebaseapp.com/image?repo=danvick/flutter_form_builder" />
</a>

Made with [contributors-img](https://contributors-img.firebaseapp.com).







[core_code]: https://github.com/danvick/flutter_form_builder/tree/split_packages/packages/flutter_form_builder

[core_docs]: https://github.com/danvick/flutter_form_builder/blob/split_packages/packages/flutter_form_builder/README.md

[extra_fields_code]: https://github.com/danvick/flutter_form_builder/tree/split_packages/packages/form_builder_extra_fields

[extra_fields_docs]: https://github.com/danvick/flutter_form_builder/blob/split_packages/packages/form_builder_extra_fields/README.md

[fields_code]: https://github.com/danvick/flutter_form_builder/tree/split_packages/packages/form_builder_fields

[fields_docs]: https://github.com/danvick/flutter_form_builder/blob/split_packages/packages/form_builder_fields/README.md

[validators_code]: https://github.com/danvick/flutter_form_builder/tree/split_packages/packages/form_builder_validators

[validators_docs]: https://github.com/danvick/flutter_form_builder/blob/split_packages/packages/form_builder_validators/README.md

