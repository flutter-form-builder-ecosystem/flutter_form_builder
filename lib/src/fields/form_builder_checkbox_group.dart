import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/grouped_checkbox.dart';

class FormBuilderCheckboxGroup<T> extends FormBuilderField<List<T>> {
  final List<FormBuilderFieldOption<T>> options;
  final Color activeColor;
  final Color checkColor;
  final Color focusColor;
  final Color hoverColor;
  final List<T> disabled;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;
  final Axis wrapDirection;

  final WrapAlignment wrapAlignment;

  final double wrapSpacing;

  final WrapAlignment wrapRunAlignment;

  final double wrapRunSpacing;

  final WrapCrossAlignment wrapCrossAxisAlignment;

  final TextDirection wrapTextDirection;
  final VerticalDirection wrapVerticalDirection;
  final Widget separator;
  final ControlAffinity controlAffinity;

  final GroupedCheckboxOrientation orientation;

  FormBuilderCheckboxGroup({
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
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.disabled,
    this.materialTapTargetSize,
    this.tristate = false,
    this.wrapDirection = Axis.horizontal,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapSpacing = 0.0,
    this.wrapRunAlignment = WrapAlignment.start,
    this.wrapRunSpacing = 0.0,
    this.wrapCrossAxisAlignment = WrapCrossAlignment.start,
    this.wrapTextDirection,
    this.wrapVerticalDirection = VerticalDirection.down,
    this.separator,
    this.controlAffinity = ControlAffinity.leading,
    this.orientation = GroupedCheckboxOrientation.wrap,
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
  _FormBuilderCheckboxGroupState<T> createState() =>
      _FormBuilderCheckboxGroupState<T>();
}

class _FormBuilderCheckboxGroupState<T> extends FormBuilderFieldState<
    FormBuilderCheckboxGroup<T>, List<T>, List<T>> {
  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue,
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<List<T>> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: GroupedCheckbox<T>(
            orientation: widget.orientation,
            value: field.value,
            options: widget.options,
            onChanged: (val) {
              field.didChange(val);
              widget.onChanged?.call(val);
            },
            activeColor: widget.activeColor,
            focusColor: widget.focusColor,
            checkColor: widget.checkColor,
            materialTapTargetSize: widget.materialTapTargetSize,
            // TODO Confirm if this should be readOnly or !enabled
            disabled: readOnly
                ? widget.options.map((e) => e.value).toList()
                : widget.disabled,
            hoverColor: widget.hoverColor,
            tristate: widget.tristate,
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
