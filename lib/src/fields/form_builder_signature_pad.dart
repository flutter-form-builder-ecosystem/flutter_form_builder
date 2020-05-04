import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/signature.dart';
// import 'package:signature/signature.dart';

class FormBuilderSignaturePad extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final Uint8List initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueTransformer valueTransformer;
  final ValueChanged onChanged;

  final List<Point> points;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color penColor;
  final double penStrokeWidth;
  final String clearButtonText;
  final FormFieldSetter onSaved;

  FormBuilderSignaturePad({
    Key key,
    @required this.attribute,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.backgroundColor = Colors.white,
    this.penColor = Colors.black,
    this.penStrokeWidth = 3.0,
    this.clearButtonText = "Clear",
    this.initialValue,
    this.points,
    this.width,
    this.height = 200,
    this.valueTransformer,
    this.onChanged,
    this.onSaved,
  }) : super(
    key: key,
    initialValue: initialValue,
    attribute: attribute,
    validators: validators,
    valueTransformer: valueTransformer,
    onChanged: onChanged,
    readOnly: readOnly,
    builder: (field) {
      _FormBuilderSignaturePadState state = field;

      return InputDecorator(
        decoration: decoration.copyWith(
          enabled: !state.readOnly,
          errorText: field.errorText,
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: GestureDetector(
                onVerticalDragUpdate: (_) {},
                child: Signature(
                  key: state.signatureKey,
                  points: state.points,
                  width: width,
                  height: height,
                  backgroundColor: backgroundColor,
                  penColor: penColor,
                  penStrokeWidth: penStrokeWidth,
                  onChanged: (points) async {
                    var signature = await state.signatureKey.currentState
                        .exportBytes();
                    state.value = signature;
                    state.points =
                        state.signatureKey.currentState.exportPoints();
                    field.didChange(state.value);
                  },
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(child: SizedBox()),
                FlatButton.icon(
                  onPressed: () {
                    state.signatureKey.currentState.clear();
                    state.points =
                        state.signatureKey.currentState.exportPoints();
                    state.value = null;
                    field.didChange(state.value);
                  },
                  label: Text(
                    clearButtonText,
                    style: TextStyle(
                        color: Theme
                            .of(state.context)
                            .errorColor),
                  ),
                  icon: Icon(
                    Icons.clear,
                    color: Theme
                        .of(state.context)
                        .errorColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );

  @override
  _FormBuilderSignaturePadState createState() =>
      _FormBuilderSignaturePadState();
}

class _FormBuilderSignaturePadState extends FormBuilderFieldState {
  FormBuilderSignaturePad get widget => super.widget;

  final GlobalKey<SignatureState> signatureKey = GlobalKey();

  Uint8List get value => _value;

  List<Point> get points => _points;

  set points(List<Point> points) {
    setState(() {
      _points = points;
    });
  }

  set value(Uint8List val) {
    setState(() {
      _value = val;
    });
  }

  Uint8List _value;

  List<Point> _points;

  @override
  void initState() {
    _points = widget.points;
    super.initState();
  }
}
