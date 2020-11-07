import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChoiceChip extends StatefulWidget {
  // FormBuilder Settings
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;
  final ValueTransformer valueTransformer;
  final List<FormBuilderFieldOption> options;

  // FilterChip Settings
  final double elevation, pressElevation;
  final Color selectedColor,
      disabledColor,
      backgroundColor,
      selectedShadowColor,
      shadowColor;
  final ShapeBorder shape;
  final MaterialTapTargetSize materialTapTargetSize;

  // Wrap Settings
  final Axis direction;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;
  final WrapAlignment runAlignment;
  final double runSpacing, spacing;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final EdgeInsets labelPadding;
  final EdgeInsets padding;
  final TextStyle labelStyle;

  FormBuilderChoiceChip({
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
    this.selectedColor,
    this.disabledColor,
    this.backgroundColor,
    this.shadowColor,
    this.selectedShadowColor,
    this.shape,
    this.elevation,
    this.pressElevation,
    this.materialTapTargetSize,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.spacing = 0.0,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.labelPadding,
    this.labelStyle,
    this.padding,
  }) : super(key: key);

  @override
  _FormBuilderChoiceChipState createState() => _FormBuilderChoiceChipState();
}

class _FormBuilderChoiceChipState extends State<FormBuilderChoiceChip> {
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
          child: Wrap(
              direction: widget.direction,
              alignment: widget.alignment,
              crossAxisAlignment: widget.crossAxisAlignment,
              runAlignment: widget.runAlignment,
              runSpacing: widget.runSpacing,
              spacing: widget.spacing,
              textDirection: widget.textDirection,
              verticalDirection: widget.verticalDirection,
              children: <Widget>[
                for (FormBuilderFieldOption option in widget.options)
                  ChoiceChip(
                    selectedColor: widget.selectedColor,
                    disabledColor: widget.disabledColor,
                    backgroundColor: widget.backgroundColor,
                    shadowColor: widget.shadowColor,
                    selectedShadowColor: widget.selectedShadowColor,
                    shape: widget.shape,
                    elevation: widget.elevation,
                    pressElevation: widget.pressElevation,
                    materialTapTargetSize: widget.materialTapTargetSize,
                    label: option,
                    selected: field.value == option.value,
                    onSelected: _readOnly
                        ? null
                        : (bool selected) {
                            setState(() {
                              FocusScope.of(context).requestFocus(FocusNode());
                              var choice = selected ? option.value : null;
                              field.didChange(choice);
                              widget.onChanged?.call(choice);
                            });
                          },
                    labelPadding: widget.labelPadding,
                    labelStyle: widget.labelStyle,
                    padding: widget.padding,
                  ),
              ]),
        );
      },
    );
  }
}
