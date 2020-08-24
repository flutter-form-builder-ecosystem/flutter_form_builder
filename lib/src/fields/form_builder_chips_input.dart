import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChipsInput<T> extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final List<T> initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final ChipsInputSuggestions findSuggestions;

  // final ValueChanged<List<T>> onChanged;
  final ChipsBuilder<T> chipBuilder;
  final ChipsBuilder<T> suggestionBuilder;
  final int maxChips;
  final TextStyle textStyle;
  final String actionLabel;
  final bool autocorrect;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final Brightness keyboardAppearance;
  final bool obscureText;
  final double suggestionsBoxMaxHeight;
  final TextCapitalization textCapitalization;
  final FormFieldSetter onSaved;
  final FocusNode focusNode;
  final bool allowChipEditing;
  final bool autofocus;

  FormBuilderChipsInput({
    Key key,
    @required this.attribute,
    @required this.chipBuilder,
    @required this.suggestionBuilder,
    @required this.findSuggestions,
    this.initialValue = const [],
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.maxChips,
    this.onChanged,
    this.valueTransformer,
    this.textStyle,
    this.actionLabel,
    this.suggestionsBoxMaxHeight,
    this.autocorrect = false,
    this.inputAction = TextInputAction.done,
    this.inputType = TextInputType.text,
    this.keyboardAppearance = Brightness.light,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.onSaved,
    this.focusNode,
    this.allowChipEditing = false,
    this.autofocus = false,
  }) : super(key: key);

  @override
  _FormBuilderChipsInputState createState() => _FormBuilderChipsInputState();
}

class _FormBuilderChipsInputState extends State<FormBuilderChipsInput> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  List<dynamic> _initialValue;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        ((_formState?.initialValue?.containsKey(widget.attribute) ?? false)
            ? _formState.initialValue[widget.attribute]
            : null);
    super.initState();
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _readOnly = _formState?.readOnly == true || widget.readOnly;

    return FormField(
      key: _fieldKey,
      enabled: !_readOnly,
      initialValue: _initialValue ?? [],
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
      builder: (FormFieldState<dynamic> field) {
        return ChipsInput(
          key: ObjectKey(field.value),
          initialValue: field.value,
          enabled: !_readOnly,
          decoration: widget.decoration.copyWith(
            enabled: !_readOnly,
            errorText: field.errorText,
          ),
          findSuggestions: widget.findSuggestions,
          onChanged: (data) {
            field.didChange(data);
            widget.onChanged?.call(data);
          },
          maxChips: widget.maxChips,
          chipBuilder: widget.chipBuilder,
          suggestionBuilder: widget.suggestionBuilder,
          textStyle: widget.textStyle,
          actionLabel: widget.actionLabel,
          autocorrect: widget.autocorrect,
          inputAction: widget.inputAction,
          inputType: widget.inputType,
          keyboardAppearance: widget.keyboardAppearance,
          obscureText: widget.obscureText,
          suggestionsBoxMaxHeight: widget.suggestionsBoxMaxHeight,
          textCapitalization: widget.textCapitalization,
          focusNode: widget.focusNode,
          allowChipEditing: widget.allowChipEditing,
          autofocus: widget.autofocus,
        );
      },
    );
  }
}
