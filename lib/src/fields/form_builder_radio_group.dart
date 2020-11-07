import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/grouped_checkbox.dart';
import 'package:flutter_form_builder/src/widgets/grouped_radio.dart';

class FormBuilderRadioGroup extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final List<FormBuilderFieldOption> options;
  final MaterialTapTargetSize materialTapTargetSize;
  final Color activeColor;
  final FormFieldSetter onSaved;
  final Color focusColor;
  final Color hoverColor;
  final List disabled;
  final Axis wrapDirection;
  final WrapAlignment wrapAlignment;

  final double wrapSpacing;

  final WrapAlignment wrapRunAlignment;

  final double wrapRunSpacing;

  final WrapCrossAlignment wrapCrossAxisAlignment;

  final VerticalDirection wrapVerticalDirection;
  final TextDirection wrapTextDirection;
  final Widget separator;
  final ControlAffinity controlAffinity; // = ControlAffinity.leading;
  final GroupedRadioOrientation orientation; // = GroupedRadioOrientation.wrap;

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
    this.onSaved,
    this.materialTapTargetSize,
    this.wrapDirection = Axis.horizontal,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapSpacing = 0.0,
    this.wrapRunAlignment = WrapAlignment.start,
    this.wrapRunSpacing = 0.0,
    this.wrapCrossAxisAlignment = WrapCrossAlignment.start,
    this.wrapVerticalDirection = VerticalDirection.down,
    this.controlAffinity = ControlAffinity.leading,
    this.orientation = GroupedRadioOrientation.wrap,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.disabled,
    this.wrapTextDirection,
    this.separator,
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
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
            errorText: field.errorText,
          ),
          child: GroupedRadio(
            orientation: widget.orientation,
            value: field.value,
            options: widget.options,
            onChanged: (val) {
              field.didChange(val);
              widget.onChanged?.call(val);
            },
            activeColor: widget.activeColor,
            focusColor: widget.focusColor,
            materialTapTargetSize: widget.materialTapTargetSize,
            disabled: !_readOnly
                ? widget.disabled
                : widget.options.map((e) => e.value).toList(),
            hoverColor: widget.hoverColor,
            wrapAlignment: widget.wrapAlignment,
            wrapCrossAxisAlignment: widget.wrapCrossAxisAlignment,
            wrapDirection: widget.wrapDirection,
            wrapRunAlignment: widget.wrapRunAlignment,
            wrapRunSpacing: widget.wrapRunSpacing,
            wrapSpacing: widget.wrapSpacing,
            wrapTextDirection: widget.wrapTextDirection,
            wrapVerticalDirection: widget.wrapVerticalDirection,
            separator: widget.separator,
            controlAffinity: widget.controlAffinity,
          ),
        );
      },
    );
  }
}
