import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:signature/signature.dart';

class FormBuilderSignaturePad extends FormBuilderField {
  final String attribute;
  final FormFieldValidator validator;
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
    this.validator,
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
          validator: validator,
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

  SignatureController _controller = SignatureController();

  @override
  void initState() {
    super.initState();
    signatureController = widget.controller ?? _controller;
    signatureController.addListener(() async {
      var _value = await signatureController.toImage() != null
          ? await signatureController.toPngBytes()
          : null;
      didChange(_value);
    });
  }

  @override
  void reset() {
    signatureController?.clear();
    super.reset();
  }

  /*@override
  void didUpdateWidget(FormBuilderSignaturePad oldWidget) {
    print("Widget did update...");
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = SignatureController(points: oldWidget.controller.value);
      }
      if (widget.controller != null) {
        setValue(widget.controller.value);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (signatureController.value != value) {
      didChange(signatureController.value);
    }
  }*/
}
