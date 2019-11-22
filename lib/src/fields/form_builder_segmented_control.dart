import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSegmentedControl extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final Color borderColor;
  final Color selectedColor;
  final Color pressedColor;
  final FormFieldSetter onSaved;

  @Deprecated(
      "Use `FormBuilderFieldOption`'s `child` property to style your option")
  final TextStyle textStyle;

  final List<FormBuilderFieldOption> options;

  final EdgeInsetsGeometry padding;

  final Color unselectedColor;

  FormBuilderSegmentedControl({
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.borderColor,
    this.selectedColor,
    this.pressedColor,
    this.textStyle,
    this.padding,
    this.unselectedColor,
    this.onSaved,
  });

  @override
  _FormBuilderSegmentedControlState createState() =>
      _FormBuilderSegmentedControlState();
}

class _FormBuilderSegmentedControlState
    extends State<FormBuilderSegmentedControl> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  dynamic _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        (_formState.initialValue.containsKey(widget.attribute)
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
    _readOnly = (_formState?.readOnly == true) ? true : widget.readOnly;

    return FormField(
      key: _fieldKey,
      initialValue: _initialValue,
      enabled: !_readOnly,
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        return null;
      },
      onSaved: (val) {
        var transformed;
        if (widget.valueTransformer != null) {
          transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, val);
        if (widget.onSaved != null) {
          widget.onSaved(transformed ?? val);
        }
      },
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
            errorText: field.errorText,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: CupertinoSegmentedControl(
              borderColor: _readOnly
                  ? Theme.of(context).disabledColor
                  : widget.borderColor ?? Theme.of(context).primaryColor,
              selectedColor: _readOnly
                  ? Theme.of(context).disabledColor
                  : widget.selectedColor ?? Theme.of(context).primaryColor,
              pressedColor: _readOnly
                  ? Theme.of(context).disabledColor
                  : widget.pressedColor ?? Theme.of(context).primaryColor,
              groupValue: field.value,
              children: Map.fromIterable(
                widget.options,
                key: (option) => option.value,
                value: (option) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  // ignore: deprecated_member_use_from_same_package
                  child: widget.textStyle != null
                      ? Text(
                          "${option.label ?? option.value}",
                          // ignore: deprecated_member_use_from_same_package
                          style: widget.textStyle,
                        )
                      : option,
                ),
              ),
              padding: widget.padding,
              unselectedColor: widget.unselectedColor,
              onValueChanged: (dynamic value) {
                FocusScope.of(context).requestFocus(FocusNode());
                if (_readOnly) {
                  field.reset();
                } else {
                  field.didChange(value);
                  if (widget.onChanged != null) widget.onChanged(value);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
