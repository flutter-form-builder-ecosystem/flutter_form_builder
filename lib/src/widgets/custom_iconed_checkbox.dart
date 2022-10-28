import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_form_builder/src/painter/radial_reaction_painter.dart';

///API for [CustomIconedCheckbox] is same as the Material checkbox will one or two differences

/// A Material Design checkbox.
///
/// The checkbox itself does not maintain any state. Instead, when the state of
/// the checkbox changes, the widget calls the [onChanged] callback. Most
/// widgets that use a checkbox will listen for the [onChanged] callback and
/// rebuild the checkbox with a new [value] to update the visual appearance of
/// the checkbox.
///
/// The checkbox can optionally display three values - true, false, and null -
/// if [tristate] is true. When [value] is null a dash is displayed. By default
/// [tristate] is false and the checkbox's [value] must be true or false.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// {@tool dartpad}
/// This example shows how you can override the default theme of
/// of a [Checkbox] with a [MaterialStateProperty].
/// In this example, the checkbox's color will be `Colors.blue` when the [Checkbox]
/// is being pressed, hovered, or focused. Otherwise, the checkbox's color will
/// be `Colors.red`
class CustomIconedCheckbox extends StatefulWidget {
  const CustomIconedCheckbox({
    super.key,
    required this.value,
    this.tristate = false,
    required this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.borderRadius,
    this.activeIcon,
    this.inactiveIcon,
    this.tristateIcon,
  }) : assert(tristate || value != null);

  /// Whether this checkbox is checked.
  ///
  /// This property must not be null.
  final bool? value;

  /// Called when the value of the checkbox should change.
  ///
  /// The checkbox passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the checkbox with the new
  /// value.
  ///
  /// If this callback is null, the checkbox will be displayed as disabled
  /// and will not respond to input gestures.
  ///
  /// When the checkbox is tapped, if [tristate] is false (the default) then
  /// the [onChanged] callback will be applied to `!value`. If [tristate] is
  /// true this callback cycle from false to true to null.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// Checkbox(
  ///   value: _throwShotAway,
  ///   onChanged: (bool? newValue) {
  ///     setState(() {
  ///       _throwShotAway = newValue!;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool?>? onChanged;

  /// {@template flutter.material.checkbox.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  /// {@endtemplate}
  ///
  /// When [value] is null and [tristate] is true, [MaterialState.selected] is
  /// included as a state.
  ///
  /// If null, then the value of [CheckboxThemeData.mouseCursor] is used. If
  /// that is also null, then [MaterialStateMouseCursor.clickable] is used.
  ///
  /// See also:
  ///
  ///  * [MaterialStateMouseCursor], a [MouseCursor] that implements
  ///    `MaterialStateProperty` which is used in APIs that need to accept
  ///    either a [MouseCursor] or a [MaterialStateProperty<MouseCursor>].
  final MouseCursor? mouseCursor;

  /// The color to use when this checkbox is checked.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  ///
  /// If [fillColor] returns a non-null color in the [MaterialState.selected]
  /// state, it will be used instead of this color.
  final Color? activeColor;

  /// {@template flutter.material.checkbox.fillColor}
  /// The color that fills the checkbox, in all [MaterialState]s.
  ///
  /// Resolves in the following states:
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [fillColor] based on the current [MaterialState]
  /// of the [Checkbox], providing a different [Color] when it is
  /// [MaterialState.disabled].
  ///
  /// ```dart
  /// Checkbox(
  ///   value: true,
  ///   onChanged: (_){},
  ///   fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
  ///     if (states.contains(MaterialState.disabled)) {
  ///       return Colors.orange.withOpacity(.32);
  ///     }
  ///     return Colors.orange;
  ///   })
  /// )
  /// ```
  /// {@end-tool}
  /// {@endtemplate}
  ///
  /// If null, then the value of [activeColor] is used in the selected
  /// state. If that is also null, the value of [CheckboxThemeData.fillColor]
  /// is used. If that is also null, then [ThemeData.disabledColor] is used in
  /// the disabled state, [ThemeData.toggleableActiveColor] is used in the
  /// selected state, and [ThemeData.unselectedWidgetColor] is used in the
  /// default state.
  final MaterialStateProperty<Color?>? fillColor;

  /// {@template flutter.material.checkbox.checkColor}
  /// The color to use for the check icon when this checkbox is checked.
  /// {@endtemplate}
  ///
  /// If null, then the value of [CheckboxThemeData.checkColor] is used. If
  /// that is also null, then Color(0xFFFFFFFF) is used.
  final Color? checkColor;

  /// If true the checkbox's [value] can be true, false, or null.
  ///
  /// Checkbox displays a dash when its value is null.
  ///
  /// When a tri-state checkbox ([tristate] is true) is tapped, its [onChanged]
  /// callback will be applied to true if the current value is false, to null if
  /// value is true, and to false if value is null (i.e. it cycles through false
  /// => true => null => false when tapped).
  ///
  /// If tristate is false (the default), [value] must not be null.
  final bool tristate;

  /// {@template flutter.material.checkbox.materialTapTargetSize}
  /// Configures the minimum size of the tap target.
  /// {@endtemplate}
  ///
  /// If null, then the value of [CheckboxThemeData.materialTapTargetSize] is
  /// used. If that is also null, then the value of
  /// [ThemeData.materialTapTargetSize] is used.
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.

  final MaterialTapTargetSize? materialTapTargetSize;

  /// {@template flutter.material.checkbox.visualDensity}
  /// Defines how compact the checkbox's layout will be.
  /// {@endtemplate}
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// If null, then the value of [CheckboxThemeData.visualDensity] is used. If
  /// that is also null, then the value of [ThemeData.visualDensity] is used.
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all
  ///    widgets within a [Theme].
  final VisualDensity? visualDensity;

  /// The color for the checkbox's [Material] when it has the input focus.
  ///
  /// If [overlayColor] returns a non-null color in the [MaterialState.focused]
  /// state, it will be used instead.
  ///
  /// If null, then the value of [CheckboxThemeData.overlayColor] is used in the
  /// focused state. If that is also null, then the value of
  /// [ThemeData.focusColor] is used.
  final Color? focusColor;

  /// The color for the checkbox's [Material] when a pointer is hovering over it.
  ///
  /// If [overlayColor] returns a non-null color in the [MaterialState.hovered]
  /// state, it will be used instead.
  ///
  /// If null, then the value of [CheckboxThemeData.overlayColor] is used in the
  /// hovered state. If that is also null, then the value of
  /// [ThemeData.hoverColor] is used.
  final Color? hoverColor;

  /// {@template flutter.material.checkbox.overlayColor}
  /// The color for the checkbox's [Material].
  ///
  /// Resolves in the following states:
  ///  * [MaterialState.pressed].
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  /// {@endtemplate}
  ///
  /// If null, then the value of [activeColor] with alpha
  /// [kRadialReactionAlpha], [focusColor] and [hoverColor] is used in the
  /// pressed, focused and hovered state. If that is also null,
  /// the value of [CheckboxThemeData.overlayColor] is used. If that is
  /// also null, then the value of [ThemeData.toggleableActiveColor] with alpha
  /// [kRadialReactionAlpha], [ThemeData.focusColor] and [ThemeData.hoverColor]
  /// is used in the pressed, focused and hovered state.
  final MaterialStateProperty<Color?>? overlayColor;

  /// {@template flutter.material.checkbox.splashRadius}
  /// The splash radius of the circular [Material] ink response.
  /// {@endtemplate}
  ///
  /// If null, then the value of [CheckboxThemeData.splashRadius] is used. If
  /// that is also null, then [kRadialReactionRadius] is used.
  final double? splashRadius;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  ///Controls the borderRadius of the iconbox
  final BorderRadius? borderRadius;

  ///Default Flutter Icons are supported for now
  ///Icon when the checkbox is in activestate
  final IconData? activeIcon;

  ///Default Flutter Icons are supported for now
  ///Icon when the checkbox is in inactivestate
  final IconData? inactiveIcon;

  ///Default Flutter Icons are supported for now
  ///Icon when the checkbox is in triactivestate
  final IconData? tristateIcon;

  ///Will support in future
  // final OutlinedBorder? shape;
  ///Will support in future
  // final BorderSide? side;

  static const double width = 18.0;
  @override
  State<CustomIconedCheckbox> createState() => _CustomIconedCheckboxState();
}

class _CustomIconedCheckboxState extends State<CustomIconedCheckbox>
    with TickerProviderStateMixin {
  // bool? _previousValue;
  Set<MaterialState> get states => <MaterialState>{
        if (!isInteractive) MaterialState.disabled,
        if (_hovering) MaterialState.hovered,
        if (_focused) MaterialState.focused,
        if (value ?? true) MaterialState.selected,
      };
  late final Map<Type, Action<Intent>> _actionMap = <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _handleTap),
  };
  @override
  void initState() {
    super.initState();
    // _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(CustomIconedCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      // _previousValue = oldWidget.value;
      // animateToValue();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  ValueChanged<bool?>? get onChanged => widget.onChanged;
  bool get tristate => widget.tristate;
  bool? get value => widget.value;

  MaterialStateProperty<Color?> get _widgetFillColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return widget.activeColor;
      }
      return null;
    });
  }

  MaterialStateProperty<Color> get _defaultFillColor {
    final ThemeData themeData = Theme.of(context);
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return themeData.disabledColor;
      }
      if (states.contains(MaterialState.selected)) {
        return themeData.toggleableActiveColor;
      }
      return themeData.unselectedWidgetColor;
    });
  }

  BorderSide? _resolveSide(BorderSide? side) {
    if (side is MaterialStateBorderSide) {
      return MaterialStateProperty.resolveAs<BorderSide?>(side, states);
    }
    if (!states.contains(MaterialState.selected)) {
      return side;
    }
    return null;
  }

  bool get isInteractive => onChanged != null;
  bool _focused = false;
  void _handleFocusHighlightChanged(bool focused) {
    if (focused != _focused) {
      _focused = focused;
      setState(() {});
    }
  }

  bool _hovering = false;
  void _handleHoverEnter(PointerEnterEvent event) {
    if (!isInteractive) return;
    _downPosition = event.localPosition;
    _hovering = true;
    setState(() {});
  }

  void _handleHoverExit(PointerExitEvent event) {
    if (!isInteractive) return;
    _downPosition = event.localPosition;
    _hovering = false;
    setState(() {});
  }

  void _handleTap([Intent? _]) {
    if (!isInteractive) return;

    switch (value) {
      case false:
        onChanged!(true);
        break;
      case true:
        onChanged!(tristate ? null : false);
        break;
      case null:
        onChanged!(false);
        break;
    }
    context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
  }

  Offset? get downPosition => _downPosition;
  Offset? _downPosition;

  void _handleTapDown(TapDownDetails details) {
    if (isInteractive) {
      _downPosition = details.localPosition;
      setState(() {});
    }
  }

  void _handleTapEnd([TapUpDetails? _]) {
    if (_downPosition != null) {
      _downPosition = null;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData themeData = Theme.of(context);
    final CheckboxThemeData checkboxTheme = CheckboxTheme.of(context);
    final MaterialTapTargetSize effectiveMaterialTapTargetSize =
        widget.materialTapTargetSize ??
            checkboxTheme.materialTapTargetSize ??
            themeData.materialTapTargetSize;
    final VisualDensity effectiveVisualDensity = widget.visualDensity ??
        checkboxTheme.visualDensity ??
        themeData.visualDensity;
    // Colors need to be resolved in selected and non selected states separately
    // so that they can be lerped between.
    final Set<MaterialState> activeStates = states..add(MaterialState.selected);
    final Color effectiveActiveColor =
        widget.fillColor?.resolve(activeStates) ??
            _widgetFillColor.resolve(activeStates) ??
            checkboxTheme.fillColor?.resolve(activeStates) ??
            _defaultFillColor.resolve(activeStates);

    final Set<MaterialState> focusedStates = states..add(MaterialState.focused);
    final Color effectiveFocusOverlayColor =
        widget.overlayColor?.resolve(focusedStates) ??
            widget.focusColor ??
            checkboxTheme.overlayColor?.resolve(focusedStates) ??
            themeData.focusColor;

    final Set<MaterialState> hoveredStates = states..add(MaterialState.hovered);
    final Color effectiveHoverOverlayColor =
        widget.overlayColor?.resolve(hoveredStates) ??
            widget.hoverColor ??
            checkboxTheme.overlayColor?.resolve(hoveredStates) ??
            themeData.hoverColor;

    final Color effectiveBorderColor =
        widget.fillColor?.resolve(activeStates) ??
            _widgetFillColor.resolve(states) ??
            _defaultFillColor.resolve(states);
    final Color effectiveCheckColor = widget.checkColor ??
        checkboxTheme.checkColor?.resolve(states) ??
        const Color(0xFFFFFFFF);

    Size size;
    double iconSize;
    double marginAdjuster;
    double iconSizeAdjuster;
    EdgeInsets effectiveMargin;

    switch (effectiveMaterialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        size = const Size(kMinInteractiveDimension, kMinInteractiveDimension);
        marginAdjuster = _kContainerPadddedMarginAdjuster;
        iconSizeAdjuster = _kPaddedIconSizeAdjuster;
        break;
      case MaterialTapTargetSize.shrinkWrap:
        size = const Size(
            kMinInteractiveDimension - 8.0, kMinInteractiveDimension - 8.0);
        marginAdjuster = _kContainerShrinkMarginAdjuster;
        iconSizeAdjuster = _kShrinkIconSizeAdjuster;
        break;
    }
    size += effectiveVisualDensity.baseSizeAdjustment;
    effectiveMargin = EdgeInsets.all(size.height / marginAdjuster);
    iconSize = size.height / iconSizeAdjuster;

    final MaterialStateProperty<MouseCursor> effectiveMouseCursor =
        MaterialStateProperty.resolveWith<MouseCursor>(
            (Set<MaterialState> states) {
      return MaterialStateProperty.resolveAs<MouseCursor?>(
              widget.mouseCursor, states) ??
          checkboxTheme.mouseCursor?.resolve(states) ??
          MaterialStateMouseCursor.clickable.resolve(states);
    });
    BorderRadius effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(1.0);

    return Semantics(
      checked: widget.value ?? false,
      child: FocusableActionDetector(
        mouseCursor: effectiveMouseCursor.resolve(states),
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        enabled: isInteractive,
        onShowFocusHighlight: _handleFocusHighlightChanged,
        actions: _actionMap,
        child: MouseRegion(
          onEnter: _handleHoverEnter,
          onExit: _handleHoverExit,
          child: GestureDetector(
            excludeFromSemantics: !isInteractive,
            onTap: _handleTap,
            onTapDown: _handleTapDown,
            onTapUp: _handleTapEnd,
            onTapCancel: _handleTapEnd,
            child: CustomPaint(
              size: size,
              painter: RadialReactionPainter()
                ..downPosition = _downPosition
                ..splashRadius = widget.splashRadius ?? kRadialReactionRadius
                ..hoverColor = effectiveHoverOverlayColor
                ..focusColor = effectiveFocusOverlayColor
                ..isHovered = _hovering
                ..isFocused = _focused,
              child: SizedBox.fromSize(
                size: size,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: effectiveMargin,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: effectiveBorderRadius,
                    border: Border.all(
                      width: 2.0,
                      color: value == true || value == null
                          ? Colors.transparent
                          : effectiveBorderColor,
                    ),
                    color: value == true || value == null
                        ? effectiveActiveColor
                        : Colors.transparent,
                  ),
                  child: getEffectiveIconWidgetStateWidget(
                    effectiveCheckColor,
                    size: iconSize,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? getEffectiveIconWidgetStateWidget(Color iconColor,
      {double size = 14}) {
    late final Widget? effectiveIconWidget;
    final effectiveActiveIcon = widget.activeIcon ?? Icons.check;
    final effectiveInactiveIcon = widget.inactiveIcon;
    final effectiveTristateIcon = widget.tristateIcon ?? Icons.remove;

    if (value == true) {
      effectiveIconWidget = _getIconBase(
        effectiveActiveIcon,
        iconColor,
        size,
      );
    } else if (value == false) {
      if (effectiveInactiveIcon != null) {
        effectiveIconWidget = _getIconBase(
          effectiveInactiveIcon,
          iconColor,
          size,
        );
      } else {
        effectiveIconWidget = null;
      }
    } else {
      //tristate
      effectiveIconWidget = _getIconBase(
        effectiveTristateIcon,
        iconColor,
        size,
      );
    }
    return effectiveIconWidget;
  }

  Widget _getIconBase(IconData icon, Color color, double size) {
    return Text(
      String.fromCharCode(icon.codePoint),
      style: TextStyle(
        inherit: false,
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
      ),
    );
  }
}

const double _kContainerPadddedMarginAdjuster = 4.0;
const double _kContainerShrinkMarginAdjuster = 4.5;
const double _kPaddedIconSizeAdjuster = 2.8;
const double _kShrinkIconSizeAdjuster = 2.75;
