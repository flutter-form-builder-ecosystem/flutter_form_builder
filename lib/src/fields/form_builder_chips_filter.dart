import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderFilterChip<T> extends FormBuilderField<List<T>> {
  final List<FormBuilderFieldOption<T>> options;

  // FilterChip Settings
  final double elevation, pressElevation;
  final Color selectedColor,
      disabledColor,
      backgroundColor,
      selectedShadowColor,
      shadowColor;
  final ShapeBorder shape;
  final MaterialTapTargetSize materialTapTargetSize;

  // Wrap Settings
  final Axis direction;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;
  final WrapAlignment runAlignment;
  final double runSpacing, spacing;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final EdgeInsets padding;
  final Color checkmarkColor;
  final Clip clipBehavior;
  final TextStyle labelStyle;
  final bool showCheckmark;
  final EdgeInsets labelPadding;
  // final VisualDensity visualDensity;

  FormBuilderFilterChip({
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
    // this.visualDensity,
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
  _FormBuilderFilterChipState<T> createState() =>
      _FormBuilderFilterChipState<T>();
}

class _FormBuilderFilterChipState<T>
    extends FormBuilderFieldState<FormBuilderFilterChip<T>, List<T>, List<T>> {
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
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: Wrap(
            direction: widget.direction,
            alignment: widget.alignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            runAlignment: widget.runAlignment,
            runSpacing: widget.runSpacing,
            spacing: widget.spacing,
            textDirection: widget.textDirection,
            verticalDirection: widget.verticalDirection,
            children: <Widget>[
              for (FormBuilderFieldOption<T> option in widget.options)
                FilterChip(
                  label: option,
                  selected: field.value.contains(option.value),
                  onSelected: readOnly
                      ? null
                      : (bool selected) {
                          setState(
                            () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              var currentValue = [...field.value];

                              if (selected) {
                                currentValue.add(option.value);
                              } else {
                                currentValue.remove(option.value);
                              }

                              field.didChange(currentValue);
                              widget.onChanged?.call(currentValue);
                            },
                          );
                        },
                  selectedColor: widget.selectedColor,
                  disabledColor: widget.disabledColor,
                  backgroundColor: widget.backgroundColor,
                  shadowColor: widget.shadowColor,
                  selectedShadowColor: widget.selectedShadowColor,
                  shape: widget.shape,
                  elevation: widget.elevation,
                  pressElevation: widget.pressElevation,
                  materialTapTargetSize: widget.materialTapTargetSize,
                  padding: widget.padding,
                  checkmarkColor: widget.checkmarkColor,
                  clipBehavior: widget.clipBehavior,
                  labelStyle: widget.labelStyle,
                  showCheckmark: widget.showCheckmark,
                  labelPadding: widget.labelPadding,
                  // visualDensity: widget.visualDensity,
                ),
            ],
          ),
        );
      },
    );
  }
}
