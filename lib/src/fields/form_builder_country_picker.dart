import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/country_picker_util.dart';

class FormBuilderCountryPicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final TextStyle style;
  final FormFieldSetter onSaved;

  // For country dialog
  final String searchText;
  final EdgeInsets titlePadding;
  final bool isSearchable;
  final Text dialogTitle;
  final String initialValue;
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
    @required this.attribute,
    this.defaultSelectedCountryIsoCode,
    this.initialValue,
    this.validators = const [],
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
    this.placeholderText = 'Select country',
  }) : super(key: key);

  @override
  _FormBuilderCountryPickerState createState() =>
      _FormBuilderCountryPickerState();
}

class _FormBuilderCountryPickerState extends State<FormBuilderCountryPicker> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  Country _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue =
        CountryPickerUtil.getCountryByCodeOrName(widget.initialValue) ??
            CountryPickerUtil.getCountryByIsoCode(
                widget.defaultSelectedCountryIsoCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = _formState?.readOnly == true || widget.readOnly;

    return FormField<Country>(
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _initialValue,
      validator: (val) =>
          FormBuilderValidators.validateValidators(val, widget.validators),
      onSaved: (val) {
        dynamic transformed;
        if (widget.valueTransformer != null) {
          transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else {
          _formState?.setAttributeValue(widget.attribute, val?.name);
        }
        widget.onSaved?.call(transformed ?? val);
      },
      builder: (FormFieldState<Country> field) {
        return GestureDetector(
          onTap: _readOnly
              ? null
              : () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (widget.isCupertinoPicker) {
                    _openCupertinoCountryPicker(field);
                  } else {
                    _openCountryPickerDialog(field);
                  }
                },
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

  void _openCupertinoCountryPicker(FormFieldState field) =>
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

  void _openCountryPickerDialog(FormFieldState field) => showDialog(
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
        title: Text('${country.name}'),
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }
}
