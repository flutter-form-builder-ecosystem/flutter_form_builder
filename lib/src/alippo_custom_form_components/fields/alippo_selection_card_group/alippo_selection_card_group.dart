import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'comp/selection_card.dart';

/// A list of `Chip`s that acts like radio buttons
class AlippoSelectionCardGroups<T> extends FormBuilderFieldDecoration<T> {
  /// The list of items the user can select.
  final List<SelectionCardOption<T>> options;

  // FilterChip Settings
  /// Elevation to be applied on the chip relative to its parent.
  ///
  /// This controls the size of the shadow below the chip.
  ///
  /// Defaults to 0. The value is always non-negative.
  final double? elevation;

  /// Elevation to be applied on the chip relative to its parent during the
  /// press motion.
  ///
  /// This controls the size of the shadow below the chip.
  ///
  /// Defaults to 8. The value is always non-negative.
  final double? pressElevation;

  /// Color to be used for the chip's background, indicating that it is
  /// selected.
  final Color? selectedCardColor;

  /// Color to be used for the chip's background indicating that it is disabled.
  ///
  /// The chip is disabled when [isEnabled] is false, or all three of
  /// [SelectableChipAttributes.onSelected], [TappableChipAttributes.onPressed],
  /// and [DeletableChipAttributes.onDelete] are null.
  ///
  /// It defaults to [Colors.black38].
  final Color? disabledColor;

  final Color? defaultCardColor;

  /// Color of the chip's shadow when the elevation is greater than 0 and the
  /// chip is selected.
  ///
  /// The default is [Colors.black].
  final Color? selectedShadowColor;

  /// Color of the chip's shadow when the elevation is greater than 0.
  ///
  /// The default is [Colors.black].
  final Color? shadowColor;

  /// The [OutlinedBorder] to draw around the chip.
  ///
  /// Defaults to the shape in the ambient [ChipThemeData]. If the theme
  /// shape resolves to null, the default is [StadiumBorder].
  ///
  /// This shape is combined with [side] to create a shape decorated with an
  /// outline. If it is a [MaterialStateOutlinedBorder],
  /// [MaterialStateProperty.resolve] is used for the following
  /// [MaterialState]s:
  ///
  ///  * [MaterialState.disabled].
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.pressed].
  final OutlinedBorder? selectedShape;

  final OutlinedBorder? unselectedShape;

  /// The padding around the [label] widget.
  ///
  /// By default, this is 4 logical pixels at the beginning and the end of the
  /// label, and zero on top and bottom.
  final EdgeInsets? labelPadding;

  /// The style to be applied to the chip's label.
  ///
  /// If null, the value of the [ChipTheme]'s [ChipThemeData.labelStyle] is used.
  //
  /// This only has an effect on widgets that respect the [DefaultTextStyle],
  /// such as [Text].
  ///
  /// If [labelStyle.color] is a [MaterialStateProperty<Color>], [MaterialStateProperty.resolve]
  /// is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.disabled].
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.pressed].
  final TextStyle? selectedLabelStyle;

  final TextStyle? unselectedLabelStyle;

  /// The padding between the contents of the chip and the outside [selectedShape].
  ///
  /// Defaults to 4 logical pixels on all sides.
  final EdgeInsets? padding;

  // Wrap Settings
  /// The direction to use as the main axis when wrapping chips.
  ///
  /// For example, if [direction] is [Axis.horizontal], the default, the
  /// children are placed adjacent to one another in a horizontal run until the
  /// available horizontal space is consumed, at which point a subsequent
  /// children are placed in a new run vertically adjacent to the previous run.
  final Axis direction;

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [alignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment alignment;

  /// How much space to place between children in a run in the main axis.
  ///
  /// For example, if [spacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// If there is additional free space in a run (e.g., because the wrap has a
  /// minimum size that is not filled or because some runs are longer than
  /// others), the additional free space will be allocated according to the
  /// [alignment].
  ///
  /// Defaults to 0.0.
  final double spacing;

  final ShapeBorder avatarBorder;

  final bool expanded;

  final Duration? animationDuration;

  final Duration? reverseAnimationDuration;

  final Curve? animationCurve;

  final Curve? reverseAnimationCurve;

  /// Creates a list of `Chip`s that acts like radio buttons
  AlippoSelectionCardGroups({
    super.autovalidateMode = AutovalidateMode.disabled,
    super.enabled,
    super.focusNode,
    super.onSaved,
    super.validator,
    super.decoration,
    super.key,
    required super.name,
    required this.options,
    super.initialValue,
    super.restorationId,
    super.onChanged,
    super.valueTransformer,
    super.onReset,
    this.alignment = WrapAlignment.start,
    this.avatarBorder = const CircleBorder(),
    this.defaultCardColor,
    this.direction = Axis.horizontal,
    this.disabledColor,
    this.elevation,
    this.labelPadding,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.padding,
    this.pressElevation,
    this.selectedCardColor,
    this.selectedShadowColor,
    this.shadowColor,
    this.selectedShape,
    this.unselectedShape,
    this.spacing = 0.0,
    this.expanded = false,
    this.animationDuration,
    this.reverseAnimationDuration,
    this.animationCurve,
    this.reverseAnimationCurve,
  }) : super(
          builder: (FormFieldState<T?> field) {
            final state = field as _AlippoSelectionCardGroupsState<T>;

            return InputDecorator(
              decoration: state.decoration,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (SelectionCardOption<T> option in options)
                      Column(
                        children: [
                          SelectionCard(
                            label: option,
                            selected: field.value == option.value,
                            onSelected: state.enabled
                                ? (selected) {
                                    final choice =
                                        selected ? option.value : null;
                                    state.didChange(choice);
                                  }
                                : null,
                            avatar: option.avatar,
                            selectedIconColor: defaultCardColor,
                            unselectedIconColor: selectedCardColor,
                            selectedCardColor: selectedCardColor,
                            defaultCardColor: defaultCardColor,
                            disabledColor: disabledColor,
                            shadowColor: shadowColor,
                            selectedShadowColor: selectedShadowColor,
                            elevation: elevation,
                            pressElevation: pressElevation,
                            selectedLabelStyle: selectedLabelStyle,
                            unselectedLabelStyle: unselectedLabelStyle,
                            labelPadding: labelPadding,
                            padding: padding,
                            selectedShape: selectedShape,
                            unselectedShape: unselectedShape,
                            expanded: expanded,
                            infoModalConfig: option.infoModalConfig,
                          ),
                          if (options.last != option) SizedBox(height: spacing),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );

  @override
  FormBuilderFieldDecorationState<AlippoSelectionCardGroups<T>, T>
      createState() => _AlippoSelectionCardGroupsState<T>();
}

class _AlippoSelectionCardGroupsState<T>
    extends FormBuilderFieldDecorationState<AlippoSelectionCardGroups<T>, T> {}
