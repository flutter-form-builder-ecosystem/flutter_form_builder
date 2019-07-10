import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderChipsInput<T> extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final List<T> initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final ChipsInputSuggestions findSuggestions;

  // final ValueChanged<List<T>> onChanged;
  final ValueChanged<T> onChipTapped;
  final ChipsBuilder<T> chipBuilder;
  final ChipsBuilder<T> suggestionBuilder;
  final int maxChips;
  final TextStyle textStyle;

  FormBuilderChipsInput({
    @required this.attribute,
    @required this.chipBuilder,
    @required this.suggestionBuilder,
    @required this.findSuggestions,
    this.initialValue = const [],
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.onChipTapped,
    this.maxChips,
    this.onChanged,
    this.valueTransformer,
    this.textStyle,
  });

  @override
  _FormBuilderChipsInputState createState() => _FormBuilderChipsInputState();
}

class _FormBuilderChipsInputState extends State<FormBuilderChipsInput> {
  bool _readonly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;

  @override
  void initState() {
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    super.initState();
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _readonly = (_formState?.readonly == true) ? true : widget.readonly;

    return SizedBox(
      // height: 200.0,
      child: FormField(
        key: _fieldKey,
        enabled: !_readonly,
        initialValue: widget.initialValue ?? [],
        validator: (val) {
          for (int i = 0; i < widget.validators.length; i++) {
            if (widget.validators[i](val) != null)
              return widget.validators[i](val);
          }
          return null;
        },
        onSaved: (val) {
          if (widget.valueTransformer != null) {
            var transformed = widget.valueTransformer(val);
            _formState?.setAttributeValue(widget.attribute, transformed);
          } else
            _formState?.setAttributeValue(widget.attribute, val);
        },
        builder: (FormFieldState<dynamic> field) {
          return ChipsInput(
            initialValue: field.value,
            enabled: !_readonly,
            decoration: widget.decoration.copyWith(
              enabled: !_readonly,
              errorText: field.errorText,
            ),
            findSuggestions: widget.findSuggestions,
            onChanged: (data) {
              FocusScope.of(context).requestFocus(FocusNode());
              field.didChange(data);
              if (widget.onChanged != null) widget.onChanged(data);
            },
            maxChips: widget.maxChips,
            chipBuilder: widget.chipBuilder,
            suggestionBuilder: widget.suggestionBuilder,
            onChipTapped: widget.onChipTapped,
            textStyle: widget.textStyle,
          );
        },
      ),
    );
  }
}
