import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

enum DisplayValues { all, current, minMax, none }

class FormBuilderSlider extends FormBuilderField {
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
  final TextStyle minTextStyle;
  final TextStyle textStyle;
  final TextStyle maxTextStyle;
  final bool autofocus;
  final MouseCursor mouseCursor;

  FormBuilderSlider({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    @required double initialValue,
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
    this.label,
    this.semanticFormatterCallback,
    this.numberFormat,
    this.displayValues = DisplayValues.all,
    this.minTextStyle,
    this.textStyle,
    this.maxTextStyle,
    this.autofocus = false,
    this.mouseCursor,
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
            final _FormBuilderSliderState state = field;
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
                              state.requestFocus();
                              field.didChange(value);
                            },
                      autofocus: autofocus,
                      mouseCursor: mouseCursor,
                      focusNode: state.effectiveFocusNode,
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
                            '${_numberFormat.format(field.value)}',
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
          },
        );

  @override
  _FormBuilderSliderState createState() => _FormBuilderSliderState();
}

class _FormBuilderSliderState extends FormBuilderFieldState {
  @override
  FormBuilderSlider get widget => super.widget as FormBuilderSlider;
}
