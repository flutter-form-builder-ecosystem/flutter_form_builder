import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/typedefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:phone_number/phone_number.dart';

//TODO: Switch country_pickers for country_code_picker
/// Field for international phone number input.
class FormBuilderPhoneField extends FormBuilderField<String> {
  //TODO: Add documentation
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle? style;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final MaxLengthEnforcement maxLengthEnforcement;
  final int? maxLength;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final double cursorWidth;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder? buildCounter;
  final bool expands;
  final int? minLines;
  final bool? showCursor;
  final VoidCallback? onTap;

  // For country dialog
  final String? searchText;
  final EdgeInsets? titlePadding;
  final bool? isSearchable;
  final Text? dialogTitle;
  final String? defaultSelectedCountryIsoCode;
  final List<String>? priorityListByIsoCode;
  final List<String>? countryFilterByIsoCode;
  final TextStyle? dialogTextStyle;
  final bool isCupertinoPicker;
  final double? cupertinoPickerSheetHeight;
  final TextAlignVertical? textAlignVertical;

  ///The [itemExtent] of [CupertinoPicker]
  /// The uniform height of all children.
  ///
  /// All children will be given the [BoxConstraints] to match this exact
  /// height. Must not be null and must be positive.
  final double pickerItemHeight;

  ///The height of the picker
  final double pickerSheetHeight;

  ///The TextStyle that is applied to Text widgets inside item
  final TextStyle? textStyle;

  /// Relative ratio between this picker's height and the simulated cylinder's diameter.
  ///
  /// Smaller values creates more pronounced curvatures in the scrollable wheel.
  ///
  /// For more details, see [ListWheelScrollView.diameterRatio].
  ///
  /// Must not be null and defaults to `1.1` to visually mimic iOS.
  final double diameterRatio;

  /// Background color behind the children.
  ///
  /// Defaults to a gray color in the iOS color palette.
  ///
  /// This can be set to null to disable the background painting entirely; this
  /// is mildly more efficient than using [Colors.transparent].
  final Color backgroundColor;

  /// {@macro flutter.rendering.wheelList.offAxisFraction}
  final double offAxisFraction;

  /// {@macro flutter.rendering.wheelList.useMagnifier}
  final bool useMagnifier;

  /// {@macro flutter.rendering.wheelList.magnification}
  final double magnification;

  final Country? initialCountry;

  /// A [FixedExtentScrollController] to read and control the current item.
  ///
  /// If null, an implicit one will be created internally.
  final FixedExtentScrollController? scrollController;

  /// [Comparator] to be used in sort of country list
  final Comparator<Country>? sortComparator;

  /// List of countries that are placed on top
  final List<Country>? priorityList;

  ///Callback that is called with selected item of type Country which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder? itemBuilder;

  /// Creates field for international phone number input.
  FormBuilderPhoneField({
    Key? key,
    //From Super
    required String name,
    FormFieldValidator<String>? validator,
    String? initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<String?>? onChanged,
    ValueTransformer<String?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<String>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforcement = MaxLengthEnforcement.enforced,
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
    this.pickerItemHeight = defaultPickerItemHeight,
    this.pickerSheetHeight = defaultPickerSheetHeight,
    this.textStyle,
    this.diameterRatio = 1.35,
    this.backgroundColor = const Color(0xFFD2D4DB),
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.initialCountry,
    this.scrollController,
    this.sortComparator,
    this.priorityList,
    this.itemBuilder,
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
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<String?> field) {
            final state = field as _FormBuilderPhoneFieldState;

            return InputDecorator(
              decoration: state.decoration,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: state.enabled
                        ? () {
                            state.requestFocus();
                            if (isCupertinoPicker) {
                              state._openCupertinoCountryPicker();
                            } else {
                              state._openCountryPickerDialog();
                            }
                          }
                        : null,
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.arrow_drop_down),
                        const SizedBox(width: 10),
                        CountryPickerUtils.getDefaultFlagImage(
                          state._selectedDialogCountry,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '+${state._selectedDialogCountry.phoneCode} ',
                          style: Theme.of(state.context)
                              .textTheme
                              .subtitle1!
                              .merge(style),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      enabled: state.enabled,
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
                      maxLines: 1,
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
                      maxLengthEnforcement: maxLengthEnforcement,
                      scrollPadding: scrollPadding,
                      textAlign: textAlign,
                      textCapitalization: textCapitalization,
                      textDirection: textDirection,
                      textInputAction: textInputAction,
                      strutStyle: strutStyle,
                      //readOnly: state.readOnly, -- Does this need to be exposed?
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

class _FormBuilderPhoneFieldState
    extends FormBuilderFieldState<FormBuilderPhoneField, String> {
  late TextEditingController _effectiveController;
  late Country _selectedDialogCountry;

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
    _effectiveController = widget.controller ?? TextEditingController();
    _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode(
        widget.defaultSelectedCountryIsoCode!);
    _parsePhone();
  }

  @override
  void dispose() {
    // Dispose the _effectiveController when initState created it
    if (null == widget.controller) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  Future<void> _parsePhone() async {
    // print('initialValue: $initialValue');
    if (initialValue != null && initialValue!.isNotEmpty) {
      try {
        final parseResult = await PhoneNumberUtil().parse(initialValue!);
        setState(() {
          _selectedDialogCountry =
              CountryPickerUtils.getCountryByPhoneCode(parseResult.countryCode);
        });
        _effectiveController.text = parseResult.nationalNumber;
      } catch (error) {
        _effectiveController.text = initialValue!.replaceFirst('+', '');
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
              ? (c) => widget.countryFilterByIsoCode!.contains(c.isoCode)
              : null,
          priorityList: widget.priorityListByIsoCode != null
              ? List.generate(
                  widget.priorityListByIsoCode!.length,
                  (index) {
                    return CountryPickerUtils.getCountryByIsoCode(
                      widget.priorityListByIsoCode![index],
                    );
                  },
                )
              : null,
          offAxisFraction: widget.offAxisFraction,
          backgroundColor: widget.backgroundColor,
          diameterRatio: widget.diameterRatio,
          initialCountry: widget.initialCountry,
          magnification: widget.magnification,
          sortComparator: widget.sortComparator,
          useMagnifier: widget.useMagnifier,
          itemBuilder: widget.itemBuilder,
          pickerItemHeight: widget.pickerItemHeight,
          scrollController: widget.scrollController,
          textStyle: widget.textStyle,
        );
      },
    );
  }

  void _openCountryPickerDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: widget.cursorColor,
            ),
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
                  'Select Your Phone Code',
                  style: widget.dialogTextStyle ?? widget.style,
                ),
            onValuePicked: (Country country) {
              setState(() => _selectedDialogCountry = country);
              invokeChange();
            },
            itemFilter: widget.countryFilterByIsoCode != null
                ? (c) => widget.countryFilterByIsoCode!.contains(c.isoCode)
                : null,
            priorityList: widget.priorityListByIsoCode != null
                ? List.generate(
                    widget.priorityListByIsoCode!.length,
                    (index) {
                      return CountryPickerUtils.getCountryByIsoCode(
                          widget.priorityListByIsoCode![index]);
                    },
                  )
                : null,
            itemBuilder: _buildDialogItem,
            sortComparator: widget.sortComparator,
          ),
        );
      },
    );
  }

  Widget _buildDialogItem(Country country) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CountryPickerUtils.getDefaultFlagImage(country),
      title: Text(country.name),
      trailing: Text('+${country.phoneCode}'),
    );
  }
}
