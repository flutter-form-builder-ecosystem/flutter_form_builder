import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rating_bar/rating_bar.dart';

class FormBuilderRate extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final num initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;
  final ValueTransformer valueTransformer;

  final IconData icon;
  final num iconSize;
  final num max;
  final Color filledColor;
  final IconData emptyIcon;
  final Color emptyColor;
  final bool isHalfAllowed;
  final IconData halfFilledIcon;
  final Color halfFilledColor;

  FormBuilderRate({
    Key key,
    @required this.attribute,
    this.initialValue = 1.0,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.max = 5.0,
    this.icon = Icons.star,
    this.iconSize = 24.0,
    this.onChanged,
    this.valueTransformer,
    this.onSaved,
    this.filledColor,
    this.emptyIcon = Icons.star,
    this.emptyColor,
    this.isHalfAllowed = false,
    this.halfFilledIcon = Icons.star_half,
    this.halfFilledColor,
  }) : super(key: key);

  @override
  _FormBuilderRateState createState() => _FormBuilderRateState();
}

class _FormBuilderRateState extends State<FormBuilderRate> {
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
          child: _buildRatingBar(field),
        );
      },
    );
  }

  Widget _buildRatingBar(FormFieldState<dynamic> field) {
    if (_readOnly) {
      return RatingBar.readOnly(
        initialRating: field.value.toDouble(),
        maxRating: widget.max.toInt(),
        filledIcon: widget.icon,
        filledColor: widget.filledColor,
        emptyIcon: widget.emptyIcon,
        emptyColor: widget.emptyColor,
        isHalfAllowed: widget.isHalfAllowed,
        halfFilledIcon: widget.halfFilledIcon,
        halfFilledColor: widget.halfFilledColor,
        size: widget.iconSize,
      );
    }
    return RatingBar(
      key: ObjectKey(field.value),
      initialRating: field.value.toDouble(),
      maxRating: widget.max.toInt(),
      filledIcon: widget.icon,
      filledColor: widget.filledColor,
      emptyIcon: widget.emptyIcon,
      emptyColor: widget.emptyColor,
      isHalfAllowed: widget.isHalfAllowed,
      halfFilledIcon: widget.halfFilledIcon,
      halfFilledColor: widget.halfFilledColor,
      size: widget.iconSize,
      onRatingChanged: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
        field.didChange(value);
        widget.onChanged?.call(value);
        return value;
      },
    );
  }
}
