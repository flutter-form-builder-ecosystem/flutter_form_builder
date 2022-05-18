import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// A field that takes a list of `Chip`s as input and suggests more options
/// while typing
class FormBuilderChipsInput<T> extends FormBuilderField<List<T>> {
  //TODO: Add documentation
  final ChipsInputSuggestions<T> findSuggestions;

  final bool allowChipEditing;
  final bool autocorrect;
  final bool autofocus;
  final bool obscureText;
  final Brightness keyboardAppearance;
  final ChipsBuilder<T> chipBuilder;
  final ChipsBuilder<T> suggestionBuilder;
  final double? suggestionsBoxMaxHeight;
  final int? maxChips;
  final String? actionLabel;
  final TextCapitalization textCapitalization;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final TextOverflow textOverflow;
  final TextStyle? textStyle;

  /// Creates a field that takes a list of `Chip`s as input and suggests more options
  /// while typing
  FormBuilderChipsInput({
    Key? key,
    //From Super
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    FocusNode? focusNode,
    FormFieldSetter<List<T>>? onSaved,
    FormFieldValidator<List<T>>? validator,
    InputDecoration decoration = const InputDecoration(),
    List<T> initialValue = const [],
    required String name,
    required this.chipBuilder,
    required this.findSuggestions,
    required this.suggestionBuilder,
    ValueChanged<List<T>?>? onChanged,
    ValueTransformer<List<T>?>? valueTransformer,
    VoidCallback? onReset,
    this.actionLabel,
    this.allowChipEditing = false,
    this.autocorrect = false,
    this.autofocus = false,
    this.inputAction = TextInputAction.done,
    this.inputType = TextInputType.text,
    this.keyboardAppearance = Brightness.light,
    this.maxChips,
    this.obscureText = false,
    this.suggestionsBoxMaxHeight,
    this.textCapitalization = TextCapitalization.none,
    this.textOverflow = TextOverflow.clip,
    this.textStyle,
  }) : super(
          autovalidateMode: autovalidateMode,
          decoration: decoration,
          enabled: enabled,
          focusNode: focusNode,
          initialValue: initialValue,
          key: key,
          name: name,
          onChanged: onChanged,
          onReset: onReset,
          onSaved: onSaved,
          validator: validator,
          valueTransformer: valueTransformer,
          builder: (FormFieldState<List<T>?> field) {
            final state = field as FormBuilderChipsInputState<T>;

            return ChipsInput<T>(
              key: UniqueKey(),
              initialValue: field.value!,
              enabled: state.enabled,
              decoration: state.decoration,
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
          },
        );

  @override
  FormBuilderChipsInputState<T> createState() =>
      FormBuilderChipsInputState<T>();
}

class FormBuilderChipsInputState<T>
    extends FormBuilderFieldState<FormBuilderChipsInput<T>, List<T>> {}
