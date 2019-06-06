import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class FormBuilderTypeAhead<T> extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final String initialValue;
  final bool readonly;
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

  final SuggestionSelectionCallback<T> onSuggestionSelected;
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

  FormBuilderTypeAhead({
    @required this.attribute,
    this.onSuggestionSelected,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
    this.initialValue,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.getImmediateSuggestions = false,
    this.autovalidate = false,
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
  });

  @override
  _FormBuilderTypeAheadState createState() => _FormBuilderTypeAheadState();
}

class _FormBuilderTypeAheadState extends State<FormBuilderTypeAhead> {
  TextEditingController _typeAheadController;
  bool _readonly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _readonly = (_formState?.readonly == true) ? true : widget.readonly;
    _typeAheadController = TextEditingController(text: widget.initialValue);
    _typeAheadController.addListener(() {
      if (widget.onChanged != null) widget.onChanged(_typeAheadController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      key: _fieldKey,
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
      },
      onSaved: (val) {
        if (widget.valueTransformer != null) {
          var transformed = widget.valueTransformer(val);
          FormBuilder.of(context)
              ?.setAttributeValue(widget.attribute, transformed);
        } else
          _formState?.setAttributeValue(widget.attribute, val);
      },
      // initialValue: widget.initialValue,
      autovalidate: widget.autovalidate,
      textFieldConfiguration: widget.textFieldConfiguration.copyWith(
        enabled: !_readonly,
        controller: _typeAheadController,
        style: _readonly
            ? Theme.of(context).textTheme.subhead.copyWith(
                  color: Theme.of(context).disabledColor,
                )
            : widget.textFieldConfiguration.style,
        focusNode: _readonly
            ? AlwaysDisabledFocusNode()
            : widget.textFieldConfiguration.focusNode,
        decoration: widget.decoration.copyWith(
          enabled: !_readonly,
        ),
      ),
      suggestionsCallback: widget.suggestionsCallback,
      itemBuilder: widget.itemBuilder,
      transitionBuilder: (context, suggestionsBox, controller) =>
          suggestionsBox,
      onSuggestionSelected: (suggestion) {
        if (widget.onSuggestionSelected != null)
          widget.onSuggestionSelected(suggestion);
        _typeAheadController.text = suggestion;
      },
      getImmediateSuggestions: widget.getImmediateSuggestions,
      errorBuilder: widget.errorBuilder,
      noItemsFoundBuilder: widget.noItemsFoundBuilder,
      loadingBuilder: widget.loadingBuilder,
      debounceDuration: widget.debounceDuration,
      suggestionsBoxDecoration: widget.suggestionsBoxDecoration,
      suggestionsBoxVerticalOffset: widget.suggestionsBoxVerticalOffset,
      animationDuration: widget.animationDuration,
      animationStart: widget.animationStart,
      direction: widget.direction,
      hideOnLoading: widget.hideOnLoading,
      hideOnEmpty: widget.hideOnEmpty,
      hideOnError: widget.hideOnError,
      hideSuggestionsOnKeyboardHide: widget.hideSuggestionsOnKeyboardHide,
      keepSuggestionsOnLoading: widget.keepSuggestionsOnLoading,
      autoFlipDirection: widget.autoFlipDirection,
      suggestionsBoxController: widget.suggestionsBoxController,
    );
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    _typeAheadController.dispose();
    super.dispose();
  }
}
