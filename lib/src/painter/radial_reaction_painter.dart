import 'package:flutter/material.dart';

class RadialReactionPainter extends CustomPainter {
  Color? _hoverColor;
  Color get hoverColor => _hoverColor!;
  set hoverColor(Color? value) {
    if (value == _hoverColor) {
      return;
    }
    _hoverColor = value;
  }

  Color? _focusColor;
  Color get focusColor => _focusColor!;
  set focusColor(Color? value) {
    if (value == _focusColor) {
      return;
    }
    _focusColor = value;
  }

  bool? _isFocused;
  bool get isFocused => _isFocused!;
  set isFocused(bool? value) {
    if (value == _isFocused) {
      return;
    }
    _isFocused = value;
  }

  bool? _isHovered;
  bool get isHovered => _isHovered!;
  set isHovered(bool? value) {
    if (value == _isHovered) {
      return;
    }
    _isHovered = value;
  }

  Offset? _downPosition;
  Offset? get downPosition => _downPosition;
  set downPosition(Offset? value) {
    if (value == _downPosition) {
      return;
    }
    _downPosition = value;
  }

  double? _splashRadius;
  double get splashRadius => _splashRadius!;
  set splashRadius(double? value) {
    if (value == _splashRadius) {
      return;
    }
    _splashRadius = value;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center =
        Offset.lerp(downPosition, size.center(Offset.zero), 1.0)!;
    if (isFocused) {
      var radialFocusReactionPaint = Paint()
        ..color = focusColor
        ..style = PaintingStyle.fill;

      return canvas.drawCircle(center, splashRadius, radialFocusReactionPaint);
    }
    if (isHovered) {
      var radialHoverReactionPaint = Paint()
        ..color = hoverColor
        ..style = PaintingStyle.fill;

      return canvas.drawCircle(center, splashRadius, radialHoverReactionPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
