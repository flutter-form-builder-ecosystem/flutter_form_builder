import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSegmentedControl<T> extends FormBuilderField<T> {
  final List<FormBuilderFieldOption<T>> options;

  final Color borderColor;
  final Color selectedColor;
  final Color pressedColor;

  @Deprecated(
      "Use `FormBuilderFieldOption`'s `child` property to style your option")
  final TextStyle textStyle;

  final EdgeInsetsGeometry padding;

  final Color unselectedColor;

  FormBuilderSegmentedControl({
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
    this.borderColor,
    this.selectedColor,
    this.pressedColor,
    this.textStyle,
    this.padding,
    this.unselectedColor,
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
  _FormBuilderSegmentedControlState<T> createState() =>
      _FormBuilderSegmentedControlState<T>();
}

class _FormBuilderSegmentedControlState<T>
    extends FormBuilderFieldState<FormBuilderSegmentedControl<T>, T, T> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CupertinoSegmentedControl<T>(
              borderColor: readOnly
                  ? theme.disabledColor
                  : widget.borderColor ?? theme.primaryColor,
              selectedColor: readOnly
                  ? theme.disabledColor
                  : widget.selectedColor ?? theme.primaryColor,
              pressedColor: readOnly
                  ? theme.disabledColor
                  : widget.pressedColor ?? theme.primaryColor,
              groupValue: field.value,
              children: {
                for (var option in widget.options)
                  option.value: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    // ignore: deprecated_member_use_from_same_package
                    child: widget.textStyle != null
                        ? Text(
                            // ignore: deprecated_member_use_from_same_package
                            '${option.label ?? option.value}',
                            // ignore: deprecated_member_use_from_same_package
                            style: widget.textStyle,
                          )
                        : option,
                  ),
              },
              padding: widget.padding,
              unselectedColor: widget.unselectedColor,
              onValueChanged: (T value) {
                FocusScope.of(context).requestFocus(FocusNode());
                if (readOnly) {
                  field.reset();
                } else {
                  field.didChange(value);
                  widget.onChanged?.call(value);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
