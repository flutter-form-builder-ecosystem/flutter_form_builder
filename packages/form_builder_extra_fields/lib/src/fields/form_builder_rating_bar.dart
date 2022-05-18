import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

/// Field for selection of a numerical value using a star* rating widget
class FormBuilderRatingBar extends FormBuilderField<double> {
  final bool shouldRequestFocus;

  /// Defines color for glow.
  ///
  /// Default is [ThemeData.colorScheme.secondary].
  final Color? glowColor;

  /// Sets maximum rating
  ///
  /// Default is [itemCount].
  final double? maxRating;

  /// {@template flutterRatingBar.textDirection}
  /// The text flows from right to left if [textDirection] = TextDirection.rtl
  /// {@endtemplate}
  final TextDirection? textDirection;

  /// {@template flutterRatingBar.unratedColor}
  /// Defines color for the unrated portion.
  ///
  /// Default is [ThemeData.disabledColor].
  /// {@endtemplate}
  final Color? unratedColor;

  /// Default [allowHalfRating] = false. Setting true enables half rating support.
  final bool allowHalfRating;

  /// {@template flutterRatingBar.direction}
  /// Direction of rating bar.
  ///
  /// Default = Axis.horizontal
  /// {@endtemplate}
  final Axis direction;

  /// if set to true, Rating Bar item will glow when being touched.
  ///
  /// Default is true.
  final bool glow;

  /// Defines the radius of glow.
  ///
  /// Default is 2.
  final double glowRadius;

  /// Defines the initial rating to be set to the rating bar.
  final double initialRating;

  /// {@template flutterRatingBar.itemCount}
  /// Defines total number of rating bar items.
  ///
  /// Default is 5.
  /// {@endtemplate}
  final int itemCount;

  /// {@template flutterRatingBar.itemPadding}
  /// The amount of space by which to inset each rating item.
  /// {@endtemplate}
  final EdgeInsetsGeometry itemPadding;

  /// {@template flutterRatingBar.itemSize}
  /// Defines width and height of each rating item in the bar.
  ///
  /// Default is 40.0
  /// {@endtemplate}
  final double itemSize;

  /// Sets minimum rating
  ///
  /// Default is 0.
  final double minRating;

  /// if set to true will disable drag to rate feature. Note: Enabling this mode will disable half rating capability.
  ///
  /// Default is false.
  final bool tapOnlyMode;

  /// Defines whether or not the `onRatingUpdate` updates while dragging.
  ///
  /// Default is false.
  final bool updateOnDrag;

  /// How the item within the [RatingBar] should be placed in the main axis.
  ///
  /// For example, if [wrapAlignment] is [WrapAlignment.center], the item in
  /// the RatingBar are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  final WrapAlignment wrapAlignment;

  /// Defines widgets which are to used as rating bar items.
  final RatingWidget? ratingWidget;

  FormBuilderRatingBar({
    Key? key,
    //From Super
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    double? initialValue,
    FocusNode? focusNode,
    FormFieldSetter<double>? onSaved,
    FormFieldValidator<double>? validator,
    InputDecoration decoration = const InputDecoration(),
    required String name,
    ValueChanged<double?>? onChanged,
    ValueTransformer<double?>? valueTransformer,
    VoidCallback? onReset,
    this.allowHalfRating = false,
    this.direction = Axis.horizontal,
    this.glow = true,
    this.glowColor,
    this.glowRadius = 2,
    this.initialRating = 0.0,
    this.itemCount = 5,
    this.itemPadding = EdgeInsets.zero,
    this.itemSize = 40.0,
    this.maxRating,
    this.minRating = 0,
    this.ratingWidget,
    this.shouldRequestFocus = false,
    this.tapOnlyMode = false,
    this.textDirection,
    this.unratedColor,
    this.updateOnDrag = false,
    this.wrapAlignment = WrapAlignment.start,
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
          builder: (FormFieldState<double?> field) {
            final state = field as FormBuilderRatingBarState;
            final widget = state.widget;

            return InputDecorator(
              decoration: state.decoration,
              child: RatingBar(
                initialRating: field.value ?? widget.minRating,
                minRating: widget.minRating,
                direction: widget.direction,
                allowHalfRating: widget.allowHalfRating,
                itemCount: widget.itemCount,
                itemPadding: widget.itemPadding,
                // itemBuilder: widget.itemBuilder
                onRatingUpdate: (rating) {
                  if (shouldRequestFocus) {
                    state.requestFocus();
                  }

                  field.didChange(rating);
                },
                ratingWidget: widget.ratingWidget ??
                    RatingWidget(
                      full: const Icon(Icons.star),
                      half: const Icon(Icons.star_half_outlined),
                      empty: const Icon(Icons.star_outline),
                    ),
                glow: widget.glow,
                glowColor: widget.glowColor,
                glowRadius: widget.glowRadius,
                ignoreGestures: !state.enabled,
                itemSize: widget.itemSize,
                maxRating: widget.maxRating,
                tapOnlyMode: widget.tapOnlyMode,
                textDirection: widget.textDirection,
                unratedColor: widget.unratedColor,
                updateOnDrag: widget.updateOnDrag,
                wrapAlignment: widget.wrapAlignment,
              ),
            );
          },
        );

  @override
  FormBuilderRatingBarState createState() => FormBuilderRatingBarState();
}

class FormBuilderRatingBarState
    extends FormBuilderFieldState<FormBuilderRatingBar, double> {}
