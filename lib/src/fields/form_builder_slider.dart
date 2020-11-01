import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

enum DisplayValues { all, current, minMax, none }

class FormBuilderSlider extends FormBuilderField<double> {
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
  final FocusNode focusNode;
  final bool autofocus;
  final MouseCursor mouseCursor;

  FormBuilderSlider({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    double initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<double> onChanged,
    FormFieldSetter<double> onSaved,
    ValueTransformer<double> valueTransformer,
    List<FormFieldValidator<double>> validators = const [],
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
    this.textStyle = const TextStyle(),
    this.maxTextStyle,
    this.focusNode,
    this.autofocus = false,
    this.mouseCursor,
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
  _FormBuilderSliderState createState() => _FormBuilderSliderState();
}

class _FormBuilderSliderState
    extends FormBuilderFieldState<FormBuilderSlider, double, double> {
  NumberFormat _numberFormat;

  @override
  void initState() {
    super.initState();
    _numberFormat = widget.numberFormat ?? NumberFormat('##0.0');
  }

  @override
  Widget build(BuildContext context) {
    return FormField<double>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<double> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: field.value,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  activeColor: widget.activeColor,
                  inactiveColor: widget.inactiveColor,
                  onChangeEnd: widget.onChangeEnd,
                  onChangeStart: widget.onChangeStart,
                  label: widget.label,
                  semanticFormatterCallback: widget.semanticFormatterCallback,
                  focusNode: widget.focusNode,
                  autofocus: widget.autofocus,
                  mouseCursor: widget.mouseCursor,
                  onChanged: readOnly
                      ? null
                      : (double value) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          field.didChange(value);
                          widget.onChanged?.call(value);
                        },
                ),
                Row(
                  children: <Widget>[
                    if (widget.displayValues != DisplayValues.none &&
                        widget.displayValues != DisplayValues.current)
                      Text(
                        _numberFormat.format(widget.min),
                        style: widget.minTextStyle ?? widget.textStyle,
                      ),
                    const Spacer(),
                    if (widget.displayValues != DisplayValues.none &&
                        widget.displayValues != DisplayValues.minMax)
                      Text(
                        _numberFormat.format(field.value),
                        style: widget.textStyle,
                      ),
                    const Spacer(),
                    if (widget.displayValues != DisplayValues.none &&
                        widget.displayValues != DisplayValues.current)
                      Text(
                        _numberFormat.format(widget.max),
                        style: widget.maxTextStyle ?? widget.textStyle,
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
