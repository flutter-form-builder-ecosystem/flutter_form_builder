import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@Deprecated(
    'Will be removed due to its limited applicability. Can be replaced with `FormBuilderSearchableDropdown`')
class FormBuilderCountryPicker extends FormBuilderField<String> {
  final String initialSelection;
  final bool showCountryOnly;
  final bool showOnlyCountryWhenClosed;
  final List<String> favorite;
  final Function itemBuilder;
  final TextOverflow textOverflow;
  final bool alignLeft;
  final int Function(CountryCode, CountryCode) comparator;
  final List<String> countryFilter;
  final Size dialogSize;
  final TextStyle dialogTextStyle;
  final Widget Function(BuildContext) emptySearchBuilder;
  final double flagWidth;
  final bool hideMainText;
  final bool hideSearch;
  final void Function(CountryCode) onInit;
  final EdgeInsets padding;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final bool showFlag;
  final bool showFlagDialog;
  final bool showFlagMain;
  final TextStyle textStyle;

  FormBuilderCountryPicker({
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
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showCountryOnly = true,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.dialogTextStyle,
    this.emptySearchBuilder,
    this.showOnlyCountryWhenClosed = true,
    this.alignLeft = false,
    this.showFlag = true,
    this.showFlagDialog,
    this.hideMainText = false,
    this.showFlagMain,
    this.itemBuilder,
    this.flagWidth = 32.0,
    this.textOverflow = TextOverflow.ellipsis,
    this.comparator,
    this.countryFilter,
    this.hideSearch = false,
    this.dialogSize,
    this.initialSelection,
    this.onInit,
  }) : // assert(initialValue != null),
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
          focusNode: focusNode,
          builder: (FormFieldState field) {
            final _FormBuilderCountryPickerState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                errorText: decoration?.errorText ?? field.errorText,
                enabled: !state.readOnly,
              ),
              child: CountryCodePicker(
                onChanged: (CountryCode e) {
                  state.requestFocus();
                  state.didChange(e.toString());
                },
                initialSelection: initialSelection,
                showCountryOnly: showOnlyCountryWhenClosed,
                showOnlyCountryWhenClosed: showOnlyCountryWhenClosed,
                favorite: favorite,
                builder: itemBuilder,
                textOverflow: textOverflow,
                alignLeft: alignLeft,
                comparator: comparator,
                countryFilter: countryFilter,
                dialogSize: dialogSize,
                dialogTextStyle: dialogTextStyle,
                emptySearchBuilder: emptySearchBuilder,
                enabled: !state.readOnly,
                flagWidth: flagWidth,
                hideMainText: hideMainText,
                hideSearch: hideSearch,
                onInit: onInit,
                padding: padding,
                searchDecoration: searchDecoration,
                searchStyle: searchStyle,
                showFlag: showFlag,
                showFlagDialog: showFlagDialog,
                showFlagMain: showFlagMain,
                textStyle: textStyle,
              ),
            );
          },
        );

  @override
  _FormBuilderCountryPickerState createState() =>
      _FormBuilderCountryPickerState();
}

class _FormBuilderCountryPickerState extends FormBuilderFieldState<String> {
  @override
  // ignore: deprecated_member_use_from_same_package
  FormBuilderCountryPicker get widget =>
      // ignore: deprecated_member_use_from_same_package
      super.widget as FormBuilderCountryPicker;
}
