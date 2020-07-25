import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';

@Deprecated('Use `FormBuilderTouchSpin` instead.')
class FormBuilderStepper extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final num initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final num step;
  final num min;
  final num max;
  final num size;
  final FormFieldSetter onSaved;
  final Icon subtractIcon;
  final Icon addIcon;

  final double iconSize;

  final NumberFormat displayFormat;

  final EdgeInsets iconPadding;

  final TextStyle textStyle;

  final Color iconActiveColor;

  final Color iconDisabledColor;

  FormBuilderStepper({
    Key key,
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.step,
    this.min = 1,
    this.max = 9999,
    @Deprecated('Use `iconSize` instead') this.size,
    this.onChanged,
    this.valueTransformer,
    this.onSaved,
    this.iconSize = 24.0,
    this.displayFormat,
    this.subtractIcon = const Icon(Icons.remove),
    this.addIcon = const Icon(Icons.add),
    this.iconPadding = const EdgeInsets.all(4.0),
    this.textStyle = const TextStyle(fontSize: 24),
    this.iconActiveColor,
    this.iconDisabledColor,
  })  : assert(size != null || iconSize != null),
        super(key: key);

  @override
  _FormBuilderStepperState createState() => _FormBuilderStepperState();
}

// ignore: deprecated_member_use_from_same_package
class _FormBuilderStepperState extends State<FormBuilderStepper> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  num _initialValue;

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
      enabled: !_readOnly,
      key: _fieldKey,
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
          child: TouchSpin(
            min: widget.min,
            max: widget.max,
            step: widget.step,
            value: field.value,
            iconSize: widget.size ?? widget.iconSize,
            onChanged: _readOnly
                ? null
                : (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    field.didChange(value);
                    widget.onChanged?.call(value);
                  },
            displayFormat: widget.displayFormat,
            textStyle: widget.textStyle,
            addIcon: widget.addIcon,
            subtractIcon: widget.subtractIcon,
            iconActiveColor:
                widget.iconActiveColor ?? Theme.of(context).primaryColor,
            iconDisabledColor:
                widget.iconDisabledColor ?? Theme.of(context).disabledColor,
            iconPadding: widget.iconPadding,
            enabled: !_readOnly,
          ),
        );
      },
    );
  }
}
