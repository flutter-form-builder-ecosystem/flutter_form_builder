import 'package:flutter/material.dart';

class TouchSpin extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final double step;
  final double size;
  final ValueChanged<double> onChange;

  const TouchSpin({
    Key key,
    this.value = 1.0,
    this.onChange,
    this.min = 1.0,
    this.max = 9999999.0,
    this.step = 1.0,
    this.size = 24.0,
  }) : super(key: key);

  @override
  _TouchSpinState createState() => _TouchSpinState();
}

class _TouchSpinState extends State<TouchSpin> {
  double value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final iconPadding = const EdgeInsets.all(4.0);
    bool minusBtnDisabled = value <= widget.min ||
        value - widget.step < widget.min ||
        widget.onChange == null;
    bool addBtnDisabled = value >= widget.max ||
        value + widget.step > widget.max ||
        widget.onChange == null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: iconPadding,
            child: Icon(
              Icons.remove,
              size: widget.size,
              color: minusBtnDisabled
                  ? theme.disabledColor
                  : theme.textTheme.button.color,
            ),
          ),
          onTap: minusBtnDisabled
              ? null
              : () {
                  double newVal = value - widget.step;
                  setState(() {
                    value = newVal;
                  });
                  widget.onChange(newVal);
                },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: ConstrainedBox(
            child: Center(child: Text(value.toString())),
            constraints: BoxConstraints(minWidth: widget.size),
          ),
        ),
        InkWell(
          child: Padding(
            padding: iconPadding,
            child: Icon(
              Icons.add,
              size: widget.size,
              color: addBtnDisabled
                  ? theme.disabledColor
                  : theme.textTheme.button.color,
            ),
          ),
          onTap: addBtnDisabled
              ? null
              : () {
                  double newVal = value + widget.step;
                  setState(() {
                    value = newVal;
                  });
                  widget.onChange(newVal);
                },
        ),
      ],
    );
  }
}
