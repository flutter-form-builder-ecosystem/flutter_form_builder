import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:signature/signature.dart';

class FormBuilderSignaturePad extends FormBuilderField {
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final Uint8List initialValue;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueTransformer valueTransformer;
  @override
  final ValueChanged onChanged;
  @override
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
    this.clearButtonText,
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
            final theme = Theme.of(state.context);
            final localizations = MaterialLocalizations.of(state.context);

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
                        controller: state.effectiveController,
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
                          state.effectiveController.clear();
                          field.didChange(null);
                        },
                        label: Text(
                          clearButtonText ?? localizations.cancelButtonLabel,
                          style: TextStyle(color: theme.errorColor),
                        ),
                        icon: Icon(
                          Icons.clear,
                          color: theme.errorColor,
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
  @override
  FormBuilderSignaturePad get widget => super.widget;

  SignatureController get effectiveController => widget.controller ?? _controller;

  final SignatureController _controller = SignatureController();

  @override
  void initState() {
    super.initState();
    effectiveController.addListener(() async {
      var _value = await effectiveController.toImage() != null
          ? await effectiveController.toPngBytes()
          : null;
      didChange(_value);
    });
  }

  @override
  void reset() {
    effectiveController?.clear();
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
