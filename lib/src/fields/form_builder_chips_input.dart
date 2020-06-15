import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChipsInput<T> extends FormBuilderField {
  final String attribute;
  final FormFieldValidator validator;
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
  final TextOverflow textOverflow;

  FormBuilderChipsInput( {
    Key key,
    @required this.attribute,
    @required this.chipBuilder,
    @required this.suggestionBuilder,
    @required this.findSuggestions,
    this.initialValue = const [],
    this.validator,
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
    this.textOverflow,
  }) : super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            builder: (FormFieldState field) {
              final _FormBuilderChipsInputState state = field;

              return ChipsInput(
                key: ObjectKey(state.value),
                initialValue: field.value,
                enabled: !state.readOnly,
                decoration: decoration.copyWith(
                  enabled: !state.readOnly,
                  errorText: field.errorText,
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
                focusNode: focusNode,
                textOverflow: textOverflow,
              );
            });

  @override
  _FormBuilderChipsInputState createState() => _FormBuilderChipsInputState();
}

class _FormBuilderChipsInputState extends FormBuilderFieldState {
  FormBuilderChipsInput get widget => super.widget;
}
