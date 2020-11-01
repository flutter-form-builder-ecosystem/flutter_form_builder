import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@Deprecated('Prefer using `FormBuilderCheckboxGroup` instead')
class FormBuilderCheckboxList<T> extends FormBuilderField<List<T>> {
  final List<FormBuilderFieldOption<T>> options;
  final bool leadingInput;
  final Color activeColor;
  final Color checkColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;
  final EdgeInsets contentPadding;

  FormBuilderCheckboxList({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    List<T> initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<List<T>> onChanged,
    FormFieldSetter<List<T>> onSaved,
    ValueTransformer<List<T>> valueTransformer,
    List<FormFieldValidator<List<T>>> validators = const [],
    @required this.options,
    this.leadingInput = false,
    this.activeColor,
    this.checkColor,
    this.materialTapTargetSize,
    this.tristate = false,
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
  _FormBuilderCheckboxListState<T> createState() =>
      _FormBuilderCheckboxListState<T>();
}

class _FormBuilderCheckboxListState<T> extends
// ignore: deprecated_member_use_from_same_package
    FormBuilderFieldState<FormBuilderCheckboxList<T>, List<T>, List<T>> {
  Widget _checkbox(FormFieldState<List<T>> field, int i) {
    return Checkbox(
      activeColor: widget.activeColor,
      checkColor: widget.checkColor,
      materialTapTargetSize: widget.materialTapTargetSize,
      tristate: widget.tristate,
      value: field.value.contains(widget.options[i].value),
      onChanged: readOnly
          ? null
          : (bool value) {
              FocusScope.of(context).requestFocus(FocusNode());
              var currValue = [...field.value];
              if (value) {
                currValue.add(widget.options[i].value);
              } else {
                currValue.remove(widget.options[i].value);
              }
              field.didChange(currValue);
              widget.onChanged?.call(currValue);
            },
    );
  }

  Widget _leading(FormFieldState<List<T>> field, int i) {
    if (widget.leadingInput) return _checkbox(field, i);
    return null;
  }

  Widget _trailing(FormFieldState<List<T>> field, int i) {
    if (!widget.leadingInput) return _checkbox(field, i);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue ?? const [],
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<List<T>> field) {
        final checkboxList = <Widget>[];
        for (var i = 0; i < widget.options.length; i++) {
          checkboxList.addAll([
            ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: widget.contentPadding,
              leading: _leading(field, i),
              trailing: _trailing(field, i),
              title: widget.options[i],
              onTap: readOnly
                  ? null
                  : () {
                      final optionValue = widget.options[i].value;
                      final currentValue = [...field.value];
                      if (!currentValue.contains(optionValue)) {
                        currentValue.add(optionValue);
                      } else {
                        currentValue.remove(optionValue);
                      }
                      field.didChange(currentValue);
                      widget.onChanged?.call(currentValue);
                    },
            ),
            const Divider(height: 0.0),
          ]);
        }
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: Column(
            key: ObjectKey(field.value),
            children: checkboxList,
          ),
        );
      },
    );
  }
}
