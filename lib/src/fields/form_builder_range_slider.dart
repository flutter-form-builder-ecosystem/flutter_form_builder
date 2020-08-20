import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class FormBuilderRangeSlider extends FormBuilderField {
  final double max;
  final double min;
  final int divisions;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<RangeValues> onChangeStart;
  final ValueChanged<RangeValues> onChangeEnd;
  final RangeLabels labels;
  final SemanticFormatterCallback semanticFormatterCallback;
  final DisplayValues displayValues;
  final TextStyle minTextStyle;
  final TextStyle textStyle;
  final TextStyle maxTextStyle;
  final NumberFormat numberFormat;

  FormBuilderRangeSlider({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    RangeValues initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    bool autovalidate = false,
    VoidCallback onReset,
    FocusNode focusNode,
    @required this.min,
    @required this.max,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.onChangeStart,
    this.onChangeEnd,
    this.labels,
    this.semanticFormatterCallback,
    this.displayValues = DisplayValues.all,
    this.minTextStyle,
    this.textStyle,
    this.maxTextStyle,
    this.numberFormat,
  }) : super(
            key: key,
            initialValue: initialValue,
            name: name,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            autovalidate: autovalidate,
            onSaved: onSaved,
            enabled: enabled,
            onReset: onReset,
            decoration: decoration,
            builder: (FormFieldState field) {
              final _FormBuilderRangeSliderState state = field;
              var _numberFormat = numberFormat ?? NumberFormat.compact();

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
                                state.requestFocus();
                                field.didChange(values);
                              },
                      ),
                      Row(
                        children: <Widget>[
                          if (displayValues != DisplayValues.none &&
                              displayValues != DisplayValues.current)
                            Text(
                              '${_numberFormat.format(min)}',
                              style: minTextStyle ?? textStyle,
                            ),
                          Spacer(),
                          if (displayValues != DisplayValues.none &&
                              displayValues != DisplayValues.minMax)
                            Text(
                              '${_numberFormat.format(field.value.start)} - ${_numberFormat.format(field.value.end)}',
                              style: textStyle,
                            ),
                          Spacer(),
                          if (displayValues != DisplayValues.none &&
                              displayValues != DisplayValues.current)
                            Text(
                              '${_numberFormat.format(max)}',
                              style: maxTextStyle ?? textStyle,
                            ),
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
  @override
  FormBuilderRangeSlider get widget => super.widget as FormBuilderRangeSlider;
}
