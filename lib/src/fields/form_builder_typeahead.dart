import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/always_disabled_focus_node.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

typedef String SelectionToTextTransformer<T>(T suggestion);

class FormBuilderTypeAhead<T> extends FormBuilderField {
  final String attribute;
  final List<FormFieldValidator> validators;
  final T initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final bool getImmediateSuggestions;
  final bool autovalidate;
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
    @required this.attribute,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.getImmediateSuggestions = false,
    this.autovalidate = false,
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
    this.onChanged,
    this.valueTransformer,
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
          validators: validators,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          builder: (FormFieldState field) {
            final _FormBuilderTypeAheadState state = field;

            return TypeAheadField<T>(
              textFieldConfiguration: textFieldConfiguration.copyWith(
                enabled: !state.readOnly,
                controller: state.typeAheadController,
                style: state.readOnly
                    ? Theme.of(state.context).textTheme.subhead.copyWith(
                          color: Theme.of(state.context).disabledColor,
                        )
                    : textFieldConfiguration.style,
                focusNode: state.typeAheadFocusNode,
                decoration: decoration.copyWith(
                  enabled: state.readOnly,
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
  FormBuilderTypeAhead get widget => super.widget;

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
