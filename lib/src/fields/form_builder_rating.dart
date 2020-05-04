import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rating_bar/rating_bar.dart';

class FormBuilderRating extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final double initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;
  final ValueTransformer valueTransformer;

  final IconData icon;
  final double iconSize;
  final double max;
  final Color filledColor;
  final IconData emptyIcon;
  final Color emptyColor;
  final bool isHalfAllowed;
  final IconData halfFilledIcon;
  final Color halfFilledColor;

  FormBuilderRating({
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
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validators: validators,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderRateState state = field;
            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: field.errorText,
              ),
              child: state._buildRatingBar(),
            );
          },
        );

  @override
  _FormBuilderRateState createState() => _FormBuilderRateState();
}

class _FormBuilderRateState extends FormBuilderFieldState {
  FormBuilderRating get widget => super.widget;

  Widget _buildRatingBar() {
    if (readOnly) {
      return RatingBar.readOnly(
        initialRating: value,
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
      initialRating: value,
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
        didChange(value);
      },
    );
  }
}
