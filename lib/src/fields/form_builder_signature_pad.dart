import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:signature/signature.dart';

class FormBuilderSignaturePad extends FormBuilderField<Uint8List> {
  /// Controls the value of the signature pad.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final SignatureController controller;

  /// Width of the canvas
  final double width;

  /// Height of the canvas
  final double height;

  /// Color of the canvas
  final Color backgroundColor;

  /// Text to be displayed on the clear button which clears user input from the canvas
  final String clearButtonText;

  /// Styles the canvas border
  final Border border;

  FormBuilderSignaturePad({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator<Uint8List> validator,
    Uint8List initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<Uint8List> onChanged,
    ValueTransformer<Uint8List> valueTransformer,
    bool enabled = true,
    FormFieldSetter<Uint8List> onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
    this.backgroundColor,
    this.clearButtonText,
    this.width,
    this.height = 200,
    this.controller,
    this.border,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<Uint8List> field) {
            final state = field as _FormBuilderSignaturePadState;
            final theme = Theme.of(state.context);
            final localizations = MaterialLocalizations.of(state.context);
            final cancelButtonColor =
                state.enabled ? theme.errorColor : theme.disabledColor;

            return InputDecorator(
              decoration: state.decoration(),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(border: border),
                    child: GestureDetector(
                      onHorizontalDragUpdate: (_) {},
                      onVerticalDragUpdate: (_) {},
                      child: Signature(
                        controller: state._controller,
                        width: width,
                        height: height,
                        backgroundColor: backgroundColor,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: const SizedBox()),
                      TextButton.icon(
                        onPressed: state.enabled
                            ? () {
                                state._controller.clear();
                                field.didChange(null);
                              }
                            : null,
                        label: Text(
                          clearButtonText ?? localizations.cancelButtonLabel,
                          style: TextStyle(color: cancelButtonColor),
                        ),
                        icon: Icon(Icons.clear, color: cancelButtonColor),
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

class _FormBuilderSignaturePadState
    extends FormBuilderFieldState<FormBuilderSignaturePad, Uint8List> {
  SignatureController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SignatureController();
    _controller.addListener(() async {
      requestFocus();
      final _value = await _controller.toImage() != null
          ? await _controller.toPngBytes()
          : null;
      didChange(_value);
    });
  }

  @override
  void dispose() {
    // Dispose the _controller when initState created it
    if (null == widget.controller) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void reset() {
    _controller?.clear();
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
