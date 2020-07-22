import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/always_disabled_focus_node.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

typedef SelectionToTextTransformer<T> = String Function(T suggestion);

class FormBuilderTypeAhead<T> extends FormBuilderField {
  final bool getImmediateSuggestions;
  final ErrorBuilder errorBuilder;
  final WidgetBuilder noItemsFoundBuilder;
  final WidgetBuilder loadingBuilder;
  final Duration debounceDuration;
  final SuggestionsBoxDecoration suggestionsBoxDecoration;
  final SelectionToTextTransformer<T> selectionToTextTransformer;
  final ItemBuilder<T> itemBuilder;
  final SuggestionsCallback<T> suggestionsCallback;
  final double suggestionsBoxVerticalOffset;
  final TextFieldConfiguration textFieldConfiguration;
  final AnimationTransitionBuilder transitionBuilder;
  final Duration animationDuration;
  final double animationStart;
  final AxisDirection direction;
  final bool hideOnLoading;
  final bool hideOnEmpty;
  final bool hideOnError;
  final bool hideSuggestionsOnKeyboardHide;
  final bool keepSuggestionsOnLoading;
  final bool autoFlipDirection;
  final SuggestionsBoxController suggestionsBoxController;
  final bool keepSuggestionsOnSuggestionSelected;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final TextEditingController controller;

  // final FormFieldSetter<T> onSaved;

  FormBuilderTypeAhead({
    Key key,
    //From Super
    @required String attribute,
    FormFieldValidator validator,
    T initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    bool autovalidate = false,
    VoidCallback onReset,
    FocusNode focusNode,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
    this.getImmediateSuggestions = false,
    this.selectionToTextTransformer,
    this.errorBuilder,
    this.noItemsFoundBuilder,
    this.loadingBuilder,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.suggestionsBoxDecoration = const SuggestionsBoxDecoration(),
    this.suggestionsBoxVerticalOffset = 5.0,
    this.textFieldConfiguration = const TextFieldConfiguration(),
    this.transitionBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationStart = 0.25,
    this.direction = AxisDirection.down,
    this.hideOnLoading = false,
    this.hideOnEmpty = false,
    this.hideOnError = false,
    this.hideSuggestionsOnKeyboardHide = true,
    this.keepSuggestionsOnLoading = true,
    this.autoFlipDirection = false,
    this.suggestionsBoxController,
    this.keepSuggestionsOnSuggestionSelected = false,
    this.onSuggestionSelected,
    this.controller,
    // this.onSaved,
  })  : assert(T == String || selectionToTextTransformer != null),
        super(
          key: key,
          initialValue: initialValue,
          attribute: attribute,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidate: autovalidate,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          builder: (FormFieldState field) {
            final _FormBuilderTypeAheadState state = field;
            final theme = Theme.of(state.context);

            return TypeAheadField<T>(
              textFieldConfiguration: textFieldConfiguration.copyWith(
                enabled: !state.readOnly,
                controller: state.typeAheadController,
                style: state.readOnly
                    ? theme.textTheme.subtitle1.copyWith(
                        color: theme.disabledColor,
                      )
                    : textFieldConfiguration.style,
                focusNode: state.typeAheadFocusNode,
                decoration: decoration.copyWith(
                  enabled: !state.readOnly,
                  errorText: decoration?.errorText ?? field.errorText,
                ),
              ),
              suggestionsCallback: suggestionsCallback,
              itemBuilder: itemBuilder,
              transitionBuilder: (context, suggestionsBox, controller) =>
                  suggestionsBox,
              onSuggestionSelected: (T suggestion) {
                if (selectionToTextTransformer != null) {
                  state.typeAheadController.text =
                      selectionToTextTransformer(suggestion);
                } else {
                  state.typeAheadController.text =
                      suggestion != null ? suggestion.toString() : '';
                }
                if (onSuggestionSelected != null) {
                  onSuggestionSelected(suggestion);
                }
              },
              getImmediateSuggestions: getImmediateSuggestions,
              errorBuilder: errorBuilder,
              noItemsFoundBuilder: noItemsFoundBuilder,
              loadingBuilder: loadingBuilder,
              debounceDuration: debounceDuration,
              suggestionsBoxDecoration: suggestionsBoxDecoration,
              suggestionsBoxVerticalOffset: suggestionsBoxVerticalOffset,
              animationDuration: animationDuration,
              animationStart: animationStart,
              direction: direction,
              hideOnLoading: hideOnLoading,
              hideOnEmpty: hideOnEmpty,
              hideOnError: hideOnError,
              hideSuggestionsOnKeyboardHide: hideSuggestionsOnKeyboardHide,
              keepSuggestionsOnLoading: keepSuggestionsOnLoading,
              autoFlipDirection: autoFlipDirection,
              suggestionsBoxController: suggestionsBoxController,
              keepSuggestionsOnSuggestionSelected:
                  keepSuggestionsOnSuggestionSelected,
            );
          },
        );

  @override
  _FormBuilderTypeAheadState<T> createState() =>
      _FormBuilderTypeAheadState<T>();
}

class _FormBuilderTypeAheadState<T> extends FormBuilderFieldState {
  @override
  FormBuilderTypeAhead get widget => super.widget as FormBuilderTypeAhead;

  TextEditingController _typeAheadController;
  FocusNode _typeAheadFocusNode;

  FocusNode get typeAheadFocusNode => _typeAheadFocusNode;

  TextEditingController get typeAheadController => _typeAheadController;

  @override
  void initState() {
    super.initState();
    _typeAheadFocusNode = readOnly
        ? AlwaysDisabledFocusNode()
        : widget.textFieldConfiguration.focusNode;
    _typeAheadController = widget.controller ??
        TextEditingController(text: widget.initialValue?.toString());
  }

  @override
  void reset() {
    super.reset();
    _typeAheadController.text = widget.initialValue?.toString();
  }
}
