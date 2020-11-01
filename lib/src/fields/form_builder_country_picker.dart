import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/country_picker_util.dart';

class FormBuilderCountryPicker extends FormBuilderField<Country> {
  final TextStyle style;

  // For country dialog
  final String searchText;
  final EdgeInsets titlePadding;
  final bool isSearchable;
  final Text dialogTitle;
  final String defaultSelectedCountryIsoCode;
  final List<String> priorityListByIsoCode;
  final List<String> countryFilterByIsoCode;
  final TextStyle dialogTextStyle;
  final bool isCupertinoPicker;
  final double cupertinoPickerSheetHeight;
  final Color cursorColor;
  final String placeholderText;

  FormBuilderCountryPicker({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    String initialValue, // ** Not Country
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<Country> onChanged,
    FormFieldSetter<Country> onSaved,
    ValueTransformer<Country> valueTransformer,
    List<FormFieldValidator<Country>> validators = const [],
    this.defaultSelectedCountryIsoCode,
    this.style,
    this.searchText,
    this.titlePadding,
    this.dialogTitle,
    this.isSearchable,
    this.priorityListByIsoCode,
    this.countryFilterByIsoCode,
    this.dialogTextStyle,
    this.isCupertinoPicker = false,
    this.cupertinoPickerSheetHeight,
    this.cursorColor,
    this.placeholderText = 'Select country',
  }) : super(
          key: key,
          attribute: attribute,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: CountryPickerUtil.getCountryByCodeOrName(initialValue),
          decoration: decoration,
          onChanged: onChanged,
          onSaved: onSaved,
          valueTransformer: valueTransformer,
          validators: validators,
        );

  @override
  _FormBuilderCountryPickerState createState() =>
      _FormBuilderCountryPickerState();
}

class _FormBuilderCountryPickerState
    extends FormBuilderFieldState<FormBuilderCountryPicker, Country, String> {
  @override
  Country initialValueTransformer(String storedInitialValue) {
    return CountryPickerUtil.getCountryByCodeOrName(storedInitialValue) ??
        CountryPickerUtil.getCountryByIsoCode(
            widget.defaultSelectedCountryIsoCode);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<Country>(
      key: fieldKey,
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.enabled,
      initialValue: initialValue,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<Country> field) {
        return GestureDetector(
          onTap: widget.enabled
              ? () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (widget.isCupertinoPicker) {
                    _openCupertinoCountryPicker(field);
                  } else {
                    _openCountryPickerDialog(field);
                  }
                }
              : null,
          child: InputDecorator(
            decoration: widget.decoration.copyWith(
              errorText: field.errorText,
            ),
            child: Row(
              key: ObjectKey(field.value),
              children: [
                if (field.value != null)
                  CountryPickerUtils.getDefaultFlagImage(field.value),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    field.value?.name ?? widget.placeholderText ?? '',
                    style: widget.style,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openCupertinoCountryPicker(FormFieldState<Country> field) =>
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CountryPickerCupertino(
            pickerSheetHeight: widget.cupertinoPickerSheetHeight ?? 300.0,
            onValuePicked: (Country value) {
              field.didChange(value);
              widget.onChanged?.call(value);
            },
            itemFilter: widget.countryFilterByIsoCode != null
                ? (c) => widget.countryFilterByIsoCode.contains(c.isoCode)
                : null,
            priorityList: widget.priorityListByIsoCode != null
                ? List.generate(
                    widget.priorityListByIsoCode.length,
                    (index) => CountryPickerUtils.getCountryByIsoCode(
                        widget.priorityListByIsoCode[index]))
                : null,
          );
        },
      );

  void _openCountryPickerDialog(FormFieldState<Country> field) => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(
            cursorColor: Theme.of(context).primaryColor,
            primaryColor: widget.cursorColor ?? Theme.of(context).primaryColor,
          ),
          child: CountryPickerDialog(
            titlePadding: widget.titlePadding ?? const EdgeInsets.all(8.0),
            searchCursorColor:
                widget.cursorColor ?? Theme.of(context).primaryColor,
            searchInputDecoration:
                InputDecoration(hintText: widget.searchText ?? 'Search...'),
            isSearchable: widget.isSearchable ?? true,
            title: widget.dialogTitle ??
                Text(
                  'Select Your Country',
                  style: widget.dialogTextStyle ?? widget.style,
                ),
            onValuePicked: (Country value) {
              field.didChange(value);
              widget.onChanged?.call(value);
            },
            itemFilter: widget.countryFilterByIsoCode != null
                ? (c) => widget.countryFilterByIsoCode.contains(c.isoCode)
                : null,
            priorityList: widget.priorityListByIsoCode != null
                ? List.generate(
                    widget.priorityListByIsoCode.length,
                    (index) => CountryPickerUtils.getCountryByIsoCode(
                        widget.priorityListByIsoCode[index]))
                : null,
            itemBuilder: _buildDialogItem,
          ),
        ),
      );

  Widget _buildDialogItem(Country country) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CountryPickerUtils.getDefaultFlagImage(country),
        title: Text(country.name),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
