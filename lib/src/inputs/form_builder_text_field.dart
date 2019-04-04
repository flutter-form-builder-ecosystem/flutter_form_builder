import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderTextField extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final String initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final bool autovalidate;
  final int maxLines;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle style;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final bool maxLengthEnforced;
  final int maxLength;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;

  FormBuilderTextField({
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.autovalidate = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enabled = true,
    this.enableInteractiveSelection = true,
    this.maxLengthEnforced = true,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.keyboardType,
    this.style,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
  });

  @override
  _FormBuilderTextFieldState createState() => _FormBuilderTextFieldState();
}

class _FormBuilderTextFieldState extends State<FormBuilderTextField> {
  bool _readonly = false;

  @override
  void initState() {
    _readonly =
        (FormBuilder.of(context)?.readonly == true) ? true : widget.readonly;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
      },
      onSaved: (val) {
        FormBuilder.of(context)?.setAttributeValue(widget.attribute, val);
      },
      enabled: !_readonly,
      style: widget.style,
      focusNode: _readonly ? AlwaysDisabledFocusNode() : null,
      decoration: widget.decoration.copyWith(
        enabled: !_readonly,
      ),
      autovalidate: widget.autovalidate ?? false,
      initialValue: widget.initialValue != null ? "${widget.initialValue}" : '',
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onEditingComplete: widget.onEditingComplete,
      controller: widget.controller,
      autocorrect: widget.autocorrect,
      autofocus: widget.autofocus,
      buildCounter: widget.buildCounter,
      cursorColor: widget.cursorColor,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      keyboardAppearance: widget.keyboardAppearance,
      maxLengthEnforced: widget.maxLengthEnforced,
      onFieldSubmitted: widget.onFieldSubmitted,
      scrollPadding: widget.scrollPadding,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textCapitalization: widget.textCapitalization,
      textDirection: widget.textDirection,
      textInputAction: widget.textInputAction,
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
