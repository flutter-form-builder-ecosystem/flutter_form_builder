import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:group_radio_button/group_radio_button.dart';

class FormBuilderRadioGroup extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final bool leadingInput;
  final List<FormBuilderFieldOption> options;
  final MaterialTapTargetSize materialTapTargetSize;
  final Color activeColor;
  final FormFieldSetter onSaved;
  final EdgeInsets contentPadding;

  FormBuilderRadioGroup({
    Key key,
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.leadingInput = false,
    this.materialTapTargetSize,
    this.activeColor,
    this.onSaved,
    this.contentPadding = const EdgeInsets.all(0.0),
  }) : super(key: key);

  @override
  _FormBuilderRadioGroupState createState() => _FormBuilderRadioGroupState();
}

class _FormBuilderRadioGroupState extends State<FormBuilderRadioGroup> {
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
          child: RadioGroup.builder(
            groupValue: field.value,
            onChanged: _readOnly
                ? null
                : (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    field.didChange(value);
                    if (widget.onChanged != null) widget.onChanged(value);
                  },
            items: widget.options
                .map((option) => option.value)
                .toList(growable: false),
            itemBuilder: (item) {
              return RadioButtonBuilder(
                item.toString(),
                textPosition: RadioButtonTextPosition.right,
              );
            },
            direction: Axis.horizontal,
            horizontalAlignment: MainAxisAlignment.start,
            spacebetween: 40,
          ),
        );
      },
    );
  }
}
