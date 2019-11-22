## [3.6.1] - 6-Nov-2019
* Fixed bug caused by dropping unimplemented attribute `onChipTapped` of `flutter_chips_input`. Closes [#168](https://github.com/danvick/flutter_form_builder/issues/168)

## [3.6.0] - 4-Nov-2019
* Added clear option to FormBuilderDropdown - set `allowClear` to true. Closes [#148](https://github.com/danvick/flutter_form_builder/issues/148)
* Default `contentPadding` and `border` attributes removed from CheckboxList, Radio and SegmentedControl list. Closes [#160](https://github.com/danvick/flutter_form_builder/issues/160)
* Added `numberFormat` attribute to Slider. Closes [#156](https://github.com/danvick/flutter_form_builder/issues/156)
* Add error text to date range picker. Thanks to [ffpetrovic](https://github.com/ffpetrovic)
* Fixed bug where pushing cancel on timePicker causes crash. Thanks to [ayushin](https://github.com/ayushin)
* Fixed bug where Switch doesn't obey initialValue from FormBuilder. Closes [#159](https://github.com/danvick/flutter_form_builder/issues/159)
* Fixed bug where FormBuilderDropdown shows value instead of label when disabled/readOnly. Closes [#154](https://github.com/danvick/flutter_form_builder/issues/154)
* Fixed bug where FormBuilderDateTimePicker value is parsed from TextField string. Closes [#164](https://github.com/danvick/flutter_form_builder/issues/164)
* Added default TextInputConfiguration options for ChipsInput
* Fix example project - AndroidX compatibility. Thanks to [prasadsunny1](https://github.com/prasadsunny1)
* Bumped up `flutter_typeahead` 1.6.1 -> 1.7.0

## [3.5.5] - 3-Oct-2019
* Bumped up `flutter_chips_input` version from 1.3.1 to 1.5.1
* AndroidX migration for example app

## [3.5.4] - 16-Sep-2019
* Fix dependency mismatch for `intl` with `flutter_localizations` from sdk
* Bumped up `datetime_picker_formfield` dependency version

## [3.5.3] - 11-Sep-2019
* Fixed DateTimePicker bug: '`DateTime is not a subtype of type TimeOfDay`' when Input type is Time only. Closes [#131](https://github.com/danvick/flutter_form_builder/issues/131)

## [3.5.2] - 03-Sep-2019
* Re-introduced `onSuggestionSelected` option in TypeAhead field

## [3.5.1] - 02-Sep-2019
* Hack to avoid manual editing of date - as is in DateTimeField library

## [3.5.0] - 30-Aug-2019
* **NEW FIELD TYPE**: `FormBuilderDateRangePicker`
* New method `saveAndValidate` method to `FormBuilder`
* Ability to use custom data types in TypeAhead field instead of just String
* `FormBuilderDateTimePicker` fixes
    * Fixed bug where currently selected date is cleared when DateTimePicker dialog is shown
    * Also fixed bug where currently selected date not used as initial date in DateTimePicker dialog
    * `initialTime` and `initialDate` deprecated - brings confusion with `initialValue`. Selected date/time or current date/time will be used instead
* **BREAKING CHANGE**: Changed type of `resetIcon`in DateTimePicker from `IconData` to `Icon`

## [3.4.1] - 21-Aug-2019
* Fixed bug in `FormBuilderDateTimePicker` where `initialValue` defaults to null

## [3.4.0] - 21-Aug-2019
* Converted `FormBuilderFieldOption` to Widget with `child` attribute - allows option to be customized/styled
* Fixed bug in `FormBuilderCheckboxList` where new items cannot be added
* Allow `null` value on checkbox if `tristate` is enabled
* Adding InputBorder on `FormBuilderDropdownField` now possible
* Fixed bug where initial date not shown for `FormBuilderDateTimePicker`

## [3.3.4] - 08-Aug-2019
* Added `initialValue` field to `FormBuilderCustomField`

## [3.3.3] - 08-Aug-2019
* Attempt to fix issue where user is required to manually edit `FormBuilderDateTimePicker` if not empty - instead of presenting Date/Time Picker

## [3.3.2] - 07-Aug-2019
* Upgrade dependency `datetime_picker_formfield` from v0.4.0 to 1.0.0-pre.2 (aka v0.4.1)
* Removed `editable` option from `FormBuilderDateTimePicker` - removed from dependency `datetime_picker_formfield` 

## [3.3.1] - 28-Jul-2019
* Fixed bugs in `FormBuilderDateTimePicker`
* Minor improvements to documentation

## [3.3.0] - 28-Jul-2019
* New Feature: You can now set `initialValue` for `FormBuilder` - Accepts a `Map<String, dynamic>` where keys are `attribute`s and the values are `initialValue`s for corresponding fields
* New Field: `FormBuilderRangeSlider`
* Compatibility with newly released Flutter version `1.7.*`
* `Breaking change:` Renamed occurrences of `readonly` to `readOnly` to fit naming conventions 
* Updated `datetime_picker_formfield` to version `0.4.0` from `0.2.0`
* Added more attribute options for different fields

## [3.2.9] - 20-Jul-2019
* Added `borderColor`, `selectedColor`, `pressedColor`, `textStyle` options to `FormBuilderSegmentedControl` for `CupertinoSegmentedControl` customization

## [3.2.8] - 12-Jul-2019
* Added `activeColor`, `checkColor`, `materialTapTargetSize` & `tristate` options to `FormBuilderCheckbox` and `FormBuilderCheckboxList` for checkbox customization

## [3.2.7] - 06-Jul-2019
* Fixed bug where `valueTransformer`s not working

## [3.2.6] - 06-Jul-2019
* If disabled dropdown has value, show value instead of `disabledHint`

## [3.2.5] - 05-Jul-2019
* Fixed Stack Overflow bug in `setAttributeValue` function

## [3.2.4] - 03-Jul-2019
* Fixed issue in saving form attribute values - Credit [Caciano Kroth](https://github.com/cacianokroth) & [eltonmorais](https://github.com/eltonmorais)

## [3.2.3] - 25-Jun-2019
* Allow `readonly` attribute for fields to be changed at runtime. Credit [Daniel Acorsi](https://github.com/dhaalves). Closes [#75](https://github.com/danvick/flutter_form_builder/issues/75)

## [3.2.2] - 22-Jun-2019
* Bumped up `flutter_chips_input` from v1.2.0 to 1.3.0

## [3.2.1] - 22-Jun-2019
* Add missing attributes for `FormBuilderSlider` to customize `Slider` Widget including `activeColor`, `inactiveColor`, `onChangeStart`, `onChangeEnd`, `label` and `semanticFormatterCallback`. Closes [#80](https://github.com/danvick/flutter_form_builder/issues/80).
* Add support for `underline` to `FormBuilderDropdown`. Credit [Jordan Nelson](https://github.com/jrnelson333).
* Minor fixes to README

## [3.2.0] - 07-Jun-2019
* Bumped up `flutter_typeahead` from v1.5.0 to 1.6.1
* Bumped up `datetime_picker_formfield` from v0.1.8 to 0.2.0

## [3.1.3] - 06-Jun-2019
* Made `flutter_typeahead`'s `onSuggestionSelected` available to `FormBuilderTypeAhead` - Closes [#73](https://github.com/danvick/flutter_form_builder/issues/73). Credit to [daWeed](https://github.com/psrcek)

## [3.1.2] - 27-May-2019
* Attempted fix for `FormBuilderTextField` retaining focus even after moving to other fields causing the UI to jump back to the TextField
* Improved documentation for `FormBuilderCustomField`

## [3.1.1] - 16-May-2019
* Fixed sample code in README for example project
* Bumped up `flutter_typeahead` from v1.4.0 to 1.5.0

## [3.1.0] - 15-May-2019
* Added `leadingInput` option for CheckboxList, Checkbox and Radio - Allows the option to have the input before its label (left). Courtesy of [Sven Schöne](https://github.com/SvenSchoene)

## [3.0.1] - 28-Apr-2019
* Fixed bug in where `focuNode` for `FormBuilderTextField` is ignored. Closes [#53](https://github.com/danvick/flutter_form_builder/issues/53)
* Fixed bug in where `textEditingConfiguration` for `FormBuilderTypeAhead` ignored

## [3.0.0] - 24-Apr-2019
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
    * `BuildContext` is not passed down into `FormBuilder`
* Fixed URL validator works correctly - tested
* Improved documentation

## [2.0.3] - 26-Mar-2019
* Allow `null`s in `FormBuilder` controls `attribute`

## [2.0.2] - 26-Mar-2019
* Minor fix in documentation

## [2.0.1] - 26-Mar-2019
* Fixed bug where fields keep losing focus

## [2.0.0] - 25-Mar-2019
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


## [1.5.1] - 21-Mar-2019
* Fixed bugs originating from upgrading `flutter_typeahead` from v0.5.1 to v1.2.1

## [1.5.0] - 20-Mar-2019
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









