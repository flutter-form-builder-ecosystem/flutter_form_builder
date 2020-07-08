import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChoiceChip extends FormBuilderField<dynamic> {
  // FormBuilder Settings
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final dynamic initialValue;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueChanged onChanged;
  @override
  final FormFieldSetter onSaved;
  @override
  final ValueTransformer valueTransformer;
  final List<FormBuilderFieldOption> options;

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
  final TextStyle labelStyle;
  final EdgeInsets padding;
  final VisualDensity visualDensity;

  FormBuilderChoiceChip({
    Key key,
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validator,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.onSaved,
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
    this.visualDensity,
  }) : super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            builder: (FormFieldState field) {
              final _FormBuilderChoiceChipState state = field;

              return InputDecorator(
                decoration: decoration.copyWith(
                  enabled: !state.readOnly,
                  errorText: decoration?.errorText ?? field.errorText,
                ),
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
                    for (FormBuilderFieldOption option in options)
                      ChoiceChip(
                        selectedColor: selectedColor,
                        disabledColor: disabledColor,
                        backgroundColor: backgroundColor,
                        shadowColor: shadowColor,
                        selectedShadowColor: selectedShadowColor,
                        shape: shape,
                        elevation: elevation,
                        pressElevation: pressElevation,
                        materialTapTargetSize: materialTapTargetSize,
                        label: option.child,
                        selected: field.value == option.value,
                        onSelected: state.readOnly
                            ? null
                            : (bool selected) {
                                var choice = selected ? option.value : null;
                                field.didChange(choice);
                              },
                        labelStyle: labelStyle,
                        labelPadding: labelPadding,
                        padding: padding,
                        visualDensity: visualDensity,
                      ),
                  ],
                ),
              );
            });

  @override
  _FormBuilderChoiceChipState createState() => _FormBuilderChoiceChipState();
}

class _FormBuilderChoiceChipState extends FormBuilderFieldState<dynamic> {}
