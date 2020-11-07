import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/always_disabled_focus_node.dart';

class FormBuilderTextField extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final String initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final AutovalidateMode autovalidateMode;
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
  final bool enabled;
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
  final FormFieldSetter onSaved;
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
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.autovalidateMode,
    this.maxLines = 1,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enabled = true,
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
    this.onChanged,
    this.valueTransformer,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onSaved,
    this.onTap,
    this.toolbarOptions,
    this.smartQuotesType,
    this.smartDashesType,
    this.scrollPhysics,
    this.enableSuggestions = true,
    this.autofillHints,
    this.obscuringCharacter = '•',
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  FormBuilderTextFieldState createState() => FormBuilderTextFieldState();
}

class FormBuilderTextFieldState extends State<FormBuilderTextField> {
  bool _readOnly = false;
  TextEditingController _effectiveController;
  FormBuilderState _formState;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  String _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        ((_formState?.initialValue?.containsKey(widget.attribute) ?? false)
            ? _formState.initialValue[widget.attribute]
            : null);
    if (widget.controller != null) {
      _effectiveController = widget.controller;
    } else {
      _effectiveController = TextEditingController(text: _initialValue ?? '');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = _formState?.readOnly == true || widget.readOnly;

    return TextFormField(
      key: _fieldKey,
      validator: (val) =>
          FormBuilderValidators.validateValidators(val, widget.validators),
      onSaved: (val) {
        var transformed;
        if (widget.valueTransformer != null) {
          transformed = widget.valueTransformer(val);
          _formState?.setAttributeValue(widget.attribute, transformed);
        } else {
          _formState?.setAttributeValue(widget.attribute, val);
        }
        widget.onSaved?.call(transformed ?? val);
      },
      enabled: !_readOnly,
      style: widget.style,
      focusNode: _readOnly ? AlwaysDisabledFocusNode() : widget.focusNode,
      decoration: widget.decoration.copyWith(enabled: !_readOnly),
      autovalidateMode: widget.autovalidateMode,
      onChanged: (val) {
        widget.onChanged?.call(_effectiveController.text);
      },
      toolbarOptions: widget.toolbarOptions,
      smartQuotesType: widget.smartQuotesType,
      smartDashesType: widget.smartDashesType,
      scrollPhysics: widget.scrollPhysics,
      enableSuggestions: widget.enableSuggestions,
      // initialValue: "${_initialValue ?? ''}",
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
      readOnly: _readOnly,
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
    _formState?.unregisterFieldKey(widget.attribute);
    if (widget.controller == null) {
      _effectiveController.dispose();
    }
    super.dispose();
  }
}
