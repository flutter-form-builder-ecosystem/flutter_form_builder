import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChipsInput<T> extends FormBuilderField<List<T>> {
  final ChipsInputSuggestions<T> findSuggestions;

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
  final FocusNode focusNode;
  final bool allowChipEditing;
  final bool autofocus;

  FormBuilderChipsInput({
    Key key,
    @required String attribute,
    bool readOnly = false,
    AutovalidateMode autovalidateMode,
    bool enabled = true,
    List<T> initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<List<T>> onChanged,
    FormFieldSetter<List<T>> onSaved,
    ValueTransformer<List<T>> valueTransformer,
    List<FormFieldValidator<List<T>>> validators = const [],
    @required this.chipBuilder,
    @required this.suggestionBuilder,
    @required this.findSuggestions,
    this.maxChips,
    this.textStyle,
    this.actionLabel,
    this.suggestionsBoxMaxHeight,
    this.autocorrect = false,
    this.inputAction = TextInputAction.done,
    this.inputType = TextInputType.text,
    this.keyboardAppearance = Brightness.light,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.allowChipEditing = false,
    this.autofocus = false,
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
  _FormBuilderChipsInputState<T> createState() =>
      _FormBuilderChipsInputState<T>();
}

class _FormBuilderChipsInputState<T>
    extends FormBuilderFieldState<FormBuilderChipsInput<T>, List<T>, List<T>> {
  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      key: fieldKey,
      enabled: widget.enabled,
      initialValue: initialValue ?? const [],
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => validate(val),
      onSaved: (val) => save(val),
      builder: (FormFieldState<List<T>> field) {
        return ChipsInput<T>(
          key: ObjectKey(field.value),
          initialValue: field.value,
          enabled: widget.enabled,
          decoration: widget.decoration.copyWith(
            enabled: widget.enabled,
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
