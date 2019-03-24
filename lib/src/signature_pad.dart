import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class SignaturePad extends StatefulWidget {
  final Function onChanged;
  final Color color;
  final StrokeCap strokeCap;
  final double strokeWidth;
  // Add boxDecoration,

  const SignaturePad(
      {Key key, this.onChanged, this.color, this.strokeCap, this.strokeWidth})
      : super(key: key);

  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  List<Offset> _points = [];
  Paint paint;

  initState() {
    paint = Paint()
      ..color = widget.color ?? Colors.black54
      ..strokeCap = widget.strokeCap ?? StrokeCap.round
      ..strokeWidth = widget.strokeWidth ?? 5.0;
    super.initState();
  }

  Future<ui.Image> get rendered {
    // [CustomPainter] has its own @canvas to pass our
    // [ui.PictureRecorder] object must be passed to [Canvas]#contructor
    // to capture the Image. This way we can pass @recorder to [Canvas]#contructor
    // using @painter[SignaturePainter] we can call [SignaturePainter]#paint
    // with the our newly created @canvas
    if(_points.length == 0)
      return null;

    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    SignaturePainter painter = SignaturePainter(paint, points: _points);
    var size = context.size;
    painter.paint(canvas, size);
    return recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  getImage() async {
    ui.Image image = await rendered;
    if (widget.onChanged != null) widget.onChanged(image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 250,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
            ),
            height: 200,
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  RenderBox object = context.findRenderObject();
                  Offset _localPosition =
                      object.globalToLocal(details.globalPosition);
                  _points = List.from(_points)..add(_localPosition);
                  getImage();
                  // print(_points);
                });
              },
              onPanEnd: (DragEndDetails details) {
                setState(() {
                  _points.add(null);
                  getImage();
                });
              },
              onVerticalDragUpdate: (_) {},
              child: ClipRect(
               //  borderRadius: BorderRadius.all(0),
                child: CustomPaint(
                  painter: SignaturePainter(paint, points: _points),
                  size: Size.fromHeight(150),
                ),
              ),
              // color: Colors.white,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(child: SizedBox()),
              FlatButton(
                  onPressed: () {
                    _points.clear();
                    getImage();
                  },
                  child: Text('Clear Signature')),
            ],
          ),
        ],
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  List<Offset> points = <Offset>[];
  Paint painty;

  SignaturePainter(this.painty, {this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], painty);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
