import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

enum DisplayValues { all, current, minMax, none }

class FormBuilderSlider extends StatefulWidget {
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
  final DisplayValues displayValues;

  final TextStyle minTextStyle;
  final TextStyle textStyle;
  final TextStyle maxTextStyle;
  final FocusNode focusNode;
  final bool autofocus;
  final MouseCursor mouseCursor;

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
    this.displayValues = DisplayValues.all,
    this.minTextStyle,
    this.textStyle = const TextStyle(),
    this.maxTextStyle,
    this.focusNode,
    this.autofocus = false,
    this.mouseCursor,
  }) : super(key: key);

  @override
  _FormBuilderSliderState createState() => _FormBuilderSliderState();
}

class _FormBuilderSliderState extends State<FormBuilderSlider> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  double _initialValue;
  NumberFormat _numberFormat;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        ((_formState?.initialValue?.containsKey(widget.attribute) ?? false)
            ? _formState.initialValue[widget.attribute]
            : null);
    _numberFormat = widget.numberFormat ?? NumberFormat('##0.0');
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
      builder: (FormFieldState<dynamic> field) {
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
                  onChanged: _readOnly
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
                        '${_numberFormat.format(widget.min)}',
                        style: widget.minTextStyle ?? widget.textStyle,
                      ),
                    Spacer(),
                    if (widget.displayValues != DisplayValues.none &&
                        widget.displayValues != DisplayValues.minMax)
                      Text(
                        '${_numberFormat.format(field.value)}',
                        style: widget.textStyle,
                      ),
                    Spacer(),
                    if (widget.displayValues != DisplayValues.none &&
                        widget.displayValues != DisplayValues.current)
                      Text(
                        '${_numberFormat.format(widget.max)}',
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
