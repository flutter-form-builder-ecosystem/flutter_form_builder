import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderRangeSlider extends FormBuilderField<RangeValues> {
  final num max;
  final num min;
  final int divisions;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<RangeValues> onChangeStart;
  final ValueChanged<RangeValues> onChangeEnd;
  final RangeLabels labels;
  final SemanticFormatterCallback semanticFormatterCallback;
  final DisplayValues displayValues;

  FormBuilderRangeSlider({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    RangeValues initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<RangeValues> onChanged,
    FormFieldSetter<RangeValues> onSaved,
    ValueTransformer<RangeValues> valueTransformer,
    List<FormFieldValidator<RangeValues>> validators = const [],
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
  _FormBuilderRangeSliderState createState() => _FormBuilderRangeSliderState();
}

class _FormBuilderRangeSliderState extends FormBuilderFieldState<
    FormBuilderRangeSlider, RangeValues, RangeValues> {
  @override
  Widget build(BuildContext context) {
    return FormField<RangeValues>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue,
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<RangeValues> field) {
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
                RangeSlider(
                  values: field.value,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  activeColor: widget.activeColor,
                  inactiveColor: widget.inactiveColor,
                  onChangeEnd: widget.onChangeEnd,
                  onChangeStart: widget.onChangeStart,
                  labels: widget.labels,
                  semanticFormatterCallback: widget.semanticFormatterCallback,
                  onChanged: readOnly
                      ? null
                      : (RangeValues values) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          field.didChange(values);
                          widget.onChanged?.call(values);
                        },
                ),
                Row(
                  children: <Widget>[
                    if (widget.displayValues != DisplayValues.none &&
                        widget.displayValues != DisplayValues.current)
                      Text('${widget.min}'),
                    const Spacer(),
                    if (widget.displayValues != DisplayValues.none &&
                        widget.displayValues != DisplayValues.minMax)
                      Text('${field.value.start}   -   ${field.value.end}'),
                    const Spacer(),
                    if (widget.displayValues != DisplayValues.none &&
                        widget.displayValues != DisplayValues.current)
                      Text('${widget.max}'),
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
