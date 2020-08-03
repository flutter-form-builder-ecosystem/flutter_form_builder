import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@Deprecated('Prefer using `FormBuilderRadioGroup` instead')
class FormBuilderRadio extends StatefulWidget {
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

  FormBuilderRadio({
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
  _FormBuilderRadioState createState() => _FormBuilderRadioState();
}

// ignore: deprecated_member_use_from_same_package
class _FormBuilderRadioState extends State<FormBuilderRadio> {
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

  Widget _radio(FormFieldState<dynamic> field, int i) {
    return Radio<dynamic>(
      value: widget.options[i].value,
      groupValue: field.value,
      materialTapTargetSize: widget.materialTapTargetSize,
      activeColor: widget.activeColor,
      onChanged: _readOnly
          ? null
          : (dynamic value) {
              FocusScope.of(context).requestFocus(FocusNode());
              field.didChange(value);
              widget.onChanged?.call(value);
            },
    );
  }

  Widget _leading(FormFieldState<dynamic> field, int i) {
    return widget.leadingInput ? _radio(field, i) : null;
  }

  Widget _trailing(FormFieldState<dynamic> field, int i) {
    return !widget.leadingInput ? _radio(field, i) : null;
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
        final radioList = <Widget>[];
        for (var i = 0; i < widget.options.length; i++) {
          radioList.addAll([
            ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: widget.contentPadding,
              leading: _leading(field, i),
              title: widget.options[i],
              trailing: _trailing(field, i),
              onTap: _readOnly
                  ? null
                  : () {
                      final value = widget.options[i].value;
                      field.didChange(value);
                      widget.onChanged?.call(value);
                    },
            ),
            const Divider(
              height: 0.0,
            ),
          ]);
        }
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
            errorText: field.errorText,
          ),
          child: Column(
            children: radioList,
          ),
        );
      },
    );
  }
}
