import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdown extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final Widget hint;
  final List<DropdownMenuItem> items;
  final bool isExpanded;
  final TextStyle style;
  final bool isDense;
  final int elevation;
  final Widget disabledHint;
  final double iconSize;
  final Widget underline;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final bool allowClear;
  final Widget clearIcon;
  final FormFieldSetter onSaved;

  FormBuilderDropdown({
    @required this.attribute,
    @required this.items,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.isExpanded = true,
    this.isDense = true,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.hint,
    this.initialValue,
    this.style,
    this.disabledHint,
    this.onChanged,
    this.valueTransformer,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.allowClear = false,
    this.clearIcon = const Icon(Icons.close),
    this.onSaved,
  }) /*: assert(allowClear == true || clearIcon != null)*/;

  @override
  _FormBuilderDropdownState createState() => _FormBuilderDropdownState();
}

class _FormBuilderDropdownState extends State<FormBuilderDropdown> {
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
            errorText: field.errorText,
          ),
          child: DropdownButtonHideUnderline(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton(
                    isExpanded: widget.isExpanded,
                    hint: widget.hint,
                    items: widget.items,
                    value: field.value,
                    style: widget.style,
                    isDense: widget.isDense,
                    disabledHint: field.value != null
                        ? (widget.items
                                .firstWhere((val) => val.value == field.value,
                                    orElse: () => null)
                                ?.child ??
                            Text("${field.value.toString()}"))
                        : widget.disabledHint,
                    elevation: widget.elevation,
                    iconSize: widget.iconSize,
                    icon: widget.icon,
                    iconDisabledColor: widget.iconDisabledColor,
                    iconEnabledColor: widget.iconEnabledColor,
                    underline: widget.underline,
                    onChanged: _readOnly
                        ? null
                        : (value) {
                            _changeValue(field, value);
                          },
                  ),
                ),
                if (widget.allowClear &&
                    !widget.readOnly &&
                    field.value != null) ...[
                  VerticalDivider(),
                  InkWell(
                    child: widget.clearIcon,
                    onTap: () {
                      _changeValue(field, null);
                    },
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  _changeValue(FormFieldState field, value) {
    FocusScope.of(context).requestFocus(FocusNode());
    field.didChange(value);
    if (widget.onChanged != null) widget.onChanged(value);
  }

/*@override
  Widget build(BuildContext context) {
    _readOnly = (_formState?.readOnly == true) ? true : widget.readOnly;

    return DropdownButtonFormField(
      key: _fieldKey,
      decoration: widget.decoration.copyWith(
        enabled: _readOnly ? false : true,
      ),
      hint: widget.hint,
      items: widget.items,
      value: _initialValue,
      onChanged: _readOnly
          ? null
          : (value) {
        FocusScope.of(context).requestFocus(FocusNode());
        if (widget.onChanged != null) widget.onChanged(value);
      },
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        return null;
      },
      onSaved: (val) {
        if (widget.valueTransformer != null) {
          var transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, val);
      },
    );
  }*/
}
