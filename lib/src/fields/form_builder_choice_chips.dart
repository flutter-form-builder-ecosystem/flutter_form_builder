import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChoiceChip extends FormBuilderField<dynamic> {
  // FormBuilder Settings
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;
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

  FormBuilderChoiceChip(
      {Key key,
      @required this.attribute,
      @required this.options,
      this.initialValue,
      this.validators = const [],
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
      this.verticalDirection = VerticalDirection.down})
      : super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validators: validators,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            builder: (field) {
              _FormBuilderChoiceChipState state = field;
              return InputDecorator(
                decoration: decoration.copyWith(
                  enabled: state.readOnly,
                  errorText: field.errorText,
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
                      )
                  ],
                ),
              );
            });

  @override
  _FormBuilderChoiceChipState createState() => _FormBuilderChoiceChipState();
}

class _FormBuilderChoiceChipState extends FormBuilderFieldState<dynamic> {}
