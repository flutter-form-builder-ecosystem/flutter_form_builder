import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChoiceChip<T> extends FormBuilderField<T> {
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
  final EdgeInsets labelPadding;
  final EdgeInsets padding;
  final TextStyle labelStyle;

  FormBuilderChoiceChip({
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
    this.labelPadding,
    this.labelStyle,
    this.padding,
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
  _FormBuilderChoiceChipState<T> createState() =>
      _FormBuilderChoiceChipState<T>();
}

class _FormBuilderChoiceChipState<T>
    extends FormBuilderFieldState<FormBuilderChoiceChip<T>, T, T> {
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
                  ChoiceChip(
                    selectedColor: widget.selectedColor,
                    disabledColor: widget.disabledColor,
                    backgroundColor: widget.backgroundColor,
                    shadowColor: widget.shadowColor,
                    selectedShadowColor: widget.selectedShadowColor,
                    shape: widget.shape,
                    elevation: widget.elevation,
                    pressElevation: widget.pressElevation,
                    materialTapTargetSize: widget.materialTapTargetSize,
                    label: option,
                    selected: field.value == option.value,
                    onSelected: readOnly
                        ? null
                        : (bool selected) {
                            setState(() {
                              FocusScope.of(context).requestFocus(FocusNode());
                              var choice = selected ? option.value : null;
                              field.didChange(choice);
                              widget.onChanged?.call(choice);
                            });
                          },
                    labelPadding: widget.labelPadding,
                    labelStyle: widget.labelStyle,
                    padding: widget.padding,
                  ),
              ]),
        );
      },
    );
  }
}
