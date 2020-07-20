import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rating_bar/rating_bar.dart';

class FormBuilderRating extends FormBuilderField {
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
    //From Super
    @required String attribute,
    FormFieldValidator validator,
    double initialValue = 1.0,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    bool autovalidate = false,
    VoidCallback onReset,
    FocusNode focusNode,
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
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidate: autovalidate,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          builder: (FormFieldState field) {
            final _FormBuilderRateState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: _buildRatingBar(state),
            );
          },
        );

  static Widget _buildRatingBar(_FormBuilderRateState field) {
    if (field.readOnly) {
      return RatingBar.readOnly(
        initialRating: field.value,
        maxRating: field.widget.max.toInt(),
        filledIcon: field.widget.icon,
        filledColor: field.widget.filledColor,
        emptyIcon: field.widget.emptyIcon,
        emptyColor: field.widget.emptyColor,
        isHalfAllowed: field.widget.isHalfAllowed,
        halfFilledIcon: field.widget.halfFilledIcon,
        halfFilledColor: field.widget.halfFilledColor,
        size: field.widget.iconSize,
      );
    }

    return RatingBar(
      key: ObjectKey(field.value),
      initialRating: field.value,
      maxRating: field.widget.max.toInt(),
      filledIcon: field.widget.icon,
      filledColor: field.widget.filledColor,
      emptyIcon: field.widget.emptyIcon,
      emptyColor: field.widget.emptyColor,
      isHalfAllowed: field.widget.isHalfAllowed,
      halfFilledIcon: field.widget.halfFilledIcon,
      halfFilledColor: field.widget.halfFilledColor,
      size: field.widget.iconSize,
      onRatingChanged: (val) {
        field.didChange(val);
      },
    );
  }

  @override
  _FormBuilderRateState createState() => _FormBuilderRateState();
}

class _FormBuilderRateState extends FormBuilderFieldState {
  @override
  FormBuilderRating get widget => super.widget;
}
