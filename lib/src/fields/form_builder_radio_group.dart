import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/grouped_checkbox.dart';
import 'package:flutter_form_builder/src/widgets/grouped_radio.dart';

class FormBuilderRadioGroup<T> extends FormBuilderField<T> {
  final List<FormBuilderFieldOption<T>> options;
  final MaterialTapTargetSize materialTapTargetSize;
  final Color activeColor;
  final Color focusColor;
  final Color hoverColor;
  final List disabled;
  final Axis wrapDirection;
  final WrapAlignment wrapAlignment;

  final double wrapSpacing;

  final WrapAlignment wrapRunAlignment;

  final double wrapRunSpacing;

  final WrapCrossAlignment wrapCrossAxisAlignment;

  final VerticalDirection wrapVerticalDirection;
  final TextDirection wrapTextDirection;
  final Widget separator;
  final ControlAffinity controlAffinity; // = ControlAffinity.leading;
  final GroupedRadioOrientation orientation; // = GroupedRadioOrientation.wrap;

  FormBuilderRadioGroup({
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
    this.materialTapTargetSize,
    this.wrapDirection = Axis.horizontal,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapSpacing = 0.0,
    this.wrapRunAlignment = WrapAlignment.start,
    this.wrapRunSpacing = 0.0,
    this.wrapCrossAxisAlignment = WrapCrossAlignment.start,
    this.wrapVerticalDirection = VerticalDirection.down,
    this.controlAffinity = ControlAffinity.leading,
    this.orientation = GroupedRadioOrientation.wrap,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.disabled,
    this.wrapTextDirection,
    this.separator,
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
  _FormBuilderRadioGroupState<T> createState() =>
      _FormBuilderRadioGroupState<T>();
}

class _FormBuilderRadioGroupState<T>
    extends FormBuilderFieldState<FormBuilderRadioGroup<T>, T, T> {
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
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: GroupedRadio<T>(
            orientation: widget.orientation,
            value: field.value,
            options: widget.options,
            onChanged: (val) {
              field.didChange(val);
              widget.onChanged?.call(val);
            },
            activeColor: widget.activeColor,
            focusColor: widget.focusColor,
            materialTapTargetSize: widget.materialTapTargetSize,
            disabled: !readOnly
                ? widget.disabled
                : widget.options.map((e) => e.value).toList(),
            hoverColor: widget.hoverColor,
            wrapAlignment: widget.wrapAlignment,
            wrapCrossAxisAlignment: widget.wrapCrossAxisAlignment,
            wrapDirection: widget.wrapDirection,
            wrapRunAlignment: widget.wrapRunAlignment,
            wrapRunSpacing: widget.wrapRunSpacing,
            wrapSpacing: widget.wrapSpacing,
            wrapTextDirection: widget.wrapTextDirection,
            wrapVerticalDirection: widget.wrapVerticalDirection,
            separator: widget.separator,
            controlAffinity: widget.controlAffinity,
          ),
        );
      },
    );
  }
}
