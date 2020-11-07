import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderRangeSlider extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final RangeValues initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final num max;
  final num min;
  final int divisions;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<RangeValues> onChangeStart;
  final ValueChanged<RangeValues> onChangeEnd;
  final RangeLabels labels;
  final SemanticFormatterCallback semanticFormatterCallback;
  final FormFieldSetter onSaved;
  final DisplayValues displayValues;

  FormBuilderRangeSlider({
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
    this.labels,
    this.semanticFormatterCallback,
    this.onSaved,
    this.displayValues = DisplayValues.all,
  }) : super(key: key);

  @override
  _FormBuilderRangeSliderState createState() => _FormBuilderRangeSliderState();
}

class _FormBuilderRangeSliderState extends State<FormBuilderRangeSlider> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  RangeValues _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        ((_formState?.initialValue?.containsKey(widget.attribute) ?? false)
            ? _formState.initialValue[widget.attribute]
            : null);
    super.initState();
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = _formState?.readOnly == true || widget.readOnly;

    return FormField(
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _initialValue,
      validator: (val) =>
          FormBuilderValidators.validateValidators(val, widget.validators),
      onSaved: (val) {
        var transformed;
        if (widget.valueTransformer != null) {
          transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else {
          _formState?.setAttributeValue(widget.attribute, val);
        }
        widget.onSaved?.call(transformed ?? val);
      },
      builder: (FormFieldState<RangeValues> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
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
                  onChanged: _readOnly
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
                    Spacer(),
                    if (widget.displayValues != DisplayValues.none &&
                        widget.displayValues != DisplayValues.minMax)
                      Text('${field.value.start}   -   ${field.value.end}'),
                    Spacer(),
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
