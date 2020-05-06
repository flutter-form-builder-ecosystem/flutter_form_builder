import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:signature/signature.dart';

class FormBuilderSignaturePad extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final Uint8List initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueTransformer valueTransformer;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;
  final SignatureController controller;

  final double width;
  final double height;
  final Color backgroundColor;
  final String clearButtonText;
  final Border border;

  FormBuilderSignaturePad({
    Key key,
    @required this.attribute,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.backgroundColor,
    this.clearButtonText = "Clear",
    this.initialValue,
    this.width,
    this.height = 200,
    this.valueTransformer,
    this.onChanged,
    this.onSaved,
    this.controller,
    this.border,
  }) : super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validators: validators,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderSignaturePadState state = field;

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: field.errorText,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: border,
                    ),
                    child: GestureDetector(
                      onVerticalDragUpdate: (_) {},
                      child: Signature(
                        controller: state.signatureController,
                        width: width,
                        height: height,
                        backgroundColor: backgroundColor,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: SizedBox()),
                      FlatButton.icon(
                        onPressed: () {
                          state.signatureController.clear();
                          field.didChange(null);
                        },
                        label: Text(
                          clearButtonText,
                          style: TextStyle(
                              color: Theme.of(state.context).errorColor),
                        ),
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(state.context).errorColor,
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

  SignatureController signatureController;

  @override
  void initState() {
    signatureController = widget.controller ?? SignatureController();
    signatureController.addListener(() async {
      didChange(await signatureController.toPngBytes());
    });
    super.initState();
  }

  @override
  void reset() {
    signatureController.clear();
    super.reset();
  }
}
