## [3.0.0] - 24-April-2019
* Complete rewrite of the package - stateful field widgets
    * `FormBuilderCheckbox` - Single Checkbox field
    * `FormBuilderCheckboxList` - List of Checkboxes for multiple selection
    * `FormBuilderChipsInput` - Takes a list of Flutter [Chip](https://docs.flutter.io/flutter/material/Chip-class.html) as inputs
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
* New `FormBuilderCustomField` to create of custom `FormField`s
* New attribute `validators` allows composability and reusability of different `FormFieldValidator` 
functions that do different validations
* New Feature `FormBuilderValidators` comes with common validation functionality options such as: 
required, min, max, minLength, maxLength, email, url, credit card etc.
* Added `valueTransformer` - transforms field value before saving to the final form value
* Added requested `onChanged` value notifier event on fields. Closes [#45](https://github.com/danvick/flutter_form_builder/issues/45)
* Prevent duplicate `attribute` names in fields - assertion
* **Breaking changes:**
    * `FormBuilderInputOption` becomes `FormBuilderFieldOption`
* Fixed URL validator works correctly - tested
* Improved documentation


## [3.0.0-beta.10] - 20-April-2019
* Unregister field from `Formbuilder` when its dispose method is called. Avoids assertion fail when re-added back to the widget tree

## [3.0.0-beta.9] - 15-April-2019
* Added property `fields` to FormBuilder, gives access to the current state of each field through a Map of `GlobalKey<FormFieldState<dynamic>>`s. 
This gives us access to the underlying FormField which in turn allows us: 
    * Do conditional validation based on other fields (check readme)
    * Dynamically update field values

## [3.0.0-beta.8] - 10-April-2019
* Fixed unhandled exception when `valueTransformer` tries to convert value from predefined `FormField` type

## [3.0.0-beta.7] - 09-April-2019
* Check if value candidate is of type String, Iterable or Map before checking length to determine empty in `FormValidators.required`

## [3.0.0-beta.6] - 09-April-2019
* Properly hooked up SignaturePad to form, added onChanged to it
* SignaturePad now returns `Uint8List` object from `png` image

## [3.0.0-beta.5] - 08-April-2019
* Minor documentation improvements - hint for GlobalKey definition, table rendering issue in README

## [3.0.0-beta.4] - 08-April-2019
* **Breaking changes:**
    * `FormBuilderInputOption` becomes `FormBuilderFieldOption`
    * `FormBuilderField` becomes `FormBuilderCustomField`
* Improved documentation
* added `valueTransformer` - transforms field value before saving to form value

## [3.0.0-beta.3] - 07-April-2019
* Bumped up `flutter_typeahead` dependency from `^1.2.1` to `^1.4.0`
* Fixed URL validator works correctly - tested
* Added more validators:
    * IP
    * Credit Card
    * Date
* Added requested `onChanged` value notifier event on fields. Closes [#45](https://github.com/danvick/flutter_form_builder/issues/45)

## [3.0.0-beta.2] - 04-April-2019
* Disabled `TextFormField.strutStyle` from `FormBuilderTextField` breaks in v1.2.1 of Flutter - current stable at release

## [3.0.0-beta.1] - 04-April-2019
* Complete rewrite of the package - stateful
* Contains `FormBuilderField` for creation of custom `FormField`s
* New attribute `validators` allows composability and reusability of different `FormFieldValidator` 
functions that do different validations
* New Feature `FormBuilderValidators` comes with common validation functionality options such as: 
required, min, max, 

## [2.0.3] - 26-March-2019
* Allow `null`s in `FormBuilder` controls `attribute`

## [2.0.2] - 26-March-2019
* Minor fix in documentation

## [2.0.1] - 26-March-2019
* Fixed bug where fields keep losing focus

## [2.0.0] - 25-March-2019
### New Features and fixes
* New attribute `decoration` for `FormBuilderInput`. Enables one to customize `InputDecoration` 
like icons, labelStyles etc
* Added ability to add `GlobalKey` of type `FormBuilderState` to FormBuilder that will be 
the handle to the
state of the form enabling saving and resetting. Similar to using Flutter's `Form`.
* Added new input type `FormBuilder.signaturePad` which provides a drawing pad for user signature
* Added `max` attribute to `chipsInput` to limit the number of chips users can add
* Added new attribute `maxLines` to be used with textFields with multiple lines
* Fixed bug where readonly not working to Date, Time and DateTime Pickers

### Breaking Changes
* Removed reset/submit buttons and corresponding attributes: `showResetButton`, `resetButtonContent`
Access form state using a `GlobalKey<FormBilderState>`
* Removed `label` and `hint` attributes to be replaced by `decoration`


## [1.5.1] - 21-March-2019
* Fixed bugs originating from upgrading `flutter_typeahead` from v0.5.1 to v1.2.1

## [1.5.0] - 20-March-2019
* Now using `datetime_picker_formfield` plugin from pub for DatePicker and TimePicker. 
Should close [#33](https://github.com/danvick/flutter_form_builder/issues/33)
* Added new `FormBuilderInput` - DateTimePicker
* **Breaking change**: DatePicker, TimePicker & DateTimePicker now return an object of 
type `DateTime` instead of `String`
* Upgraded `flutter_typeahead` from v0.5.1 to v1.2.1 - comes with more widgets options

## [1.4.0] - 29-Jan-2019
* The entire form or individual controls can now be made readonly by making `readonly` property 
to `true`. Default value is `false`. 
Closes [#11](https://github.com/danvick/flutter_form_builder/issues/11) and 
[#16](https://github.com/danvick/flutter_form_builder/issues/16)

## [1.3.5] - 28-Jan-2019
* Fixed bug on Slider where current value not updated on slider & label

## [1.3.4] - 19-Jan-2019
Bug fix: Imported `dart:async` for use of `Future`s to be compatible with Dart <2.1

## [1.3.3] - 17-Jan-2019
* Updated `flutter_typeahead` version. Closes [#15](https://github.com/danvick/flutter_form_builder/issues/15)

## [1.3.2] - 19-Dec-2018
* Allow setting of `format` for DatePicker
* Fixed bug where `lastDate` and `firstDate` for DatePicker don't work

## [1.3.1] - 17-Dec-2018
* Moved ChipsInput into own library on pub.dartlang.org, 
check it out [here](https://pub.dartlang.org/packages/flutter_chips_input)
* Updated example code to include proper use of Form's `onChanged` function after update. 
Closes [#8](https://github.com/danvick/flutter_form_builder/issues/8)

## [1.3.0] - 15-Dec-2018
* Fixed bug where TypeAhead value reset when other fields are updated
* `onChanged` function for FormBuilder is now called with current form values (breaking change)
* Form reset now works as expected
* Other minor refactorings

## [1.2.0] - 23-Nov-2018
* New `FormBuilderInput` types:  
    * ChipsInput
* Some bug fixes
* Minor UI improvements
* Some bugs introduced, to be fixed later

## [1.1.0] - 19-Nov-2018
* Fixed bug where validation not working for fields outside screen (when using ListView) - 
[Flutter Issue #17385](https://github.com/flutter/flutter/issues/17385)
* Added InputDecoration for all custom FormFields

## [1.0.2] - 7-Nov-2018
* Fixed bug in (un)selecting checkbox list using by clicking its label

## [1.0.1] - 3-Nov-2018
* Minor improvements to documentation, added known issues section too

## [1.0.0] - 3-Nov-2018
### Features
* New `FormBuilderInput` types:  
    * Phone
    * Stepper
    * Rate
    * SegmentedControl
* `min` and `max` validation added to number field and textField
* More specialized keyboard types for TextField control types (text, number, url, email, multiline, phone etc)
* Tapping on Label for radio/checkbox changes the control value
* Created new constructors for password and textField inputs
* Added resetButton

### Fixes 
* Fixed bug where `TYPE_TEXT` validates as `TYPE_EMAIL` - Closes [#1](https://github.com/danvick/flutter_form_builder/issues/1)
* Fixed initial value setting `FormBuilderInput.checkboxList()`

### Breaking Changes
* `placeholder` attribute of class `FormBuilderInput` renamed to `hint`
* Removed default constructor for `FormBuilderInput`

## [0.0.1] - 1-Nov-2018.
* Initial Release
* Input Types: 
    * Text 
    * Number 
    * Email
    * MultilineText
    * Password
    * Radio
    * CheckboxList
    * Checkbox
    * Switch
    * Slider
    * Dropdown
    * DatePicker
    * TimePicker
    * Url
    * TypeAhead









