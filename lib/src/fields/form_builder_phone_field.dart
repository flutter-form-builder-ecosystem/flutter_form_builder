import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:phone_number/phone_number.dart';

//TODO: Switch country_pickers for country_code_picker
class FormBuilderPhoneField extends FormBuilderField {
  final int maxLines;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle style;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final bool maxLengthEnforced;
  final int maxLength;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;
  final bool expands;
  final int minLines;
  final bool showCursor;
  final VoidCallback onTap;

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
  final TextAlignVertical textAlignVertical;

  FormBuilderPhoneField({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    String initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
    this.maxLines,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforced = true,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.keyboardType = TextInputType.phone,
    this.style,
    this.controller,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.searchText,
    this.titlePadding,
    this.dialogTitle,
    this.isSearchable,
    this.defaultSelectedCountryIsoCode = 'US',
    this.priorityListByIsoCode,
    this.countryFilterByIsoCode,
    this.dialogTextStyle,
    this.isCupertinoPicker = false,
    this.cupertinoPickerSheetHeight,
    this.textAlignVertical,
  })  : assert(initialValue == null ||
            controller == null ||
            defaultSelectedCountryIsoCode != null),
        super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          builder: (FormFieldState field) {
            final _FormBuilderPhoneFieldState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: state.readOnly
                        ? null
                        : () {
                            state.requestFocus();
                            if (isCupertinoPicker) {
                              state._openCupertinoCountryPicker();
                            } else {
                              state._openCountryPickerDialog();
                            }
                          },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.arrow_drop_down),
                        SizedBox(width: 10),
                        CountryPickerUtils.getDefaultFlagImage(
                          state._selectedDialogCountry,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '+${state._selectedDialogCountry.phoneCode} ',
                          style: Theme.of(state.context)
                              .textTheme
                              .subtitle1
                              .merge(style),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      enabled: !state.readOnly,
                      style: style,
                      focusNode: state.effectiveFocusNode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        hintText: decoration.hintText,
                        hintStyle: decoration.hintStyle,
                      ),
                      onChanged: (val) {
                        state.invokeChange();
                      },
                      maxLines: maxLines,
                      keyboardType: keyboardType,
                      obscureText: obscureText,
                      onEditingComplete: onEditingComplete,
                      controller: state._effectiveController,
                      autocorrect: autocorrect,
                      autofocus: autofocus,
                      buildCounter: buildCounter,
                      cursorColor: cursorColor,
                      cursorRadius: cursorRadius,
                      cursorWidth: cursorWidth,
                      enableInteractiveSelection: enableInteractiveSelection,
                      maxLength: maxLength,
                      inputFormatters: inputFormatters,
                      keyboardAppearance: keyboardAppearance,
                      maxLengthEnforced: maxLengthEnforced,
                      scrollPadding: scrollPadding,
                      textAlign: textAlign,
                      textCapitalization: textCapitalization,
                      textDirection: textDirection,
                      textInputAction: textInputAction,
                      strutStyle: strutStyle,
                      readOnly: state.readOnly,
                      expands: expands,
                      minLines: minLines,
                      showCursor: showCursor,
                      onTap: onTap,
                      textAlignVertical: textAlignVertical,
                    ),
                  ),
                ],
              ),
            );
          },
        );

  @override
  _FormBuilderPhoneFieldState createState() => _FormBuilderPhoneFieldState();
}

class _FormBuilderPhoneFieldState extends FormBuilderFieldState {
  @override
  FormBuilderPhoneField get widget => super.widget as FormBuilderPhoneField;

  TextEditingController _effectiveController = TextEditingController();
  Country _selectedDialogCountry;

  String get fullNumber {
    // When there is no phone number text, the field is empty -- the country
    // prefix is only prepended when a phone number is specified.
    final phoneText = _effectiveController.text;
    return phoneText.isNotEmpty
        ? '+${_selectedDialogCountry.phoneCode}$phoneText'
        : phoneText;
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _effectiveController = widget.controller;
    }
    _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode(
        widget.defaultSelectedCountryIsoCode);
    _parsePhone();
  }

  Future<void> _parsePhone() async {
    print('initialValue: $initialValue');
    if (initialValue != null && initialValue.isNotEmpty) {
      try {
        var parseResult = await PhoneNumber().parse(initialValue);
        if (parseResult != null) {
          setState(() {
            _selectedDialogCountry = CountryPickerUtils.getCountryByPhoneCode(
                parseResult['country_code']);
          });
          _effectiveController.text = parseResult['national_number'];
        }
      } catch (error) {
        _effectiveController.text = initialValue.replaceFirst('+', '');
      }
    }
  }

  void invokeChange() {
    didChange(fullNumber);
    widget.onChanged?.call(fullNumber);
  }

  void _openCupertinoCountryPicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: widget.cupertinoPickerSheetHeight ?? 300.0,
          onValuePicked: (Country country) {
            effectiveFocusNode.requestFocus();
            setState(() => _selectedDialogCountry = country);
            didChange(fullNumber);
          },
          itemFilter: widget.countryFilterByIsoCode != null
              ? (c) => widget.countryFilterByIsoCode.contains(c.isoCode)
              : null,
          priorityList: widget.priorityListByIsoCode != null
              ? List.generate(
                  widget.priorityListByIsoCode.length,
                  (index) {
                    return CountryPickerUtils.getCountryByIsoCode(
                      widget.priorityListByIsoCode[index],
                    );
                  },
                )
              : null,
        );
      },
    );
  }

  void _openCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(
            cursorColor: widget.cursorColor,
            primaryColor: widget.cursorColor ?? Theme.of(context).primaryColor,
          ),
          child: CountryPickerDialog(
            titlePadding: widget.titlePadding ?? EdgeInsets.all(8.0),
            searchCursorColor:
                widget.cursorColor ?? Theme.of(context).primaryColor,
            searchInputDecoration:
                InputDecoration(hintText: widget.searchText ?? 'Search...'),
            isSearchable: widget.isSearchable ?? true,
            title: widget.dialogTitle ??
                Text(
                  'Select Your Phone Code',
                  style: widget.dialogTextStyle ?? widget.style,
                ),
            onValuePicked: (Country country) {
              setState(() => _selectedDialogCountry = country);
              invokeChange();
            },
            itemFilter: widget.countryFilterByIsoCode != null
                ? (c) => widget.countryFilterByIsoCode.contains(c.isoCode)
                : null,
            priorityList: widget.priorityListByIsoCode != null
                ? List.generate(
                    widget.priorityListByIsoCode.length,
                    (index) {
                      return CountryPickerUtils.getCountryByIsoCode(
                          widget.priorityListByIsoCode[index]);
                    },
                  )
                : null,
            itemBuilder: _buildDialogItem,
          ),
        );
      },
    );
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CountryPickerUtils.getDefaultFlagImage(country),
        title: Text('${country.name}'),
        trailing: Text('+${country.phoneCode}'),
      ),
    );
  }
}
