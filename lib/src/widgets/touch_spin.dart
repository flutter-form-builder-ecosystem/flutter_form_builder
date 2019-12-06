import 'package:flutter/material.dart';

class TouchSpin extends StatefulWidget {
  final num value;
  final num min;
  final num max;
  final num step;
  final num size;
  final ValueChanged<num> onChange;

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
  num _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final iconPadding = const EdgeInsets.all(4.0);
    bool minusBtnDisabled = _value <= widget.min ||
        _value - widget.step < widget.min ||
        widget.onChange == null;
    bool addBtnDisabled = _value >= widget.max ||
        _value + widget.step > widget.max ||
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
                  num newVal = _value - widget.step;
                  setState(() {
                    _value = newVal;
                  });
                  widget.onChange(newVal);
                },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: ConstrainedBox(
            child: Center(child: Text(_value.toString())),
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
                  num newVal = _value + widget.step;
                  setState(() {
                    _value = newVal;
                  });
                  widget.onChange(newVal);
                },
        ),
      ],
    );
  }
}
