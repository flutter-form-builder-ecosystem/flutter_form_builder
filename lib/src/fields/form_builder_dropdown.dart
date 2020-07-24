import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdown<T> extends FormBuilderField<T> {
  final Widget hint;
  final List<DropdownMenuItem> items;
  final bool isExpanded;
  final TextStyle style;
  final bool isDense;
  final int elevation;
  final Widget disabledHint;
  final double iconSize;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final bool allowClear;
  final Widget clearIcon;
  final VoidCallback onTap;
  final bool autofocus;
  final Color dropdownColor;
  final Color focusColor;
  final double itemHeight;
  final List<Widget> Function(BuildContext) selectedItemBuilder;

  FormBuilderDropdown({
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
    this.isExpanded = true,
    this.isDense = true,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.hint,
    this.style,
    this.disabledHint,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.allowClear = false,
    this.clearIcon = const Icon(Icons.close),
    this.onTap,
    this.autofocus = false,
    this.dropdownColor,
    this.focusColor,
    this.itemHeight,
    this.selectedItemBuilder,
  }) : /*: assert(allowClear == true || clearIcon != null)*/ super(
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
              final _FormBuilderDropdownState state = field;

              return InputDecorator(
                decoration: decoration.copyWith(
                  enabled: !state.readOnly,
                  errorText: decoration?.errorText ?? field.errorText,
                  floatingLabelBehavior: hint == null
                      ? decoration.floatingLabelBehavior
                      : FloatingLabelBehavior.always,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
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
                    ),
                    if (allowClear && !readOnly && field.value != null) ...[
                      VerticalDivider(),
                      InkWell(
                        child: clearIcon,
                        onTap: () {
                          _changeValue(state, null);
                        },
                      ),
                    ]
                  ],
                ),
              );
            });

  static void _changeValue(_FormBuilderDropdownState state, value) {
    state.requestFocus();
    state.didChange(value);
  }

  @override
  _FormBuilderDropdownState<T> createState() => _FormBuilderDropdownState();
}

class _FormBuilderDropdownState<T> extends FormBuilderFieldState<T> {
  @override
  FormBuilderDropdown<T> get widget => super.widget as FormBuilderDropdown;
}
