import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rating_bar/rating_bar.dart';

class FormBuilderRating extends FormBuilderField<double> {
  /// Icon to be used to denote the value of the widget
  final IconData icon;

  /// Size of the icon to be used to denote the value of the widget
  final double iconSize;

  /// The maximum values the user can put in
  final double max;

  /// Fill color of the icon to be used to denote empty values
  final Color filledColor;

  /// Icon to be used to denote the value of the widget
  final IconData emptyIcon;

  /// Fill color of the icon to be used when the icon is empty
  final Color emptyColor;

  /// Whether half values are allowed. If false only whole numbers are allowed
  final bool isHalfAllowed;

  /// Icon to be used to denote half values
  final IconData halfFilledIcon;

  /// Fill color of the icon to be used when the value is half
  final Color halfFilledColor;

  FormBuilderRating({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    double initialValue = 1.0,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<double> onChanged,
    ValueTransformer<double> valueTransformer,
    bool enabled = true,
    FormFieldSetter<double> onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
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
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          builder: (FormFieldState<double> field) {
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
        initialRating: field.value?.toDouble(),
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
      initialRating: field.value?.toDouble(),
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
        field.requestFocus();
        field.didChange(val);
      },
    );
  }

  @override
  _FormBuilderRateState createState() => _FormBuilderRateState();
}

class _FormBuilderRateState extends FormBuilderFieldState<double> {
  @override
  FormBuilderRating get widget => super.widget as FormBuilderRating;
}
