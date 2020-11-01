import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCheckbox extends FormBuilderField<bool> {
  final bool leadingInput;

  final Widget label;

  final Color activeColor;
  final Color checkColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;
  final EdgeInsets contentPadding;
  final Color focusColor;
  final Color hoverColor;
  final FocusNode focusNode;
  final bool autoFocus;
  final MouseCursor mouseCursor;
  final VisualDensity visualDensity;

  FormBuilderCheckbox({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    bool initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<bool> onChanged,
    FormFieldSetter<bool> onSaved,
    ValueTransformer<bool> valueTransformer,
    List<FormFieldValidator<bool>> validators = const [],
    @required this.label,
    this.leadingInput = false,
    this.activeColor,
    this.checkColor,
    this.materialTapTargetSize,
    this.tristate = false,
    this.contentPadding = EdgeInsets.zero,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autoFocus = false,
    this.mouseCursor,
    this.visualDensity,
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
        );

  @override
  _FormBuilderCheckboxState createState() => _FormBuilderCheckboxState();
}

class _FormBuilderCheckboxState
    extends FormBuilderFieldState<FormBuilderCheckbox, bool, bool> {
  Widget _checkbox(FormFieldState<bool> field) {
    return Checkbox(
      value: (field.value == null && !widget.tristate) ? false : field.value,
      activeColor: widget.activeColor,
      checkColor: widget.checkColor,
      materialTapTargetSize: widget.materialTapTargetSize,
      tristate: widget.tristate,
      onChanged: readOnly
          ? null
          : (bool value) {
              FocusScope.of(context).requestFocus(FocusNode());
              field.didChange(value);
              widget.onChanged?.call(value);
            },
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      mouseCursor: widget.mouseCursor,
      visualDensity: widget.visualDensity,
    );
  }

  Widget _leading(FormFieldState<bool> field) {
    if (widget.leadingInput) return _checkbox(field);
    return null;
  }

  Widget _trailing(FormFieldState<bool> field) {
    if (!widget.leadingInput) return _checkbox(field);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue,
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<bool> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: ListTile(
            dense: true,
            isThreeLine: false,
            contentPadding: widget.contentPadding,
            title: widget.label,
            leading: _leading(field),
            trailing: _trailing(field),
            onTap: readOnly
                ? null
                : () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final newValue = !(field.value ?? false);
                    field.didChange(newValue);
                    widget.onChanged?.call(newValue);
                  },
          ),
        );
      },
    );
  }
}
