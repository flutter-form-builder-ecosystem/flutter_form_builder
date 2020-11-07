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
    Key key,
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
  }) : super(key: key);

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
    final theme = Theme.of(context);

    return FormField(
      key: _fieldKey,
      initialValue: _initialValue,
      enabled: !_readOnly,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CupertinoSegmentedControl(
              borderColor: _readOnly
                  ? theme.disabledColor
                  : widget.borderColor ?? theme.primaryColor,
              selectedColor: _readOnly
                  ? theme.disabledColor
                  : widget.selectedColor ?? theme.primaryColor,
              pressedColor: _readOnly
                  ? theme.disabledColor
                  : widget.pressedColor ?? theme.primaryColor,
              groupValue: field.value,
              children: {
                for (var option in widget.options)
                  option.value: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    // ignore: deprecated_member_use_from_same_package
                    child: widget.textStyle != null
                        ? Text(
                            // ignore: deprecated_member_use_from_same_package
                            '${option.label ?? option.value}',
                            // ignore: deprecated_member_use_from_same_package
                            style: widget.textStyle,
                          )
                        : option,
                  ),
              },
              padding: widget.padding,
              unselectedColor: widget.unselectedColor,
              onValueChanged: (dynamic value) {
                FocusScope.of(context).requestFocus(FocusNode());
                if (_readOnly) {
                  field.reset();
                } else {
                  field.didChange(value);
                  widget.onChanged?.call(value);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
