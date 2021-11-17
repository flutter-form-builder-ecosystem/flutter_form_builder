import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field with chips that acts like a list checkboxes.
class FormBuilderFilterChip<T> extends FormBuilderField<List<T>> {
  //TODO: Add documentation
  final List<FormBuilderFieldOption<T>> options;
  final double? elevation, pressElevation;
  final Color? selectedColor;
  final Color? disabledColor;
  final Color? backgroundColor;
  final Color? selectedShadowColor;
  final Color? shadowColor;
  final OutlinedBorder? shape;
  final MaterialTapTargetSize? materialTapTargetSize;

  // Wrap Settings
  final Axis direction;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;
  final WrapAlignment runAlignment;
  final double runSpacing, spacing;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final EdgeInsets? padding;
  final Color? checkmarkColor;
  final Clip clipBehavior;
  final TextStyle? labelStyle;
  final bool showCheckmark;
  final EdgeInsets? labelPadding;

  // final VisualDensity visualDensity;
  final int? maxChips;

  /// Creates field with chips that acts like a list checkboxes.
  FormBuilderFilterChip({
    Key? key,
    //From Super
    required String name,
    FormFieldValidator<List<T>>? validator,
    List<T> initialValue = const [],
    InputDecoration decoration = const InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    ),
    ValueChanged<List<T>?>? onChanged,
    ValueTransformer<List<T>?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<List<T>>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    required this.options,
    this.selectedColor,
    this.disabledColor,
    this.backgroundColor,
    this.shadowColor,
    this.selectedShadowColor,
    this.shape,
    this.elevation,
    this.pressElevation,
    this.materialTapTargetSize,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.spacing = 0.0,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.padding,
    this.checkmarkColor,
    this.clipBehavior = Clip.none,
    this.labelStyle,
    this.showCheckmark = true,
    this.labelPadding,
    this.maxChips,
    // this.visualDensity,
  })  : assert((maxChips == null) || (initialValue.length <= maxChips)),
        super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
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
                              state.requestFocus();
                              field.didChange(currentValue);
                            }
                          : null,
                      selectedColor: selectedColor,
                      disabledColor: disabledColor,
                      backgroundColor: backgroundColor,
                      shadowColor: shadowColor,
                      selectedShadowColor: selectedShadowColor,
                      // shape: shape,  //TODO: remove - latter flutter versions
                      elevation: elevation,
                      pressElevation: pressElevation,
                      materialTapTargetSize: materialTapTargetSize,
                      padding: padding,
                      checkmarkColor: checkmarkColor,
                      clipBehavior: clipBehavior,
                      labelStyle: labelStyle,
                      showCheckmark: showCheckmark,
                      labelPadding: labelPadding,
                      // visualDensity: visualDensity,
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
