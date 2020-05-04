import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdown extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
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
  final FormFieldSetter onSaved;

  FormBuilderDropdown({
    Key key,
    @required this.attribute,
    @required this.items,
    this.validators = const [],
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
  }) : /*: assert(allowClear == true || clearIcon != null)*/ super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validators: validators,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            builder: (field) {
              _FormBuilderDropdownState state = field;
              return InputDecorator(
                decoration: decoration.copyWith(
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
                                  Text("${field.value.toString()}"))
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
                        ),
                      ),
                      if (allowClear &&
                          !readOnly &&
                          field.value != null) ...[
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
  FormBuilderDropdown get widget => super.widget;
}
