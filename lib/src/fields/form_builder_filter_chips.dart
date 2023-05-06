import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field with chips that acts like a list checkboxes.
class FormBuilderFilterChip<T> extends FormBuilderFieldDecoration<List<T>> {
  //TODO: Add documentation
  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? selectedColor;
  final Color? selectedShadowColor;
  final Color? shadowColor;
  final double? elevation, pressElevation;
  final List<FormBuilderChipOption<T>> options;
  final MaterialTapTargetSize? materialTapTargetSize;
  final OutlinedBorder? shape;

  // Wrap Settings
  final Axis direction;
  final bool showCheckmark;
  final Clip clipBehavior;
  final Color? checkmarkColor;
  final double runSpacing, spacing;
  final EdgeInsets? labelPadding;
  final EdgeInsets? padding;
  final TextDirection? textDirection;
  final TextStyle? labelStyle;
  final VerticalDirection verticalDirection;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;

  final int? maxChips;
  final ShapeBorder avatarBorder;

  /// Creates field with chips that acts like a list checkboxes.
  FormBuilderFilterChip({
    super.autovalidateMode = AutovalidateMode.disabled,
    super.enabled,
    super.focusNode,
    super.onSaved,
    super.validator,
    super.decoration,
    super.key,
    super.initialValue,
    required super.name,
    super.restorationId,
    required this.options,
    this.alignment = WrapAlignment.start,
    this.avatarBorder = const CircleBorder(),
    this.backgroundColor,
    this.checkmarkColor,
    this.clipBehavior = Clip.none,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.direction = Axis.horizontal,
    this.disabledColor,
    this.elevation,
    this.labelPadding,
    this.labelStyle,
    this.materialTapTargetSize,
    this.maxChips,
    this.padding,
    this.pressElevation,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.selectedColor,
    this.selectedShadowColor,
    this.shadowColor,
    this.shape,
    this.showCheckmark = true,
    this.spacing = 0.0,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    super.onChanged,
    super.valueTransformer,
    super.onReset,
  })  : assert((maxChips == null) || ((initialValue ?? []).length <= maxChips)),
        super(
          builder: (FormFieldState<List<T>?> field) {
            final state = field as _FormBuilderFilterChipState<T>;
            final fieldValue = field.value ?? [];

            return InputDecorator(
              decoration: state.decoration,
              child: Wrap(
                direction: direction,
                alignment: alignment,
                crossAxisAlignment: crossAxisAlignment,
                runAlignment: runAlignment,
                runSpacing: runSpacing,
                spacing: spacing,
                textDirection: textDirection,
                verticalDirection: verticalDirection,
                children: <Widget>[
                  for (FormBuilderChipOption<T> option in options)
                    FilterChip(
                      label: option,
                      selected: fieldValue.contains(option.value),
                      avatar: option.avatar,
                      onSelected: state.enabled &&
                              (null == maxChips ||
                                  fieldValue.length < maxChips ||
                                  fieldValue.contains(option.value))
                          ? (selected) {
                              final currentValue = [...fieldValue];
                              selected
                                  ? currentValue.add(option.value)
                                  : currentValue.remove(option.value);

                              field.didChange(currentValue);
                            }
                          : null,
                      selectedColor: selectedColor,
                      disabledColor: disabledColor,
                      backgroundColor: backgroundColor,
                      shadowColor: shadowColor,
                      selectedShadowColor: selectedShadowColor,
                      elevation: elevation,
                      pressElevation: pressElevation,
                      materialTapTargetSize: materialTapTargetSize,
                      padding: padding,
                      shape: shape,
                      checkmarkColor: checkmarkColor,
                      clipBehavior: clipBehavior,
                      labelStyle: labelStyle,
                      showCheckmark: showCheckmark,
                      labelPadding: labelPadding,
                      avatarBorder: avatarBorder,
                    ),
                ],
              ),
            );
          },
        );

  @override
  FormBuilderFieldDecorationState<FormBuilderFilterChip<T>, List<T>>
      createState() => _FormBuilderFilterChipState<T>();
}

class _FormBuilderFilterChipState<T> extends FormBuilderFieldDecorationState<
    FormBuilderFilterChip<T>, List<T>> {}
