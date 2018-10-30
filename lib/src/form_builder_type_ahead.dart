import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import './form_builder_input.dart';

class FormBuilderTypeAhead extends StatefulWidget {
  final FormBuilderInput formControl;
  final int count;
  final Function onSaved;

  FormBuilderTypeAhead({
    @required this.formControl,
    @required this.count,
    @required this.onSaved,
  });

  @override
  State<StatefulWidget> createState() {
    return _FormBuilderTypeAheadState(formControl);
  }
}

class _FormBuilderTypeAheadState extends State<FormBuilderTypeAhead> {
  FormBuilderInput formControl;
  final TextEditingController _typeAheadController = TextEditingController();

  _FormBuilderTypeAheadState(this.formControl) {
    _typeAheadController.value =
        TextEditingValue(text: formControl.value ?? '');
  }

  //@override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _typeAheadController,
        decoration: InputDecoration(
          labelText: formControl.label ?? formControl.attribute,
        ),
      ),
      suggestionsCallback: formControl.suggestionsCallback,
      itemBuilder: formControl.itemBuilder,
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        _typeAheadController.value = TextEditingValue(text: suggestion);
      },
      validator: (value) {
        if (formControl.require && value.isEmpty)
          return 'This field is required';

        if (formControl.validator != null) return formControl.validator(value);
      },
      onSaved: widget.onSaved,
    );
  }
}
