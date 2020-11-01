import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:signature/signature.dart';

class FormBuilderSignaturePad extends FormBuilderField<Uint8List> {
  @Deprecated('Set points within SignatureController')
  final List<Point> points;
  final double width;
  final double height;
  final Color backgroundColor;
  @Deprecated('Set penColor within SignatureController')
  final Color penColor;
  @Deprecated('Set penStrokeWidth within SignatureController')
  final double penStrokeWidth;
  final String clearButtonText;
  final SignatureController controller;

  FormBuilderSignaturePad({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    Uint8List initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<Uint8List> onChanged,
    FormFieldSetter<Uint8List> onSaved,
    ValueTransformer<Uint8List> valueTransformer,
    List<FormFieldValidator<Uint8List>> validators = const [],
    this.backgroundColor = Colors.white,
    this.penColor = Colors.black,
    this.penStrokeWidth = 3.0,
    this.clearButtonText = 'Clear',
    this.points,
    this.width,
    this.height = 200,
    this.controller,
  }) : super(
          key: key,
          attribute: attribute,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: initialValue,
          decoration: decoration,
          onChanged: onChanged,
          onSaved: onSaved,
          valueTransformer: valueTransformer,
          validators: validators,
        );

  @override
  _FormBuilderSignaturePadState createState() =>
      _FormBuilderSignaturePadState();
}

class _FormBuilderSignaturePadState extends FormBuilderFieldState<
    FormBuilderSignaturePad, Uint8List, Uint8List> {
  SignatureController _effectiveController;
  Uint8List _savedValue;

  @override
  void initState() {
    super.initState();
    _savedValue = widget.initialValue;
    _effectiveController = widget.controller ??
        SignatureController(
          // ignore: deprecated_member_use_from_same_package
          points: widget.controller?.points ?? widget.points,
          // ignore: deprecated_member_use_from_same_package
          penColor: widget.controller?.penColor ?? widget.penColor,
          penStrokeWidth:
              // ignore: deprecated_member_use_from_same_package
              widget.controller?.penStrokeWidth ?? widget.penStrokeWidth,
        );
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) async {
      initialValue = widget.initialValue ?? await _getControllerValue();
    });
    _effectiveController.addListener(() async {
      FocusScope.of(context).requestFocus(FocusNode());
      var value = await _getControllerValue();
      fieldKey.currentState.didChange(value);
      widget.onChanged?.call(value);
    });
  }

  Future<Uint8List> _getControllerValue() async {
    return await _effectiveController.toImage() != null
        ? await _effectiveController.toPngBytes()
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<Uint8List>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue,
      autovalidateMode: widget.autovalidateMode,
      validator: (val) =>
          (_savedValue != null && val == null) ? null : validate(val),
      onSaved: (val) {
        if (_savedValue != null && val == null) return;
        save(val);
      },
      builder: (FormFieldState<Uint8List> field) {
        final errorColor = Theme.of(context).errorColor;
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
            errorText: field.errorText,
          ),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: _savedValue != null || readOnly
                    // Display Signature as read only
                    ? Card(
                        elevation: 0,
                        color: widget.backgroundColor,
                        child: Image.memory(
                          _savedValue ?? Uint8List(0),
                          height: widget.height,
                          width: widget.width,
                        ),
                      )
                    // Display the Signature pad in input mode in edit mode
                    : GestureDetector(
                        onVerticalDragUpdate: (_) {},
                        child: Signature(
                          width: widget.width,
                          height: widget.height,
                          backgroundColor: widget.backgroundColor,
                          controller: _effectiveController,
                        ),
                      ),
              ),
              if (!readOnly)
                Row(
                  children: <Widget>[
                    const Expanded(child: SizedBox()),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _savedValue = null;
                        });
                        _effectiveController.clear();
                        field.didChange(null);
                      },
                      label: Text(
                        widget.clearButtonText,
                        style: TextStyle(color: errorColor),
                      ),
                      icon: Icon(
                        Icons.clear,
                        color: errorColor,
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
