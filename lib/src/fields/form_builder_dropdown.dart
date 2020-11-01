import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdown<T> extends FormBuilderField<T> {
  final Widget hint;
  final List<DropdownMenuItem<T>> items;
  final bool isExpanded;
  final TextStyle style;
  final bool isDense;
  final int elevation;
  final Widget disabledHint;
  final double iconSize;
  @Deprecated('Underline in DropdownButton is ignored.')
  final Widget underline;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final bool allowClear;
  final Widget clearIcon;
  final double itemHeight;
  final Color focusColor;
  final Color dropdownColor;
  final bool autofocus;
  final FocusNode focusNode;
  final VoidCallback onTap;
  final List<Widget> Function(BuildContext) selectedItemBuilder;

  FormBuilderDropdown({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    T initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<T> onChanged,
    FormFieldSetter<T> onSaved,
    ValueTransformer<T> valueTransformer,
    List<FormFieldValidator<T>> validators = const [],
    @required this.items,
    this.isExpanded = true,
    this.isDense = true,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.hint,
    this.style,
    this.disabledHint,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.allowClear = false,
    this.clearIcon = const Icon(Icons.close),
    this.itemHeight,
    this.focusColor,
    this.dropdownColor,
    this.autofocus = false,
    this.focusNode,
    this.onTap,
    this.selectedItemBuilder,
  }) : super(
          key: key,
          attribute: attribute,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: initialValue,
          decoration: decoration,
          onChanged: onChanged,
          onSaved: onSaved,
          valueTransformer: valueTransformer,
          validators: validators,
        ) /*: assert(allowClear == true || clearIcon != null)*/;

  @override
  _FormBuilderDropdownState<T> createState() => _FormBuilderDropdownState<T>();
}

class _FormBuilderDropdownState<T>
    extends FormBuilderFieldState<FormBuilderDropdown<T>, T, T> {
  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue,
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<T> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            errorText: field.errorText,
            floatingLabelBehavior: widget.hint == null
                ? widget.decoration.floatingLabelBehavior
                : FloatingLabelBehavior.always,
          ),
          isEmpty: field.value == null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    isExpanded: widget.isExpanded,
                    hint: widget.hint,
                    items: widget.items,
                    value: field.value,
                    style: widget.style,
                    isDense: widget.isDense,
                    disabledHint: field.value != null
                        ? (widget.items
                                .firstWhere((val) => val.value == field.value,
                                    orElse: () => null)
                                ?.child ??
                            Text(field.value.toString()))
                        : widget.disabledHint,
                    elevation: widget.elevation,
                    iconSize: widget.iconSize,
                    icon: widget.icon,
                    iconDisabledColor: widget.iconDisabledColor,
                    iconEnabledColor: widget.iconEnabledColor,
                    // ignore: deprecated_member_use_from_same_package
                    underline: widget.underline,
                    onChanged: readOnly
                        ? null
                        : (value) {
                            _changeValue(field, value);
                          },
                    itemHeight: widget.itemHeight,
                    focusColor: widget.focusColor,
                    dropdownColor: widget.dropdownColor,
                    autofocus: widget.autofocus,
                    focusNode: widget.focusNode,
                    onTap: widget.onTap,
                    selectedItemBuilder: widget.selectedItemBuilder,
                  ),
                ),
              ),
              if (widget.allowClear &&
                  !widget.readOnly &&
                  field.value != null) ...[
                const VerticalDivider(),
                InkWell(
                  child: widget.clearIcon,
                  onTap: () {
                    _changeValue(field, null);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _changeValue(FormFieldState<T> field, value) {
    field.didChange(value);
    widget.onChanged?.call(value);
  }

/*@override
  Widget build(BuildContext context) {
    _readOnly = _formState?.readOnly == true || widget.readOnly;

    return DropdownButtonFormField(
      key: _fieldKey,
      decoration: widget.decoration.copyWith(
        enabled: _readOnly ? false : true,
      ),
      hint: widget.hint,
      items: widget.items,
      value: _initialValue,
      onChanged: _readOnly
          ? null
          : (value) {
        FocusScope.of(context).requestFocus(FocusNode());
        widget.onChanged?.call(value);
      },
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        return null;
      },
      onSaved: (val) {
        if (widget.valueTransformer != null) {
          var transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, val);
      },
    );
  }*/
}
