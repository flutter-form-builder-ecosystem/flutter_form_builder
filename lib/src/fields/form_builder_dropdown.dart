import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdown extends FormBuilderField {
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final dynamic initialValue;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueChanged onChanged;
  @override
  final ValueTransformer valueTransformer;

  final Widget hint;
  final List<DropdownMenuItem> items;
  final bool isExpanded;
  final TextStyle style;
  final bool isDense;
  final int elevation;
  final Widget disabledHint;
  final double iconSize;
  final Widget underline;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final bool allowClear;
  final Widget clearIcon;
  @override
  final FormFieldSetter onSaved;

  final VoidCallback onTap;
  final FocusNode focusNode;
  final bool autofocus;
  final Color dropdownColor;
  final Color focusColor;
  final double itemHeight;
  final List<Widget> Function(BuildContext) selectedItemBuilder;

  FormBuilderDropdown({
    Key key,
    @required this.attribute,
    @required this.items,
    this.validator,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.isExpanded = true,
    this.isDense = true,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.hint,
    this.initialValue,
    this.style,
    this.disabledHint,
    this.onChanged,
    this.valueTransformer,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.allowClear = false,
    this.clearIcon = const Icon(Icons.close),
    this.onSaved,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.focusColor,
    this.itemHeight,
    this.selectedItemBuilder,
  }) : /*: assert(allowClear == true || clearIcon != null)*/ super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            builder: (FormFieldState field) {
              final _FormBuilderDropdownState state = field;

              return InputDecorator(
                decoration: decoration.copyWith(
                  enabled: !state.readOnly,
                  errorText: field.errorText,
                ),
                child: DropdownButtonHideUnderline(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButton(
                          isExpanded: isExpanded,
                          hint: hint,
                          items: items,
                          value: field.value,
                          style: style,
                          isDense: isDense,
                          disabledHint: field.value != null
                              ? (items
                                      .firstWhere(
                                          (val) => val.value == field.value,
                                          orElse: () => null)
                                      ?.child ??
                                  Text('${field.value.toString()}'))
                              : disabledHint,
                          elevation: elevation,
                          iconSize: iconSize,
                          icon: icon,
                          iconDisabledColor: iconDisabledColor,
                          iconEnabledColor: iconEnabledColor,
                          underline: underline,
                          onChanged: state.readOnly
                              ? null
                              : (value) {
                                  _changeValue(field, value);
                                },
                          onTap: onTap,
                          focusNode: focusNode,
                          autofocus: autofocus,
                          dropdownColor: dropdownColor,
                          focusColor: focusColor,
                          itemHeight: itemHeight,
                          selectedItemBuilder: selectedItemBuilder,
                        ),
                      ),
                      if (allowClear && !readOnly && field.value != null) ...[
                        VerticalDivider(),
                        InkWell(
                          child: clearIcon,
                          onTap: () {
                            _changeValue(field, null);
                          },
                        ),
                      ]
                    ],
                  ),
                ),
              );
            });

  static void _changeValue(FormFieldState field, value) {
    field.didChange(value);
  }

  @override
  _FormBuilderDropdownState createState() => _FormBuilderDropdownState();
}

class _FormBuilderDropdownState extends FormBuilderFieldState {
  @override
  FormBuilderDropdown get widget => super.widget;
}
