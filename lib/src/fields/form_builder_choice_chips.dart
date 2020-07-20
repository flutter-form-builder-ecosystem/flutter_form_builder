import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChoiceChip<T> extends FormBuilderField<T> {
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
    //From Super
    @required String attribute,
    FormFieldValidator validator,
    T initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    bool autovalidate = false,
    VoidCallback onReset,
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
    this.visualDensity,
  }) : super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            autovalidate: autovalidate,
            onSaved: onSaved,
            enabled: enabled,
            onReset: onReset,
            decoration: decoration,
            builder: (FormFieldState<T> field) {
              final _FormBuilderChoiceChipState<T> state = field;

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
  _FormBuilderChoiceChipState<T> createState() => _FormBuilderChoiceChipState();
}

class _FormBuilderChoiceChipState<T> extends FormBuilderFieldState<T> {
  @override
  FormBuilderChoiceChip<T> get widget => super.widget;
}
