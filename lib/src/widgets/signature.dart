import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

///Signature canvas. All parameters are optional. It expands by default. This behaviour can be
///overridden using width and/or height parameters.
class Signature extends StatefulWidget {
  Signature({
    this.key,
    this.points,
    this.width,
    this.height,
    this.backgroundColor = Colors.grey,
    this.penColor = Colors.black,
    this.penStrokeWidth = 3.0,
    this.onChanged,
  });

  final List<Point> points;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color penColor;
  final double penStrokeWidth;
  final GlobalKey<SignatureState> key;
  final ValueChanged<List<Point>> onChanged;

  @override
  State createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  GlobalKey _painterKey;
  _SignaturePainter painter;
  List<Point> _points;

  ///Returns collection of 2D points that represents current signature
  List<Point> exportPoints() {
    return _points;
  }

  @override
  void initState() {
    super.initState();
    _painterKey = GlobalKey();
    _points = widget.points ?? List<Point>();
  }

  //CLEAR POINTS AND REBUILD. CANVAS WILL BE BLANK
  void clear() {
    setState(() => _points.clear());
    //NOTIFY OF CHANGE AFTER SIGNATURE PAD CLEARED
    widget.onChanged(_points);
  }

  //CHECK IF SIGNATURE IS EMPTY
  bool isEmpty() {
    return _points?.isEmpty ?? true;
  }

  //EXPORT DATA AS PNG AND RETURN BYTES
  Future<Uint8List> exportBytes() async {
    return await painter.export();
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = widget.width ?? double.infinity;
    var maxHeight = widget.height ?? double.infinity;
    painter = _SignaturePainter(
      _points,
      widget.penColor,
      widget.penStrokeWidth,
    );
    //SIGNATURE CANVAS
    var signatureCanvas = Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: Listener(
        onPointerDown: (event) => _addPoint(event, PointType.tap),
        onPointerUp: (event) {
          _addPoint(event, PointType.tap);
          //NOTIFY OF CHANGE AFTER MOVEMENT IS DONE
          widget.onChanged(_points);
        },
        onPointerMove: (event) => _addPoint(event, PointType.move),
        child: RepaintBoundary(
          child: CustomPaint(
            key: _painterKey,
            painter: painter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: maxWidth,
                minHeight: maxHeight,
                maxWidth: maxWidth,
                maxHeight: maxHeight,
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.width != null || widget.height != null) {
      //IF BOUNDARIES ARE DEFINED, USE LIMITED BOX
      return Center(
        child: LimitedBox(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          child: signatureCanvas,
        ),
      );
    } else {
      //IF NO BOUNDARIES ARE DEFINED, USE EXPANDED
      return Expanded(
        child: signatureCanvas,
      );
    }
  }

  void _addPoint(PointerEvent event, PointType type) {
    RenderBox box = _painterKey.currentContext.findRenderObject();
    Offset o = box.globalToLocal(event.position);
    //SAVE POINT ONLY IF IT IS IN THE SPECIFIED BOUNDARIES
    if ((widget.width == null || o.dx > 0 && o.dx < widget.width) &&
        (widget.height == null || o.dy > 0 && o.dy < widget.height)) {
      // IF USER LEFT THE BOUNDARY AND AND ALSO RETURNED BACK
      // IN ONE MOVE, RETYPE IT AS TAP, AS WE DO NOT WANT TO
      // LINK IT WITH PREVIOUS POINT
      if (_points.length != 0 && _isFar(o, _points.last.offset)) {
        type = PointType.tap;
      }
      setState(() {
        _points.add(Point(o, type));
      });
    }
  }

  bool _isFar(Offset o1, Offset o2) {
    return (o1.dx - o2.dx).abs() > 30 || (o1.dy - o2.dy).abs() > 30;
  }
}

enum PointType { tap, move }

class Point {
  Offset offset;
  PointType type;

  Point(this.offset, this.type);
}

class _SignaturePainter extends CustomPainter {
  Size _canvasSize;
  List<Point> _points;
  Paint _penStyle;

  _SignaturePainter(this._points, Color penColor, double penStrokeWidth) {
    this._penStyle = Paint()
      ..color = penColor
      ..strokeWidth = penStrokeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _canvasSize = size;
    if (_points == null || _points.isEmpty) return;
    for (int i = 0; i < (_points.length - 1); i++) {
      if (_points[i + 1].type == PointType.move) {
        canvas.drawLine(
          _points[i].offset,
          _points[i + 1].offset,
          _penStyle,
        );
      } else {
        canvas.drawCircle(
          _points[i].offset,
          2.0,
          _penStyle,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter other) => true;

  Future<Uint8List> export() async {
    var recorder = PictureRecorder();
    var origin = Offset(0.0, 0.0);
    var paintBounds = Rect.fromPoints(
      _canvasSize.topLeft(origin),
      _canvasSize.bottomRight(origin),
    );
    var canvas = Canvas(recorder, paintBounds);
    paint(canvas, _canvasSize);
    var picture = recorder.endRecording();
    //we are wrapping picture.toImage in Future.value because of change in flutter 1.2.0 (beta)
    //flutter stable (1.0.0) however still returns Image not future.
    //although await is only thing that is required it is not best practice to await something
    //that is not Future
    var image = await Future.value(picture.toImage(
      _canvasSize.width.round(),
      _canvasSize.height.round(),
    ));
    var bytes = await image.toByteData(format: ImageByteFormat.png);
    return bytes.buffer.asUint8List();
  }
}
