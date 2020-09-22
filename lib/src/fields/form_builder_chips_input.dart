import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChipsInput<T> extends FormBuilderField<List<T>> {
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
  final bool allowChipEditing;
  final bool autofocus;
  final TextOverflow textOverflow;

  FormBuilderChipsInput({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    List<T> initialValue = const [],
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
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
    this.allowChipEditing = false,
    this.autofocus = false,
    this.textOverflow,
  }) : super(
            key: key,
            initialValue: initialValue,
            name: name,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            autovalidateMode: autovalidateMode,
            onSaved: onSaved,
            enabled: enabled,
            onReset: onReset,
            decoration: decoration,
            focusNode: focusNode,
            builder: (FormFieldState field) {
              final _FormBuilderChipsInputState state = field;

              return ChipsInput(
                key: ObjectKey(state.value),
                initialValue: field.value,
                enabled: !state.readOnly,
                decoration: decoration.copyWith(
                  enabled: !state.readOnly,
                  errorText: decoration?.errorText ?? field.errorText,
                ),
                findSuggestions: findSuggestions,
                onChanged: (data) {
                  field.didChange(data);
                },
                maxChips: maxChips,
                chipBuilder: chipBuilder,
                suggestionBuilder: suggestionBuilder,
                textStyle: textStyle,
                actionLabel: actionLabel,
                autocorrect: autocorrect,
                inputAction: inputAction,
                inputType: inputType,
                keyboardAppearance: keyboardAppearance,
                obscureText: obscureText,
                suggestionsBoxMaxHeight: suggestionsBoxMaxHeight,
                textCapitalization: textCapitalization,
                allowChipEditing: allowChipEditing,
                autofocus: autofocus,
                focusNode: state.effectiveFocusNode,
                textOverflow: textOverflow,
              );
            });

  @override
  _FormBuilderChipsInputState<T> createState() => _FormBuilderChipsInputState();
}

class _FormBuilderChipsInputState<T> extends FormBuilderFieldState<List<T>> {
  @override
  FormBuilderChipsInput<T> get widget => super.widget as FormBuilderChipsInput;
}
