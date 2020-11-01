import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/always_disabled_focus_node.dart';

class FormBuilderTextField extends FormBuilderField<String> {
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
  final TextAlignVertical textAlignVertical;
  final bool autofocus;
  final bool autocorrect;
  final bool maxLengthEnforced;
  final int maxLength;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;
  final bool expands;
  final int minLines;
  final bool showCursor;
  final VoidCallback onTap;
  final ToolbarOptions toolbarOptions;
  final SmartQuotesType smartQuotesType;
  final SmartDashesType smartDashesType;
  final ScrollPhysics scrollPhysics;
  final bool enableSuggestions;
  final Iterable<String> autofillHints;
  final String obscuringCharacter;

  FormBuilderTextField({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    String initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<String> onChanged,
    FormFieldSetter<String> onSaved,
    ValueTransformer<String> valueTransformer,
    List<FormFieldValidator<String>> validators = const [],
    this.maxLines = 1,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforced = true,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
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
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.toolbarOptions,
    this.smartQuotesType,
    this.smartDashesType,
    this.scrollPhysics,
    this.enableSuggestions = true,
    this.autofillHints,
    this.obscuringCharacter = '•',
  })  : assert(initialValue == null || controller == null),
        super(
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
  FormBuilderTextFieldState createState() => FormBuilderTextFieldState();
}

class FormBuilderTextFieldState
    extends FormBuilderFieldState<FormBuilderTextField, String, String> {
  TextEditingController _effectiveController;

  @override
  void initState() {
    super.initState();
    _effectiveController =
        widget.controller ?? TextEditingController(text: initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      enabled: widget.enabled,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      style: widget.style,
      focusNode: readOnly ? AlwaysDisabledFocusNode() : widget.focusNode,
      decoration: widget.decoration.copyWith(enabled: widget.enabled),
      autovalidateMode: widget.autovalidateMode,
      onChanged: (val) {
        widget.onChanged?.call(_effectiveController.text);
      },
      toolbarOptions: widget.toolbarOptions,
      smartQuotesType: widget.smartQuotesType,
      smartDashesType: widget.smartDashesType,
      scrollPhysics: widget.scrollPhysics,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onEditingComplete: widget.onEditingComplete,
      controller: _effectiveController,
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
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textCapitalization: widget.textCapitalization,
      textDirection: widget.textDirection,
      textInputAction: widget.textInputAction,
      strutStyle: widget.strutStyle,
      readOnly: readOnly,
      expands: widget.expands,
      minLines: widget.minLines,
      showCursor: widget.showCursor,
      onTap: widget.onTap,
      autofillHints: widget.autofillHints,
      obscuringCharacter: widget.obscuringCharacter,
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _effectiveController.dispose();
    }
    super.dispose();
  }
}
