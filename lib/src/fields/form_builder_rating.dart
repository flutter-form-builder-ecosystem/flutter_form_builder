import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rating_bar/rating_bar.dart';

/// Field for selection of a numerical value as a rating
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

  /// Creates field for selection of a numerical value as a rating
  FormBuilderRating({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator<double> validator,
    double initialValue = 1.0,
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
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<double> field) {
            final state = field as _FormBuilderRateState;
            final widget = state.widget;

            return InputDecorator(
              decoration: state.decoration(),
              child: state.enabled
                  ? RatingBar(
                      key: ObjectKey(state.value),
                      initialRating: state.value?.toDouble(),
                      maxRating: widget.max.toInt(),
                      filledIcon: widget.icon,
                      filledColor: widget.filledColor,
                      emptyIcon: widget.emptyIcon,
                      emptyColor: widget.emptyColor,
                      isHalfAllowed: widget.isHalfAllowed,
                      halfFilledIcon: widget.halfFilledIcon,
                      halfFilledColor: widget.halfFilledColor,
                      size: widget.iconSize,
                      onRatingChanged: (val) {
                        state.requestFocus();
                        state.didChange(val);
                      },
                    )
                  : RatingBar.readOnly(
                      initialRating: state.value?.toDouble(),
                      maxRating: widget.max.toInt(),
                      filledIcon: widget.icon,
                      filledColor: widget.filledColor,
                      emptyIcon: widget.emptyIcon,
                      emptyColor: widget.emptyColor,
                      isHalfAllowed: widget.isHalfAllowed,
                      halfFilledIcon: widget.halfFilledIcon,
                      halfFilledColor: widget.halfFilledColor,
                      size: widget.iconSize,
                    ),
            );
          },
        );

  @override
  _FormBuilderRateState createState() => _FormBuilderRateState();
}

class _FormBuilderRateState
    extends FormBuilderFieldState<FormBuilderRating, double> {}
