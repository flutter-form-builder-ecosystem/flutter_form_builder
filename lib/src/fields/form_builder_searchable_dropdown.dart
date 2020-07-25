import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FormBuilderSearchableDropdown<T> extends FormBuilderField {
  final List<DropdownMenuItem<T>> items;
  final TextStyle style;
  final dynamic searchHint;
  final dynamic hint;
  final dynamic disabledHint;
  final dynamic icon;

  final dynamic underline;
  final dynamic doneButton;
  final dynamic label;
  final dynamic closeButton;

  final bool displayClearIcon;

  final Icon clearIcon;

  final Color iconEnabledColor;
  final Color iconDisabledColor;
  final double iconSize;
  final bool isExpanded;

  final bool isCaseSensitiveSearch;
  final Function searchFn;
  final Function onClear;
  final Function selectedValueWidgetFn;
  final TextInputType keyboardType;

  final bool assertUniqueValue;
  final Function displayItem;
  final bool dialogBox;
  final BoxConstraints menuConstraints;
  final Color menuBackgroundColor;

  FormBuilderSearchableDropdown({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    T initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    bool autovalidate = false,
    VoidCallback onReset,
    FocusNode focusNode,
    @required this.items,
    this.style,
    this.searchHint,
    this.hint,
    this.disabledHint,
    this.icon = const Icon(Icons.arrow_drop_down),
    this.underline,
    this.doneButton,
    this.label,
    this.closeButton = 'Close',
    this.displayClearIcon = true,
    this.clearIcon = const Icon(Icons.clear),
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.isCaseSensitiveSearch = false,
    this.searchFn,
    this.onClear,
    this.selectedValueWidgetFn,
    this.keyboardType = TextInputType.text,
    this.assertUniqueValue = true,
    this.displayItem,
    this.dialogBox = true,
    this.menuConstraints,
    this.menuBackgroundColor,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidate: autovalidate,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          builder: (FormFieldState field) {
            final _FormBuilderSearchableDropdownState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: SearchableDropdown.single(
                items: items,
                onChanged: (val){
                  state.didChange(val);
                },
                // value: state.value,
                style: style,
                searchHint: searchHint,
                hint: hint,
                disabledHint: disabledHint,
                icon: icon,
                underline: underline,
                doneButton: doneButton,
                label: label,
                closeButton: closeButton,
                displayClearIcon: displayClearIcon,
                clearIcon: clearIcon,
                iconEnabledColor: iconEnabledColor,
                iconDisabledColor: iconDisabledColor,
                iconSize: iconSize,
                isExpanded: isExpanded,
                isCaseSensitiveSearch: isCaseSensitiveSearch,
                searchFn: searchFn,
                onClear: onClear,
                selectedValueWidgetFn: selectedValueWidgetFn,
                keyboardType: keyboardType,
                validator: validator,
                // assertUniqueValue: assertUniqueValue,
                displayItem: displayItem,
                dialogBox: dialogBox,
                menuConstraints: menuConstraints,
                readOnly: readOnly,
                menuBackgroundColor: menuBackgroundColor,
              ),
            );
          },
        );

  @override
  _FormBuilderSearchableDropdownState createState() =>
      _FormBuilderSearchableDropdownState();
}

class _FormBuilderSearchableDropdownState extends FormBuilderFieldState {
  @override
  FormBuilderSearchableDropdown get widget =>
      super.widget as FormBuilderSearchableDropdown;
}
