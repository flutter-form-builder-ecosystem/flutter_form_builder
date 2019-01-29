## [1.4.0] - 29-Jan-2019
* The entire form or individual controls can now be made readonly by making `readonly` property to `true`. Default value is `false`. Closes [#11](https://github.com/danvick/flutter_form_builder/issues/11) and[#16](https://github.com/danvick/flutter_form_builder/issues/16)

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
* Moved ChipsInput into own library on pub.dartlang.org, check it out [here](https://pub.dartlang.org/packages/flutter_chips_input)
* Updated example code to include proper use of Form's `onChanged` function after update. Closes [#8](https://github.com/danvick/flutter_form_builder/issues/8)

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
* Fixed bug where validation not working for fields outside screen (when using ListView) - [Flutter Issue #17385](https://github.com/flutter/flutter/issues/17385)
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









