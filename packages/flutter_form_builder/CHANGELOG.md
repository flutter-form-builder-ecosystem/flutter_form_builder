## [7.0.0] - 27-Oct-2021
**BREAKING CHANGE**:
* For ease of maintainability, validation functionality has been broken up into a separate package: [form_builder_validators](https://pub.dev/packages/form_builder_validators)

## [7.0.0-beta.0] - 02-Sep-2021
* Merged back `form_builder_fields` into `flutter_form_builder`

## [7.0.0-alpha.3] - 01-Sep-2021
* When form validation fails, automatically scroll to first error
* New way to programmatically induce custom errors by calling `GlobalKey<FormBuilderState>.invalidateField()` or `GlobalKey<FormBuilderFieldState>.invalidate()`
* Remove field from internal value map on when a field is unregistered

## [7.0.0-alpha.2] - 17-May-2021
* Improvements to package documentation and example

## [7.0.0-alpha.1] - 16-May-2021
* Fix package naming in alpha.0

## [7.0.0-alpha.0] - 16-May-2021
* Split up packages - removed fields and validation from core

## [6.2.1] - 27-Oct-2021
* Fixed bug where `didChange` and `reset` on FormBuilderCheckboxGroup has no visible effect

## [6.2.0] - 21-Oct-2021
* Fixed `didChange` unable to handle null value in  `FormBuilderTextField`

**BREAKING CHANGE**
* Added new attribute - `autoFocusOnValidationFailure` (default: `false`) - to FormBuilder to set whether should scroll to first error if validation fails


## [6.1.0] - 01-Sep-2021
* When form validation fails, automatically scroll to first error
* New way to programmatically induce custom errors by calling `GlobalKey<FormBuilderState>.invalidateField()` or `GlobalKey<FormBuilderFieldState>.invalidate()`
* Added Arabic and Persian/Farsi locales
* Made maxLines property nullable and added assertions
* Remove field from internal value map on when a field is unregistered
* Fix checkbox issue with null values

## [6.0.1] - 19-May-2021
* Add whitespace check for required validator
* Null-safety and type fixes
* Dispose off registered listeners (#799)

## [6.0.0] - 20-Apr-2021
* Re-introduced DateTimePicker field without external dependencies
* Minor fixes

## [6.0.0-nullsafety.1] - 24-Mar-2021
* Static analysis improvements
* Documentation improvements

## [6.0.0-nullsafety.0] - 24-Mar-2021
* Started working on null-safety

**BREAKING CHANGES**:
* Removed fields that depend on external dependencies incuding: `FormBuilderChipsInput`, `FormBuilderColorPicker`, `FormBuilderRating`, `FormBuilderSearchableDropdown`, `FormBuilderSignaturePad`, `FormBuilderTouchSpin`, `FormBuilderTypeAhead`

## [5.0.0] - 24-Mar-2020
* Flutter 2.* support

## [4.2.0] - 29-Dec-2020
* Added support for Slovak (sk) - @cek-cek

**BREAKING CHANGES**:
* Removed file picker field from package - moved to [form_builder_file_picker](https://pub.dev/packages/form_builder_file_picker) package.
* Removed image picker field from package - moved to [form_builder_image_picker](https://pub.dev/packages/form_builder_image_picker) package.
* Removed phone field field from package - moved to [form_builder_phone_field](https://pub.dev/packages/form_builder_phone_field) package.

## [4.1.0] - 18-Dec-2020
* Added support for Portuguese (pt)
* Added support for Japanese (ja)
* Added `FormBuilderValidators.notEqual` validator
* Fix bug in `RadioGroup` where reset and didChange doesnt affect UI. Fixes #646, Fixes #647
* Image picker fix: Added null-safe spread operator for `field.value`. Fixes #607
* Fixed focus issue  in `ChipsInput`
* Fixed bug `SearchableDropdown` where setting value programmatically does not update UI. Fixes #627
* Upgraded flutter_typeahead to 1.9.1.

## [4.0.2] - 27-Nov-2020
* Fixed issue in Typeahead field where didChange not call and onChanged fired. Closes #595
* Fixed issue where french not included in list of supported languages & translations not working. Closes #561

## [4.0.1] - 24-Nov-2020
* Fixed bug where `FormBuilderField` couldn't be used to create custom fields
* Corrected documentation for equal validator

## [4.0.0] - 23-Nov-2020
**IMPROVEMENTS**:
* New fields: `FormBuilderFilePicker`, `FormBuilderSearchableDropdown`, `FormBuilderCheckboxGroup`
* Localization of validation error texts
* Added external validation. Setting `InputDecoration.errorText` which invalidates the field.
* New validators: `FormBuilderValidators.integer`, `FormBuilderValidators.equal`
* Improved programmatically changing field values.
* Add to `FormBuilderField.onReset` callback - to enable reaction to resetting by changing the UI to reflect reset
* Add option to remove disabled field values from the final form value using `skipReadOnly` field.
* Number of Chips to be selected in FilterChip can now be limited by setting `maxChips` attribute. Closes #500
* Use localized text for OK and CANCEL button labels for ColorPicker dialog
* For default DateTimePicker format, use localized DateTime formats
* Added option for user to set own `border` for `FormBuilderSignaturePad`
* Improvements to example: break down to several pages; also show code in example app

**FIXES**:
* RadioGroup and CheckboxGroup labels not wrapping in vertical mode. Fixes #474
* Allow changing `enabled` and `initialValue` at runtime. Closes #515
* Hide floating label if field is empty
* Fixed bug in DateRangePicker where user can just pick one date
* ColorPicker, DateRangePicker, DateTimePicker - set TextField readOnly to true. Prevents keyboard popup
* Fixed label overflows in RadioGroup & CheckboxGroup fields
* Renamed `updateFormAttributeValue` to `setInternalAttributeValue` to avoid confusion

**BREAKING CHANGES**:
* Renamed `attribute` option in all fields to `name`
* Done away with `validators` attribute, use normal `validator`. Use `FormBuilderValidators.compose()` to compose multiple `FormFieldValidator`s into one
* Attribute `readOnly` replaced by `enabled` - this was done to match Flutter's `FormField` naming convention
* Renamed `FormBuilderRate` to `FormBuilderRating`
* Renamed `FormBuilderValidators.IP()` to `FormBuilderValidators.ip()`
* Removed CountryPicker field because of limited use. Replaced with SearchableDropdown with similar functionality but not only limited to countries.
* Use signature: ^3.0.0 package instead of self-maintained - comes with breaking changes.

## [4.0.0-pre.9] - 22-Nov-2020
* Upgraded to latest `file_picker` -  adds `withReadStream` option for processing large files
* Fixed issue where `initialValue` working on SignaturePad
* Fixed issue where SignaturePad still accepts imput when `enabled` is set to `false`
* Attempted fixes to `FocusNode` leaks
* Inline documentation and README improvements

## [4.0.0-pre.8] - 21-Nov-2020
* Added enabled attribute to FormBuilder to allow disabling the whole form
* Passed FocusNode through to super class. Also removed listeners when added.

## [4.0.0-pre.7] - 18-Nov-2020
* **BREAKING CHANGE**: Removed FormBuilderLocationField. Version 1 of [form_builder_map_field](https://pub.dev/packages/form_builder_map_field) to be used. Closes #491

## [4.0.0-pre.6] - 13-Nov-2020
* **BREAKING CHANGE**: Attribute `readOnly` replaced by `enabled` - this was done to match Flutter's `FormField` naming convention
* **BREAKING CHANGE**: To programatically set values use original `didChange()` method instead of `patchValue()`
* New validator for integer values
* Add option to remove `readOnly` field values from the final form value using `skipReadOnly` field. Closes #501
* RadioGroup and CheckboxGroup labels not wrapping in vertical mode. Fixes #474
* Allow changing `readOnly` and `initialValue` at runtime. Closes #515
* Expanded the list of supported image file extensions to match Flutter's
* Fixed bug where email validator was returning match validator `errorText`

## [4.0.0-pre.5] - 24-Oct-2020
* Number of Chips to be selected in FilterChip can now be limited by setting `maxChips` attribute. Closes #500
* After calling patchValue on TextField, take cursor to end of text. Closes #477
* Fix compile error in SearchableDropdown caused by breacking change in `dropdown_search` package. Closes #507
* Fixed bug: calling patchValue on DateTimePIcker doesn't update TextField. Closes #505
* Fixed regression in DateTimePicker where field didn't work. Closes #496
* Documentation improvements

## [4.0.0-pre.4] - 06-Oct-2020
* Added new field: FilePicker
* Included v3 to v4 migration guide to README
* Ensure options disabled for RadioGroup & CheckboxGroup if readOnly
* Prevent events from happening while picking image (#460)
* Use localized text for ok and cancel button labels for ColorPicker dialog
* Minor improvements and documentation added for LocationField

## [4.0.0-pre.3] - 02-Oct-2020
* Changed Version naming for release candidates from `-RC.*` to `-pre.*`

## [4.0.0-RC.2] - 02-Oct-2020
* More documentation improvements

## [4.0.0-RC.1] - 02-Oct-2020
* Added compatibility for Flutter v1.22
* Documentation improvements
* hide floating label if field is empty
* Add default placeholder image for ImagePicker
* For default DateTimePicker format, use localized DateTime formats
* Fixed bug in DateRangePicker where user can just pick one date
* Fix bug in dropdown where setting enabled to false doesn't affect input. Closes #450
* Bumped flutter_chips_input from v1.9.3 to v1.9.4
* **BREAKING CHANGE**: Removed CountryPicker field because of limited use. Replaced with SearchableDropdown with similar functionality but not only limited to countries.

## [4.0.0-beta.5] - 05-Sep-2020
* Finished implementation of `FormBuilderSearchableDropdown`.
* Deprecated `FormBuilderCountryPicker` - redundant due to `FormBuilderSearchableDropdown` inclusion.

## [4.0.0-beta.4] - 04-Sep-2020
* Fix for label overflows in Radio & Checkbox Groups
* Fixed bug in `FormBuilderDateRangePicker` where if dialog dismissed, current value is cleared
* Fix bug where changes from user defined `TextEditingController` in `FormBuilderTextField` not detected. Closes #448
* Improvements to documentation

## [4.0.0-beta.3] - 31-Aug-2020
* Fixed bug where validate() always returns true. Closes #440

## [4.0.0-beta.2] - 22-Aug-2020
* Added new field FormBuilderLocationField
* Use latest flutter_datetime_picker. Fixes `"Error: Type 'DiagnosticableMixin' not found"`. Closes #406
* Fixed bug where initialValue not set in DateTimePicker. Closes #425
* Fixed issue where equal validator yields required errorText
* Fixes to focus and focusNodes, check if field is touched.

## [4.0.0-beta.1] - 09-Aug-2020
* Flutter v1.20 improvements
* Fix bug in `FormBuilderValidators.numeric` if valueCandidate is `null`
* Renamed `pattern` validator to `match`.
* Rename `requireTrue` validator to `equal` to allow equality check with other types. Closes #397
* Fix bug in parsing phone number from `FormBuilderPhoneField.initialValue`

## [4.0.0-alpha.9] - 05-Aug-2020
* Improved programmatically changing field values. Multiple fields can be updated once
* Fix conversion to double error in `FormBuilderRating`
* Removed redundant `FormBuilderRadioList` and `FormBuilderCheckboxList` fields
* Other minor fixes from v3 commits

## [4.0.0-alpha.8] - 23-Jul-2020
* Fixed erratic keyboard behavior on `FormBuilderTextField`
* Added documentation for `FormBuilder` & `FormBuilderField` attributes
* Fixed issue where `FormBuilderRadioGroup` not submitting value

## [4.0.0-alpha.7] - 22-Jul-2020
* Added new field - `FormBuilderCheckboxGroup`. Closes #188,
* New `FormBuilderRadioGroup` implementation similar to `FormBuilderCheckboxGroup`. Fixes issue where `FormBuilderFieldOption.child` is ignored Closes #335
* Set FocusTraversalGroup policy
* Fixed bug where TextField where `initialValue` from `FormBuilder` is ignored. Closes #370

## [4.0.0-alpha.6] - 20-Jul-2020
* Added focusNode to all fields.
* Attempted tab/next support - work in progress
* Request Focus to Field when change is attempted.
* Include guide to programmatically inducing errors to README. Closes #123
* Fixed bug in Localization where `Locale.countrycCode` is `null`. Closes #369
* Added more options to DatePicker for showDatePicker() Flutter function
* Rename `updateFormAttributeValue` to `setInternalAttributeValue` to avoid confusion

## [4.0.0-alpha.5] - 08-Jul-2020
* Improvements to dirty check for FormBuilderField - fixes autovalidate only when dirty

## [4.0.0-alpha.4] - 04-Jul-2020
* Added static getter for FormBuilderLocalizations delegate
* Fix issue where setting app localization is required for built-in validation to work

## [4.0.0-alpha.3] - 01-Jul-2020
* Localize validation error texts
* Dropped `country_picker` package for `country_code_pickers` in PhoneField which supports localized countries
* Allow setting of `InputDecoration.errorText` which invalidates the field. Allows external validation like server validation
* ColorPicker show Hexadecimal code in TextField instead of `Color.toString()`
* Do away with validators attribute, use normal validator instead of list of validators
* Added `FormBuilderValidators.compose()` which composes multiple `FormFieldValidator`s into one
* ColorPicker, DateRangePicker, DateTimePicker - set TextField readOnly to true. Prevents keyboard popup
* Improvements to example: break down to several pages; also show code in example app

## [3.14.1] - 24-Oct-2020
* Remove phone number validation internally. Closes #499
* Include padding option for ChoiceChips. Closes #504

## [3.14.0] - 02-Oct-2020
* Added support for Flutter v1.22

## [3.14.0-alpha.4] - 30-Sep-2020
* Include changes made in v3.13.5 & v3.13.6
* Fix build for flutter >=1.21.0-9.1.pre

## [3.13.6] - 25-Sep-2020
* Fixed bug in DateRangePicker where user can just pick one date. Closes #434
* Fix bug where FormBuilderCheckboxGroup value set to widget.initialValue. Closes #467
* Prevent events from happening while picking image with ImagePicker
* Added null check for val in onSaved and validator
* Fix `GroupedCheckbox` not disabled when read only
* Added phone validation and fixed `initialValue` parsing
* Fix `Image.memory` throwing error when value is `null`

## [3.13.5] - 08-Sep-2020
* Fixed bug in `DateRangePicker` where `onChanged` fires before change. Closes #434
* Use app's locale for default DateTimePicker display formatting
* Update to latest `flutter_chips_input`. Fixes #415

## [3.14.0-alpha.3] - 22-Aug-2020
* Include changes made in v3.13.4

## [3.13.4] - 27-Aug-2020
* Fixed bug where `CountryPicker.onSaved` breaks if value is null
* Fixed bug where `initialValue` not saved
* Fix for label overflows in `RadioGroup` & `CheckboxGroup`
* Upgrade to latest `flutter_chips_input`. Fixes bugs in Flutter pre-release channels

## [3.14.0-alpha.2] - 22-Aug-2020
* Include changes made in v3.13.3

## [3.13.3] - 22-Aug-2020
* Fix bug where CountryPicker still works in readOnly. Closes #413
* Fixed bug where onChanged is not fired in CountryPicker. Closes #424
* Allow null initialValue for CountryPicker. Closes #421
* Minor improvements for ImagePicker on web platform. Closes #414
* Added video tutorial reference to README

## [3.14.0-alpha.1] - 11-Aug-2020
* Fixed `RangeSemanticFormatterCallback` error. Changed field with `SemanticFormatterCallback`.

## [3.13.2] - 11-Aug-2020
* Added `defaultImage` attribute to `FormBuilderImagePicker`, acts as placeholder. Courtesy [luwenbin8023](https://github.com/luwenbin8023)
* Fix bug in `FormBuilderCheckboxGroup` where `InputDecoration` isn't enabled. Closes #405
* Fix issue where form's initialValue would potentially be ignored. Fixes #341

## [3.13.1] - 08-Aug-2020
* Added default value to `timePickerInitialEntryMode` to be consistent with `showTimePicker` API. Closes #403
* Ensure `TextEditingController`s aren't unused and are properly disposed.
* Use latest version of `flutter_chips_input` with fix for "Bad UTF-8 found..."

## [3.13.0] - 06-Aug-2020
* Added support for Flutter v1.20

## [3.12.3] - 05-Aug-2020
* Fixed bug in parsing phone number from `FormBuilderPhoneField`'s `initialValue`
* Added more TextField options: `toolbarOptions`, `smartQuotesType`, `smartDashesType`, `scrollPhysics`, `enableSuggestions`
* Fixed `onChanged` bug on TextField

## [3.12.2] - 03-Aug-2020
* Convert FormBuilderRating value to double for RatingBar. Closes #392

## [3.12.1] - 03-Aug-2020
* Deprecate `FormBuilderRadio` in favour of `FormBuilderRadioGroup`
* Deprecate `FormBuilderCheckbox` in favour of `FormBuilderCheckboxGroup`
* Fix bug `"NoSuchMethodError: invalid member on null: 'initialValue'"` when fields not wrapped in `FormBuilder`

## [3.12.0] - 24-Jul-2020
* Added new field `FormBuilderCheckboxGroup`. Closes #188
* Removed `group_radio_button` library dependency, made own implementation with label fix. Closes #376, #335
* Add web support for ImagePicker. Courtesy of [vin-fandemand](https://github.com/vin-fandemand)
* Fixed bug where value within `TextEditingController` ignored in `FormBuilderTypeahead`

## [3.11.6] - 20-Jul-2020
* Upgraded dependencies
* Fixed error '`The getter 'initialValue' was called on null`' if no `FormBuilderState` ancestry. Closes #364
* Fixed issue where DropdownButton `hint` overlaps with `labelText`. Closes #372
* Fix '`initialEntryMode != null`' assertion in DateTimePicker. Closes #373

## [3.11.5] - 17-Jul-2020
* Included more `showDatePicker` function options
* Fixed bug where `onChanged` not triggered by ImagePicker. Closes #366
* Deprecate `underline` for Dropdown. Ignored
* Added more options for DropdownButton. Closes #153, #337
* Type `FormBuilderDropdown` class. Closes #360
* Included options to set camera and gallery icons and label. Closes #340
* Added `bottomSheetPadding` option for ImagePicker. Closes #339

## [3.11.4] - 08-Jul-2020
* Added text styles options to Slider
* Re-implement number formatting on Slider field
* Fix bug in ChoiceChip & FilterChip where using FieldOption label instead of child breaks. Closes #348
* Added `labelPadding` and `labelStyle` to ChoiceChip field
* Fix SignaturePad initialValue.

## [3.11.3] - 21-Jun-2020
* Reverted changes to PhoneField causing focus issues

## [3.11.2] - 19-Jun-2020
* Deprecated `initialValue` for Signature field - here's no easy way of converting `Uint8List` to `List<Point>`. Use SignatureController to set initial signature
* Added `displayValues` attribute to Slider and RangeSlider - choose which values to display under the slider

## [3.11.1] - 15-Jun-2020
* Bumped up flutter_chips_input version. Contains major fix
* Fixed bug preventing use of non-String value for `FormBuilderTypeAhead`.

## [3.11.0] - 14-Jun-2020
* Added `FormBuilderRadioGroup` field
* Revised ImageSourceSheet to use the new Image Picker api, and added support for web platform.
* Add `textAlignVertical` attribute option to FormBuilderTextField
* Included additional configuration options to the FormBuilderImagePicker: `maxHeight`, `maxWidth`, `imageQuality`, `preferredCameraDevice` & `maxImages`
* Added `alwaysUse24HourFormat` option to DateTimePicker. Closes #297
* Revert focus to PhoneField TextField after country selected. Closes #302
* Validate PhoneField only if phone number has value, not country only
* Bumped up flutter_typeahead version. Contains keyboard visibility fix
* Bumped up flutter_chips_input version with multiple fixes and improvements.
* Show Country flag to PhoneField

## [3.10.1] - 17-May-2020
* Added delete icon on selected images in ImagePicker instead of non-intuitive long-press to delete. Closes #278
* Added contentPadding option to Checkbox, CheckboxList, Radio and Switch to allow spacing of items in list options. Closes #280
* Fix bug "The getter 'isNotEmpty' was called on null" in PhoneField

## [3.10.0] - 15-May-2020
* Added `FormBuilderCountryPicker` and `FormBuilderPhoneField`. Good work by [Furkan KURT](https://github.com/furkankurt)
* Set `readOnly` prop to `false` in ColorPicker, DateRangePicker & DateTimePicker TextFields - prevents keyboard popping up. Closes #210
* Fixed allowEmpty bug in `minLength` validator. Closes #259
* Allow user to set iconColor for ImagePicker due to issue with dark mode. Closes #268
* Use [signature package](https://pub.dev/packages/signature) instead of self-maintained Widget
* Use `ObjectKey`s to enforce rebuild after reset
* Added `decoration` attribute to ImagePicker, deprecated `labelText`
* Remove deprecation for `initialTime` & `initialDate` in DateTimePicker

## Unreleased
* Add `contentPadding` to all `ListTile`-based fields

## [4.0.0-alpha.2] - 06-May-2020
* All form reset issues are fixed - I hope ;-). `UniqueKey()` used where  necessary
* `FormBuilderField` to be used base to create custom fields. Removed unused `FormBuilderCustomField`
* Add to `FormBuilderField.onReset` callback - to enable user to react to resetting by changing the UI to reflect reset
* Fixed bug where setting form-wide `readOnly` to true doesn't affect fields
* On field reset, use calculated `initialValue` instead of widget provided since it may have been set by the `FormBuilder`
* Use signature: ^3.0.0 package instead of self-maintained - comes with breaking changes.
* Added option for user to set own `border` for `FormBuilderSignaturePad`
* Remove deprecation for `initialDate` and `initialTime` for `DateTimePicker` - user may prefer to set own

## [4.0.0-alpha.1] - 04-May-2020
* Complete rewrite of package implementation
* Removed a few deprecations
* Renamed `FormBuilderRate` to `FormBuilderRating`

## [3.9.0] - 03-May-2020
* New field type `FormBuilderImagePicker` courtesy of [Gustavo Vítor](https://github.com/gustavovitor)
* Switched rating package from [sy_flutter_widgets](https://pub.dev/packages/form_builder_map_field) to [rating_bar](https://pub.dev/packages/rating_bar) with more configuration options
* Switched rating package from [sy_flutter_widgets](https://pub.dev/packages/sy_flutter_widgets) to [rating_bar](https://pub.dev/packages/rating_bar) with more configuration options
* Added option to `showCheckmark` for FormBuilderFilterChip, along with other options. Closes #260
* Added option to `allowEmpty` in `minLength` and `maxLength` validations. Closes #259
* Fixed bug where `locale`, `textDirection`, `useRootNavigator` & `builder` not passed down to `showDatePicker()` and `showTimePicker()`
* Assert `initialValue` is `null` or `controller` is `null` for `FormBuilderTextField`. Closes #258

## [3.8.3] - 15-Apr-2020
* Fix bug where `onChange` in FormBuilderDateTimePicker doesn't fire when field is cleared. Closes #254
* Fix `The method 'dispose' was called on null.` issue in FormBuilderTypeAhead. Closes #256
* Bumped up flutter_chips_input to v1.8.0 from v1.7.0

## [3.8.2] - 27-Mar-2020
* `onTap` callback added to `FormBuilderTextField` 
* Link to [form_builder_map_field](https://pub.dev/packages/form_builder_map_field) added to README
* Improvements to README

## [3.8.1] - 09-Mar-2020
* Only enable corresponding TextField when ColorPicker is not readOnly
* Fixed bug where `FormBuilderTouchSpin` aka Stepper not being disabled when in readOnly
* Bumped up color_picker to 0.3.2, added new ColorPickerType - `SliderPicker`
* Export `flutter_typeahead` package so user gets access `TextFieldConfiguration` class
* Deprecate `validator` attribute in FormBuilderDateTimePicker, only `validators` should be used
* When TimePicker is cancelled, return original value instead of null
* Fix bug where initialTime for TimePicker defaults to 12:00, use currentTime. Closes [#234](https://github.com/danvick/flutter_form_builder/issues/234)

## [3.8.0+1] - 17-Feb-2020
* Fix bug where Changing readOnly of `FormBuilder` does not change readOnly of `FormBuilderDateTimePicker`. Closes [#179](https://github.com/danvick/flutter_form_builder/issues/179)

## [3.8.0] - 12-Feb-2020
* **NEW FIELD TYPES:**
    * `FormBuilderChoiceChip` - Creates a chip that acts like a radio button. Courtesy [Cesar Flores](https://github.com/VOIDCRUSHER)
    * `FormBuilderFilterChip` - Creates a chip that acts like a checkbox. By [Cesar Flores](https://github.com/VOIDCRUSHER). Again!
    * `FormBuilderColorPicker` with help from [Benjamin](https://github.com/Reprevise)
    * `FormBuilderTouchSpin` replaced the confusingly named `FormBuilderStepper` which is now deprecated.
* Fix some inconsistencies in controller and focus node disposal. Courtesy of [Thomas Järvstrand](https://github.com/tjarvstrand). Should close [#230](https://github.com/danvick/flutter_form_builder/issues/230)
* Bumped up `flutter_typeahead` from `1.7.0` to `1.8.0`

## [3.7.3] - 15-Jan-2020
* Bumped up `intl`, `datetime_picker_formfield` & `flutter_chips_input`. Closes #204, #207, #211, #215.
* Fixed deprecation errors

## [3.7.2] - 10-Dec-2019
* Fix email validator: Trim white-space before validation
* Return Form's value state with all fields defined in initialValue

## [3.7.1] - 6-Dec-2019
* Use `num` for `FormBuilderStepper` instead of `double` to allow for either `int` or `double`

## [3.7.0] - 5-Dec-2019
* Included `onSaved` callback to all fields. Closes [#175](https://github.com/danvick/flutter_form_builder/issues/175)
* Added `Key` option to all fields to make testing possible 
* Fixed bug where custom controller not working in TypeAhead. Closes [#144](https://github.com/danvick/flutter_form_builder/issues/144)
* Fix issue where `FormBuilderDateRangePicker` ignores `initialFirstDate` and `initialLastDate`
* Fixed bug where readOnly not working in FormBuilderDateTimePicker. Closes [#179](https://github.com/danvick/flutter_form_builder/issues/179)
* Allow double `values` for `FormBuilderStepper`. Closes [#182](https://github.com/danvick/flutter_form_builder/issues/182)
* Only include clear icon next to DropdownButton if the value is not `null`
* Revert `intl`, upgrade `flutter_chips_input` & `datetime_picker_formfield` - due incompatibilities. Closes [#183](https://github.com/danvick/flutter_form_builder/issues/183), [#185](https://github.com/danvick/flutter_form_builder/issues/185)

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









