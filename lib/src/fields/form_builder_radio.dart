import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@Deprecated('Prefer using `FormBuilderRadioGroup` instead')
class FormBuilderRadio<T> extends FormBuilderField<T> {
  final bool leadingInput;
  final List<FormBuilderFieldOption<T>> options;
  final MaterialTapTargetSize materialTapTargetSize;
  final Color activeColor;
  final EdgeInsets contentPadding;

  FormBuilderRadio({
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
    @required this.options,
    this.leadingInput = false,
    this.materialTapTargetSize,
    this.activeColor,
    this.contentPadding = EdgeInsets.zero,
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
  _FormBuilderRadioState<T> createState() => _FormBuilderRadioState<T>();
}

class _FormBuilderRadioState<T>
    // ignore: deprecated_member_use_from_same_package
    extends FormBuilderFieldState<FormBuilderRadio<T>, T, T> {
  Widget _radio(FormFieldState<T> field, int i) {
    return Radio<T>(
      value: widget.options[i].value,
      groupValue: field.value,
      materialTapTargetSize: widget.materialTapTargetSize,
      activeColor: widget.activeColor,
      onChanged: readOnly
          ? null
          : (T value) {
              FocusScope.of(context).requestFocus(FocusNode());
              field.didChange(value);
              widget.onChanged?.call(value);
            },
    );
  }

  Widget _leading(FormFieldState<T> field, int i) {
    return widget.leadingInput ? _radio(field, i) : null;
  }

  Widget _trailing(FormFieldState<T> field, int i) {
    return !widget.leadingInput ? _radio(field, i) : null;
  }

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
        final radioList = <Widget>[];
        for (var i = 0; i < widget.options.length; i++) {
          radioList.addAll([
            ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: widget.contentPadding,
              leading: _leading(field, i),
              title: widget.options[i],
              trailing: _trailing(field, i),
              onTap: readOnly
                  ? null
                  : () {
                      final value = widget.options[i].value;
                      field.didChange(value);
                      widget.onChanged?.call(value);
                    },
            ),
            const Divider(
              height: 0.0,
            ),
          ]);
        }
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: Column(
            children: radioList,
          ),
        );
      },
    );
  }
}
