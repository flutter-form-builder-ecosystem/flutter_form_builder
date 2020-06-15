import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderRangeSlider extends FormBuilderField {
  final String attribute;
  final FormFieldValidator validator;
  final RangeValues initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final double max;
  final double min;
  final int divisions;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<RangeValues> onChangeStart;
  final ValueChanged<RangeValues> onChangeEnd;
  final RangeLabels labels;
  final RangeSemanticFormatterCallback semanticFormatterCallback;
  final FormFieldSetter onSaved;

  FormBuilderRangeSlider({
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
    this.labels,
    this.semanticFormatterCallback,
    this.onSaved,
  }) : super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            builder: (FormFieldState field) {
              final _FormBuilderRangeSliderState state = field;
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
                      RangeSlider(
                        values: field.value,
                        min: min,
                        max: max,
                        divisions: divisions,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        onChangeEnd: onChangeEnd,
                        onChangeStart: onChangeStart,
                        labels: labels,
                        semanticFormatterCallback: semanticFormatterCallback,
                        onChanged: state.readOnly
                            ? null
                            : (RangeValues values) {
                                field.didChange(values);
                              },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("$min"),
                          Text("${field.value.start}   -   ${field.value.end}"),
                          Text("$max"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });

  @override
  _FormBuilderRangeSliderState createState() => _FormBuilderRangeSliderState();
}

class _FormBuilderRangeSliderState extends FormBuilderFieldState {
  FormBuilderRangeSlider get widget => super.widget;
}
