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

  final ChipsInputSuggestions findSuggestions;
  // final ValueChanged<List<T>> onChanged;
  final ValueChanged<T> onChipTapped;
  final ChipsBuilder<T> chipBuilder;
  final ChipsBuilder<T> suggestionBuilder;
  final int maxChips;

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
  });

  @override
  _FormBuilderChipsInputState createState() => _FormBuilderChipsInputState();
}

class _FormBuilderChipsInputState extends State<FormBuilderChipsInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200.0,
      child: FormField(
        // key: _fieldKey,
        enabled: !(widget.readonly || widget.readonly),
        initialValue: widget.initialValue,
        validator: (val) {
          for (int i = 0; i < widget.validators.length; i++) {
            if (widget.validators[i](val) != null)
              return widget.validators[i](val);
          }
        },
        onSaved: (val) {
          FormBuilder.of(context)?.setValue(widget.attribute, val);
        },
        builder: (FormFieldState<dynamic> field) {
          return ChipsInput(
            initialValue: field.value,
            enabled: !(widget.readonly || widget.readonly),
            decoration: widget.decoration.copyWith(
              enabled: !(widget.readonly || widget.readonly),
              errorText: field.errorText,
            ),
            findSuggestions: widget.findSuggestions,
            onChanged: (data) {
              field.didChange(data);
            },
            maxChips: widget.maxChips,
            chipBuilder: widget.chipBuilder,
            suggestionBuilder: widget.suggestionBuilder,
            onChipTapped: widget.onChipTapped,
          );
        },
      ),
    );
  }
}
