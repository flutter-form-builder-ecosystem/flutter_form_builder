import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

enum DisplayValues { all, current, minMax, none }

class FormBuilderSlider extends FormBuilderField {
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final double initialValue;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueChanged onChanged;
  @override
  final ValueTransformer valueTransformer;
  @override
  final FormFieldSetter onSaved;

  final double max;
  final double min;
  final int divisions;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<double> onChangeStart;
  final ValueChanged<double> onChangeEnd;
  final String label;
  final SemanticFormatterCallback semanticFormatterCallback;
  final NumberFormat numberFormat;
  final DisplayValues displayValues;

  FormBuilderSlider({
    Key key,
    @required this.attribute,
    @required this.min,
    @required this.max,
    @required this.initialValue,
    this.validator,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.divisions,
    this.onChanged,
    this.valueTransformer,
    this.activeColor,
    this.inactiveColor,
    this.onChangeStart,
    this.onChangeEnd,
    this.label,
    this.semanticFormatterCallback,
    this.numberFormat,
    this.onSaved,
    this.displayValues = DisplayValues.all,
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderSliderState state = field;
            // var _numberFormat = numberFormat ?? NumberFormat('##0.0');
            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Slider(
                      value: field.value,
                      min: min,
                      max: max,
                      divisions: divisions,
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                      onChangeEnd: onChangeEnd,
                      onChangeStart: onChangeStart,
                      label: label,
                      semanticFormatterCallback: semanticFormatterCallback,
                      onChanged: state.readOnly
                          ? null
                          : (double value) {
                              field.didChange(value);
                            },
                    ),
                    Row(
                      children: <Widget>[
                        if (displayValues != DisplayValues.none &&
                            displayValues != DisplayValues.current)
                          Text('${min}'),
                        Spacer(),
                        if (displayValues != DisplayValues.none &&
                            displayValues != DisplayValues.minMax)
                          Text('${field.value}'),
                        Spacer(),
                        if (displayValues != DisplayValues.none &&
                            displayValues != DisplayValues.current)
                          Text('${max}'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );

  @override
  _FormBuilderSliderState createState() => _FormBuilderSliderState();
}

class _FormBuilderSliderState extends FormBuilderFieldState {
  @override
  FormBuilderSlider get widget => super.widget;
}
