import 'package:flutter/material.dart';
import 'package:flutter_form_builder/src/alippo_custom_form_components/fields/alippo_selection_card_group/comp/selection_card_options.dart';

class SelectionCard<T> extends StatefulWidget {
  final Widget? avatar;

  final Widget label;

  final TextStyle? selectedLabelStyle;

  final TextStyle? unselectedLabelStyle;

  final EdgeInsetsGeometry? labelPadding;

  final ValueChanged<bool>? onSelected;

  final double? pressElevation;

  final bool selected;

  final Color? disabledColor;

  final Color? selectedCardColor;

  final Color? defaultCardColor;

  final OutlinedBorder? selectedShape;

  final OutlinedBorder? unselectedShape;

  final FocusNode? focusNode;

  final bool autofocus;

  final EdgeInsetsGeometry? padding;

  final double? elevation;

  final Color? shadowColor;

  final Color? selectedShadowColor;

  final Color? selectedIconColor;

  final Color? unselectedIconColor;

  final bool expanded;

  final bool disabled;

  final Duration? animationDuration;

  final Duration? reverseAnimationDuration;

  final Curve? animationCurve;

  final Curve? reverseAnimationCurve;

  /// Configuration for the info modal
  final InfoModalConfig? infoModalConfig;

  /// Creates an option for fields with selection options
  const SelectionCard({
    super.key,
    required this.label,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.labelPadding,
    this.onSelected,
    this.pressElevation,
    this.selected = false,
    this.disabledColor,
    this.selectedCardColor,
    this.defaultCardColor,
    this.selectedShape,
    this.unselectedShape,
    this.focusNode,
    this.autofocus = false,
    this.padding,
    this.elevation,
    this.shadowColor,
    this.selectedShadowColor,
    this.avatar,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.expanded = false,
    this.disabled = false,
    this.infoModalConfig,
    this.animationDuration,
    this.reverseAnimationDuration,
    this.animationCurve,
    this.reverseAnimationCurve,
  });

  @override
  State<SelectionCard> createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;
  AnimationController? _controller;
  Animation<double>? _animation;

  Duration get animationDuration =>
      widget.animationDuration ?? const Duration(milliseconds: 300);

  Duration get reverseAnimationDuration =>
      widget.reverseAnimationDuration ?? animationDuration;

  Curve get animationCurve => widget.animationCurve ?? Curves.easeInOut;

  Curve get reverseAnimationCurve =>
      widget.reverseAnimationCurve ?? animationCurve;

  @override
  void initState() {
    super.initState();
    isSelected = widget.selected;
    _controller = AnimationController(
      duration: animationDuration,
      reverseDuration: reverseAnimationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller!,
      curve: animationCurve,
      reverseCurve: reverseAnimationCurve,
    ));

    if (isSelected) {
      _controller!.value = 1.0; // If initially selected, show expanded
    }
  }

  @override
  void didUpdateWidget(covariant SelectionCard oldWidget) {
    handleAnimation(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> handleAnimation(SelectionCard oldWidget) async {
    if (widget.selected != oldWidget.selected) {
      if (oldWidget.selected && !widget.selected) {
        await Future.delayed(
          reverseAnimationDuration,
        );
      }
      isSelected = widget.selected;
      if (isSelected) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = AnimatedBuilder(
      animation: _animation!,
      builder: (_, __) {
        return Padding(
          padding: widget.padding ?? const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.avatar != null)
                IconTheme(
                  data: IconThemeData(
                      color: ColorTween(
                    begin: widget.unselectedIconColor ??
                        Theme.of(context)
                            .colorScheme
                            .onSurface, // Light theme color
                    end: (widget.selectedIconColor ??
                        Theme.of(context)
                            .colorScheme
                            .onPrimary), // Dark theme color
                  ).evaluate(_animation!)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: widget.avatar!,
                  ),
                ),
              DefaultTextStyle(
                style: TextStyleTween(
                  begin: widget.unselectedLabelStyle,
                  end: widget.selectedLabelStyle,
                ).evaluate(_animation!),
                child: widget.label,
              ),
            ],
          ),
        );
      },
    );
    final Widget child = widget.expanded
        ? Row(
            children: [
              Expanded(child: content),
            ],
          )
        : content;
    return AnimatedBuilder(
      animation: _animation!,
      builder: (_, __) {
        return Stack(
          children: [
            if (widget.infoModalConfig != null)
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizeTransition(
                  sizeFactor: _animation!,
                  axis: Axis.vertical,
                  child: Transform(
                    transform:
                        Matrix4.diagonal3Values(1.0, _animation!.value, 1.0),
                    alignment: Alignment.topCenter,
                    child: Opacity(
                      opacity: _animation!.value,
                      child: Container(
                        decoration: ShapeDecoration(
                          gradient: widget.infoModalConfig!.gradient,
                          shape: widget.infoModalConfig!.shape,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            left: 20.0,
                            right: 20.0,
                            bottom: 20.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              widget.infoModalConfig!.leadingIcon,
                              const SizedBox(width: 20),
                              Expanded(
                                child: widget.infoModalConfig!.description,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Card(
              color: ColorTween(
                    begin: widget.defaultCardColor, // Light theme color
                    end: widget.selectedCardColor, // Dark theme color
                  ).evaluate(_animation!) ??
                  widget.defaultCardColor,
              elevation: widget.elevation,
              shadowColor: widget.shadowColor,
              shape: widget.selected
                  ? widget.selectedShape
                  : widget.unselectedShape ?? widget.selectedShape,
              margin: EdgeInsets.zero,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  if (widget.onSelected != null) {
                    widget.onSelected!(!widget.selected);
                  }
                },
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}
