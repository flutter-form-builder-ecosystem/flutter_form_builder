import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/grouped_checkbox.dart';

class FormBuilderCheckboxGroup<T> extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final List<T> initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final bool enabled;
  final FormFieldSetter onSaved;
  final AutovalidateMode autovalidateMode;
  final List<FormBuilderFieldOption> options;
  final Color activeColor;
  final Color checkColor;
  final Color focusColor;
  final Color hoverColor;
  final List<T> disabled;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;
  final Axis wrapDirection;

  final WrapAlignment wrapAlignment;

  final double wrapSpacing;

  final WrapAlignment wrapRunAlignment;

  final double wrapRunSpacing;

  final WrapCrossAlignment wrapCrossAxisAlignment;

  final TextDirection wrapTextDirection;
  final VerticalDirection wrapVerticalDirection;
  final Widget separator;
  final ControlAffinity controlAffinity;

  final GroupedCheckboxOrientation orientation;

  FormBuilderCheckboxGroup({
    Key key,
    @required this.attribute,
    this.initialValue,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.enabled = true,
    this.onSaved,
    this.autovalidateMode,
    @required this.options,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.disabled,
    this.materialTapTargetSize,
    this.tristate = false,
    this.wrapDirection = Axis.horizontal,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapSpacing = 0.0,
    this.wrapRunAlignment = WrapAlignment.start,
    this.wrapRunSpacing = 0.0,
    this.wrapCrossAxisAlignment = WrapCrossAlignment.start,
    this.wrapTextDirection,
    this.wrapVerticalDirection = VerticalDirection.down,
    this.separator,
    this.controlAffinity = ControlAffinity.leading,
    this.orientation = GroupedCheckboxOrientation.wrap,
    this.validators = const [],
  }) : super(
          key: key,
        );

  @override
  _FormBuilderCheckboxGroupState<T> createState() =>
      _FormBuilderCheckboxGroupState();
}

class _FormBuilderCheckboxGroupState<T>
    extends State<FormBuilderCheckboxGroup> {
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
      builder: (FormFieldState field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
            errorText: field.errorText,
          ),
          child: GroupedCheckbox(
            orientation: widget.orientation,
            value: field.value,
            options: widget.options,
            onChanged: (val) {
              field.didChange(val);
              widget.onChanged?.call(val);
            },
            activeColor: widget.activeColor,
            focusColor: widget.focusColor,
            checkColor: widget.checkColor,
            materialTapTargetSize: widget.materialTapTargetSize,
            disabled: _readOnly
                ? widget.options.map((e) => e.value).toList()
                : widget.disabled,
            hoverColor: widget.hoverColor,
            tristate: widget.tristate,
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
