import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCountryPicker extends FormBuilderField {
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueChanged onChanged;
  @override
  final ValueTransformer valueTransformer;

  final TextStyle style;
  @override
  final FormFieldSetter onSaved;

  // For country dialog
  final String searchText;
  final EdgeInsets titlePadding;
  final bool isSearchable;
  final Text dialogTitle;
  @override
  final String initialValue;
  final String defaultSelectedCountryIsoCode;
  final List<String> priorityListByIsoCode;
  final List<String> countryFilterByIsoCode;
  final TextStyle dialogTextStyle;
  final bool isCupertinoPicker;
  final double cupertinoPickerSheetHeight;
  final Color cursorColor;

  FormBuilderCountryPicker({
    Key key,
    @required this.attribute,
    this.defaultSelectedCountryIsoCode = 'US',
    this.initialValue,
    this.validator,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.style,
    this.onChanged,
    this.valueTransformer,
    this.onSaved,
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
  })  : assert(initialValue != null),
        super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          /*  enabled: enabled,
            autovalidate: autovalidate,*/
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: true,
          onSaved: onSaved,
          builder: (FormFieldState field) {
            final _FormBuilderCountryPickerState state = field;

            return GestureDetector(
              onTap: () {
                FocusScope.of(state.context).requestFocus(FocusNode());
                if (isCupertinoPicker) {
                  _openCupertinoCountryPicker(field);
                } else {
                  _openCountryPickerDialog(field);
                }
              },
              child: InputDecorator(
                decoration: decoration.copyWith(
                  errorText: field.errorText,
                ),
                child: Row(
                  key: ObjectKey(field.value),
                  children: [
                    CountryPickerUtils.getDefaultFlagImage(field.value),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "${field.value?.name ?? ''}",
                        style: style,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );

  static void _openCupertinoCountryPicker(
          _FormBuilderCountryPickerState field) =>
      showCupertinoModalPopup<void>(
        context: field.context,
        builder: (BuildContext context) {
          return CountryPickerCupertino(
            pickerSheetHeight: field.widget.cupertinoPickerSheetHeight ?? 300.0,
            onValuePicked: (Country value) => field.didChange(value),
            itemFilter: field.widget.countryFilterByIsoCode != null
                ? (c) => field.widget.countryFilterByIsoCode.contains(c.isoCode)
                : null,
            priorityList: field.widget.priorityListByIsoCode != null
                ? List.generate(
                    field.widget.priorityListByIsoCode.length,
                    (index) => CountryPickerUtils.getCountryByIsoCode(
                        field.widget.priorityListByIsoCode[index]))
                : null,
          );
        },
      );

  static void _openCountryPickerDialog(_FormBuilderCountryPickerState field) =>
      showDialog(
        context: field.context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(
            cursorColor: Theme.of(context).primaryColor,
            primaryColor:
                field.widget.cursorColor ?? Theme.of(context).primaryColor,
          ),
          child: CountryPickerDialog(
            titlePadding: field.widget.titlePadding ?? EdgeInsets.all(8.0),
            searchCursorColor:
                field.widget.cursorColor ?? Theme.of(context).cursorColor,
            searchInputDecoration: InputDecoration(
                hintText: field.widget.searchText ?? 'Search...'),
            isSearchable: field.widget.isSearchable ?? true,
            title: field.widget.dialogTitle ??
                Text(
                  'Select Your Country',
                  style: field.widget.dialogTextStyle ?? field.widget.style,
                ),
            onValuePicked: (Country value) => field.didChange(value),
            itemFilter: field.widget.countryFilterByIsoCode != null
                ? (c) => field.widget.countryFilterByIsoCode.contains(c.isoCode)
                : null,
            priorityList: field.widget.priorityListByIsoCode != null
                ? List.generate(
                    field.widget.priorityListByIsoCode.length,
                    (index) => CountryPickerUtils.getCountryByIsoCode(
                        field.widget.priorityListByIsoCode[index]))
                : null,
            itemBuilder: _buildDialogItem,
          ),
        ),
      );

  static Widget _buildDialogItem(Country country) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CountryPickerUtils.getDefaultFlagImage(country),
        title: Text("${country.name}"),
      ),
    );
  }

  @override
  _FormBuilderCountryPickerState createState() =>
      _FormBuilderCountryPickerState();
}

class _FormBuilderCountryPickerState extends FormBuilderFieldState/*<String>*/ {
  FormBuilderCountryPicker get widget => super.widget;

/*@override
  void initState() {
    var _initialValue =
        CountryPickerUtil.getCountryByCodeOrName(widget.initialValue) ??
            CountryPickerUtil.getCountryByIsoCode(
                widget.defaultSelectedCountryIsoCode);
    super.initState();
  }*/
}
