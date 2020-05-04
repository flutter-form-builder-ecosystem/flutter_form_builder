import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class FormBuilderSlider extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final double initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

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
  final FormFieldSetter onSaved;

  FormBuilderSlider({
    Key key,
    @required this.attribute,
    @required this.min,
    @required this.max,
    @required this.initialValue,
    this.validators = const [],
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
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validators: validators,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderSliderState state = field;
            NumberFormat _numberFormat = numberFormat ?? NumberFormat("##0.0");
            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: field.errorText,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("${_numberFormat.format(min)}"),
                        Text("${_numberFormat.format(field.value)}"),
                        Text("${_numberFormat.format(max)}"),
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
  FormBuilderSlider get widget => super.widget;
}
