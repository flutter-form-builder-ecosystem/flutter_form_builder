import 'package:flutter/material.dart';

class SignaturePad extends StatefulWidget {
  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  List<Offset> _points = [];
  Paint paint = Paint()
    ..color = Colors.blue
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;
  @override

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition = object.globalToLocal(details.globalPosition);
              _points = List.from(_points)..add(_localPosition);
              // print(_points);
            });
          },
          onPanEnd: (DragEndDetails details) {
            setState(() {
              _points.add(null);
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey)),
            height: 200,
            child: CustomPaint(
              painter: SignaturePainter(paint, points: _points),
              size: Size.fromHeight(200),
            ),
          ),
          // color: Colors.white,
        ),
        Row(
          children: <Widget>[
            Expanded(child: SizedBox()),
            FlatButton(
                onPressed: () {
                  _points.clear();
                  // field.didChange(null);
                },
                child: Text('Clear Signature')),
          ],
        ),
      ],
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
