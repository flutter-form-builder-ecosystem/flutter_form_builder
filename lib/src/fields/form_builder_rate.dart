import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rating_bar/rating_bar.dart';

class FormBuilderRate extends FormBuilderField<num> {
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
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    num initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<num> onChanged,
    FormFieldSetter<num> onSaved,
    ValueTransformer<num> valueTransformer,
    List<FormFieldValidator<num>> validators = const [],
    this.max = 5.0,
    this.icon = Icons.star,
    this.iconSize = 24.0,
    this.filledColor,
    this.emptyIcon = Icons.star,
    this.emptyColor,
    this.isHalfAllowed = false,
    this.halfFilledIcon = Icons.star_half,
    this.halfFilledColor,
  }) : super(
          key: key,
          attribute: attribute,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: initialValue,
          decoration: decoration,
          onChanged: onChanged,
          onSaved: onSaved,
          valueTransformer: valueTransformer,
          validators: validators,
        );

  @override
  _FormBuilderRateState createState() => _FormBuilderRateState();
}

class _FormBuilderRateState
    extends FormBuilderFieldState<FormBuilderRate, num, num> {
  @override
  Widget build(BuildContext context) {
    return FormField<num>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue,
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<num> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: _buildRatingBar(field),
        );
      },
    );
  }

  Widget _buildRatingBar(FormFieldState<num> field) {
    if (readOnly) {
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
