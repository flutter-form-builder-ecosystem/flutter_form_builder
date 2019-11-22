import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/signature.dart';
// import 'package:signature/signature.dart';

class FormBuilderSignaturePad extends StatefulWidget {
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
  });

  @override
  _FormBuilderSignaturePadState createState() =>
      _FormBuilderSignaturePadState();
}

class _FormBuilderSignaturePadState extends State<FormBuilderSignaturePad> {
  bool _readOnly = false;
  Uint8List _value;
  List<Point> _points;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<SignatureState> _signatureKey = GlobalKey<SignatureState>();
  FormBuilderState _formState;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _points = widget.points;
    super.initState();
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = (_formState?.readOnly == true) ? true : widget.readOnly;

    return FormField<Uint8List>(
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _value,
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
        return null;
      },
      onSaved: (val) {
        var transformed;
        if (widget.valueTransformer != null) {
          transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, val);
        if (widget.onSaved != null) {
          widget.onSaved(transformed ?? val);
        }
      },
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
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
                    key: _signatureKey,
                    points: _points,
                    width: widget.width,
                    height: widget.height,
                    backgroundColor: widget.backgroundColor,
                    penColor: widget.penColor,
                    penStrokeWidth: widget.penStrokeWidth,
                    onChanged: (points) async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      var signature =
                          await _signatureKey.currentState.exportBytes();
                      setState(() {
                        _value = signature;
                        _points = _signatureKey.currentState.exportPoints();
                      });
                      field.didChange(_value);
                      if (widget.onChanged != null) widget.onChanged(_value);
                    },
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  FlatButton.icon(
                    onPressed: () {
                      _signatureKey.currentState.clear();
                      setState(() {
                        _points = _signatureKey.currentState.exportPoints();
                        _value = null;
                      });
                      field.didChange(_value);
                    },
                    label: Text(
                      widget.clearButtonText,
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
