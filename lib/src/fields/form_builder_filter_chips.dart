import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderFilterChip extends FormBuilderField<dynamic> {
  final List<FormBuilderFieldOption> options;
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
    //From Super
    @required String name,
    FormFieldValidator validator,
    List initialValue = const [],
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
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
            initialValue: initialValue,
            name: name,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            autovalidateMode: autovalidateMode,
            onSaved: onSaved,
            enabled: enabled,
            onReset: onReset,
            decoration: decoration,
            focusNode: focusNode,
            builder: (FormFieldState field) {
              final _FormBuilderFilterChipState state = field;
              return InputDecorator(
                decoration: decoration.copyWith(
                  enabled: state.readOnly,
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
                      FilterChip(
                        label: option.child,
                        selected: field.value.contains(option.value),
                        onSelected: state.readOnly
                            ? null
                            : (bool selected) {
                                var currentValue = [...field.value];
                                if (selected) {
                                  currentValue.add(option.value);
                                } else {
                                  currentValue.remove(option.value);
                                }
                                state.requestFocus();
                                field.didChange(currentValue);
                              },
                        selectedColor: selectedColor,
                        disabledColor: disabledColor,
                        backgroundColor: backgroundColor,
                        shadowColor: shadowColor,
                        selectedShadowColor: selectedShadowColor,
                        shape: shape,
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
            });

  @override
  _FormBuilderFilterChipState createState() => _FormBuilderFilterChipState();
}

class _FormBuilderFilterChipState extends FormBuilderFieldState<dynamic> {
  @override
  FormBuilderFilterChip get widget => super.widget as FormBuilderFilterChip;
}
