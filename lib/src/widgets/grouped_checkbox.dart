import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GroupedCheckbox<T> extends StatelessWidget {
  /// A list of string that describes each checkbox. Each item must be distinct.
  final List<FormBuilderFieldOption<T>> options;

  /// A list of string which specifies automatically checked checkboxes.
  /// Every element must match an item from itemList.
  final List<T>? value;

  /// Specifies which checkbox option values should be disabled.
  /// If this is null, then no checkbox options will be disabled.
  final List<T>? disabled;

  /// Specifies the orientation of the elements in itemList.
  final OptionsOrientation orientation;

  /// Called when the value of the checkbox group changes.
  final ValueChanged<List<T>> onChanged;

  /// The color to use when this checkbox is checked.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color? activeColor;

  /// The color to use for the check icon when this checkbox is checked.
  ///
  /// Defaults to Color(0xFFFFFFFF)
  final Color? checkColor;

  /// If true the checkbox's value can be true, false, or null.
  final bool tristate;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// The color for the checkbox's Material when it has the input focus.
  final Color? focusColor;

  /// The color for the checkbox's Material when a pointer is hovering over it.
  final Color? hoverColor;

  //.......................WRAP ORIENTATION.....................................

  /// The direction to use as the main axis.
  ///
  /// For example, if [wrapDirection] is [Axis.horizontal], the default, the
  /// children are placed adjacent to one another in a horizontal run until the
  /// available horizontal space is consumed, at which point a subsequent
  /// children are placed in a new run vertically adjacent to the previous run.
  final Axis wrapDirection;

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [wrapAlignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [wrapRunAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  ///  * [wrapCrossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment wrapAlignment;

  /// How much space to place between children in a run in the main axis.
  ///
  /// For example, if [wrapSpacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// If there is additional free space in a run (e.g., because the wrap has a
  /// minimum size that is not filled or because some runs are longer than
  /// others), the additional free space will be allocated according to the
  /// [wrapAlignment].
  ///
  /// Defaults to 0.0.
  final double wrapSpacing;

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// For example, if [wrapRunAlignment] is [WrapAlignment.center], the runs are
  /// grouped together in the center of the overall [Wrap] in the cross axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [wrapAlignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [wrapCrossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment wrapRunAlignment;

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// For example, if [wrapRunSpacing] is 10.0, the runs will be spaced at least
  /// 10.0 logical pixels apart in the cross axis.
  ///
  /// If there is additional free space in the overall [Wrap] (e.g., because
  /// the wrap has a minimum size that is not filled), the additional free space
  /// will be allocated according to the [wrapRunAlignment].
  ///
  /// Defaults to 0.0.
  final double wrapRunSpacing;

  /// How the children within a run should be aligned relative to each other in
  /// the cross axis.
  ///
  /// For example, if this is set to [WrapCrossAlignment.end], and the
  /// [wrapDirection] is [Axis.horizontal], then the children within each
  /// run will have their bottom edges aligned to the bottom edge of the run.
  ///
  /// Defaults to [WrapCrossAlignment.start].
  ///
  /// See also:
  ///
  ///  * [wrapAlignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [wrapRunAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  final WrapCrossAlignment wrapCrossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If the [wrapDirection] is [Axis.horizontal], this controls order in which the
  /// children are positioned (left-to-right or right-to-left), and the meaning
  /// of the [wrapAlignment] property's [WrapAlignment.start] and
  /// [WrapAlignment.end] values.
  ///
  /// If the [wrapDirection] is [Axis.horizontal], and either the
  /// [wrapAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], or
  /// there's more than one child, then the [wrapTextDirection] (or the ambient
  /// [Directionality]) must not be null.
  ///
  /// If the [wrapDirection] is [Axis.vertical], this controls the order in which
  /// runs are positioned, the meaning of the [wrapRunAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [wrapCrossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [wrapDirection] is [Axis.vertical], and either the
  /// [wrapRunAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [wrapCrossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [wrapTextDirection] (or the ambient [Directionality]) must not be null.
  final TextDirection? wrapTextDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// If the [wrapDirection] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [wrapAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values.
  ///
  /// If the [wrapDirection] is [Axis.vertical], and either the [wrapAlignment]
  /// is either [WrapAlignment.start] or [WrapAlignment.end], or there's
  /// more than one child, then the [wrapVerticalDirection] must not be null.
  ///
  /// If the [wrapDirection] is [Axis.horizontal], this controls the order in which
  /// runs are positioned, the meaning of the [wrapRunAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [wrapCrossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [wrapDirection] is [Axis.horizontal], and either the
  /// [wrapRunAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [wrapCrossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [wrapVerticalDirection] must not be null.
  final VerticalDirection wrapVerticalDirection;

  final Widget? separator;

  final ControlAffinity controlAffinity;

  const GroupedCheckbox({
    Key? key,
    required this.options,
    required this.orientation,
    required this.onChanged,
    this.value,
    this.disabled,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetList = <Widget>[];
    for (var i = 0; i < options.length; i++) {
      widgetList.add(item(i));
    }
    Widget finalWidget;
    if (orientation == OptionsOrientation.vertical) {
      finalWidget = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgetList,
        ),
      );
    } else if (orientation == OptionsOrientation.horizontal) {
      finalWidget = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widgetList.map((item) {
            return Column(children: <Widget>[item]);
          }).toList(),
        ),
      );
    } else {
      finalWidget = SingleChildScrollView(
        child: Wrap(
          spacing: wrapSpacing,
          runSpacing: wrapRunSpacing,
          textDirection: wrapTextDirection,
          crossAxisAlignment: wrapCrossAxisAlignment,
          verticalDirection: wrapVerticalDirection,
          alignment: wrapAlignment,
          direction: Axis.horizontal,
          runAlignment: wrapRunAlignment,
          children: widgetList,
        ),
      );
    }
    return finalWidget;
  }

  Widget item(int index) {
    final option = options[index];
    final optionValue = option.value;
    final isOptionDisabled = true == disabled?.contains(optionValue);
    final control = Checkbox(
      activeColor: activeColor,
      checkColor: checkColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      materialTapTargetSize: materialTapTargetSize,
      value: tristate
          ? value?.contains(optionValue)
          : true == value?.contains(optionValue),
      tristate: tristate,
      onChanged: isOptionDisabled
          ? null
          : (selected) {
              List<T> selectedListItems = value == null ? [] : List.of(value!);
              selected!
                  ? selectedListItems.add(optionValue)
                  : selectedListItems.remove(optionValue);
              onChanged(selectedListItems);
            },
    );
    final label = GestureDetector(
      onTap: isOptionDisabled
          ? null
          : () {
              List<T> selectedListItems = value == null ? [] : List.of(value!);
              selectedListItems.contains(optionValue)
                  ? selectedListItems.remove(optionValue)
                  : selectedListItems.add(optionValue);
              onChanged(selectedListItems);
            },
      child: option,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (controlAffinity == ControlAffinity.leading) control,
        Flexible(flex: 1, child: label),
        if (controlAffinity == ControlAffinity.trailing) control,
        if (separator != null && index != options.length - 1) separator!,
      ],
    );
  }
}
