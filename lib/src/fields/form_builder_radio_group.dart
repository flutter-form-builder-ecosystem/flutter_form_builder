import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field to select one value from a list of Radio Widgets
class FormBuilderRadioGroup<T> extends FormBuilderFieldDecoration<T> {
  final Axis wrapDirection;
  final Color? activeColor;
  final Color? focusColor;
  final Color? hoverColor;
  final ControlAffinity controlAffinity;
  final double wrapRunSpacing;
  final double wrapSpacing;
  final List<FormBuilderFieldOption<T>> options;
  final List<T>? disabled;
  final MaterialTapTargetSize? materialTapTargetSize;
  final OptionsOrientation orientation;
  final TextDirection? wrapTextDirection;
  final VerticalDirection wrapVerticalDirection;
  final Widget? separator;
  final WrapAlignment wrapAlignment;
  final WrapAlignment wrapRunAlignment;
  final WrapCrossAlignment wrapCrossAxisAlignment;

  /// Added to each item if provided.
  /// [GroupedRadio] applies the [itemDecorator] to each Radio
  final BoxDecoration? itemDecoration;

  /// Creates field to select one value from a list of Radio Widgets
  FormBuilderRadioGroup({
    super.autovalidateMode = AutovalidateMode.disabled,
    super.enabled,
    super.focusNode,
    super.onSaved,
    super.validator,
    super.decoration,
    super.key,
    required super.name,
    required this.options,
    super.initialValue,
    this.activeColor,
    this.controlAffinity = ControlAffinity.leading,
    this.disabled,
    this.focusColor,
    this.hoverColor,
    this.materialTapTargetSize,
    this.orientation = OptionsOrientation.wrap,
    this.separator,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapCrossAxisAlignment = WrapCrossAlignment.start,
    this.wrapDirection = Axis.horizontal,
    this.wrapRunAlignment = WrapAlignment.start,
    this.wrapRunSpacing = 0.0,
    this.wrapSpacing = 0.0,
    this.wrapTextDirection,
    this.wrapVerticalDirection = VerticalDirection.down,
    super.onChanged,
    super.valueTransformer,
    super.onReset,
    super.restorationId,
    this.itemDecoration,
  }) : super(
          builder: (FormFieldState<T?> field) {
            final state = field as _FormBuilderRadioGroupState<T>;

            return InputDecorator(
              decoration: state.decoration,
              child: GroupedRadio<T>(
                activeColor: activeColor,
                controlAffinity: controlAffinity,
                disabled: state.enabled
                    ? disabled
                    : options.map((option) => option.value).toList(),
                focusColor: focusColor,
                hoverColor: hoverColor,
                materialTapTargetSize: materialTapTargetSize,
                onChanged: (value) {
                  state.didChange(value);
                },
                options: options,
                orientation: orientation,
                separator: separator,
                value: state.value,
                wrapAlignment: wrapAlignment,
                wrapCrossAxisAlignment: wrapCrossAxisAlignment,
                wrapDirection: wrapDirection,
                wrapRunAlignment: wrapRunAlignment,
                wrapRunSpacing: wrapRunSpacing,
                wrapSpacing: wrapSpacing,
                wrapTextDirection: wrapTextDirection,
                wrapVerticalDirection: wrapVerticalDirection,
                itemDecoration: itemDecoration,
              ),
            );
          },
        );

  @override
  FormBuilderFieldDecorationState<FormBuilderRadioGroup<T>, T> createState() =>
      _FormBuilderRadioGroupState<T>();
}

class _FormBuilderRadioGroupState<T>
    extends FormBuilderFieldDecorationState<FormBuilderRadioGroup<T>, T> {}
