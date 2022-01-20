import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field with chips that acts like a list checkboxes.
class FormBuilderFilterChip<T> extends FormBuilderField<List<T>> {
  //TODO: Add documentation
  final bool shouldRequestFocus;
  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? selectedColor;
  final Color? selectedShadowColor;
  final Color? shadowColor;
  final double? elevation, pressElevation;
  final List<FormBuilderFieldOption<T>> options;
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

  /// Creates field with chips that acts like a list checkboxes.
  FormBuilderFilterChip({
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    FocusNode? focusNode,
    FormFieldSetter<List<T>>? onSaved,
    FormFieldValidator<List<T>>? validator,
    InputDecoration decoration = const InputDecoration(),
    Key? key,
    List<T> initialValue = const [],
    required String name, // From Super
    required this.options,
    this.alignment = WrapAlignment.start,
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
    this.shouldRequestFocus = false,
    this.showCheckmark = true,
    this.spacing = 0.0,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    ValueChanged<List<T>?>? onChanged,
    ValueTransformer<List<T>?>? valueTransformer,
    VoidCallback? onReset,
  })  : assert((maxChips == null) || (initialValue.length <= maxChips)),
        super(
          autovalidateMode: autovalidateMode,
          decoration: decoration,
          enabled: enabled,
          focusNode: focusNode,
          initialValue: initialValue,
          key: key,
          name: name,
          onChanged: onChanged,
          onReset: onReset,
          onSaved: onSaved,
          validator: validator,
          valueTransformer: valueTransformer,
          builder: (FormFieldState<List<T>?> field) {
            final state = field as _FormBuilderFilterChipState<T>;

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
                  for (FormBuilderFieldOption<T> option in options)
                    FilterChip(
                      label: option,
                      selected: field.value!.contains(option.value),
                      onSelected: state.enabled &&
                              (null == maxChips ||
                                  field.value!.length < maxChips ||
                                  field.value!.contains(option.value))
                          ? (selected) {
                              final currentValue = [...field.value!];
                              if (selected) {
                                currentValue.add(option.value);
                              } else {
                                currentValue.remove(option.value);
                              }
                              if (shouldRequestFocus) {
                                state.requestFocus();
                              }
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
                      checkmarkColor: checkmarkColor,
                      clipBehavior: clipBehavior,
                      labelStyle: labelStyle,
                      showCheckmark: showCheckmark,
                      labelPadding: labelPadding,
                    ),
                ],
              ),
            );
          },
        );

  @override
  _FormBuilderFilterChipState<T> createState() =>
      _FormBuilderFilterChipState<T>();
}

class _FormBuilderFilterChipState<T>
    extends FormBuilderFieldState<FormBuilderFilterChip<T>, List<T>> {}
