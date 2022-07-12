import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final _formKey = GlobalKey<FormBuilderState>();

Widget buildTestableFieldWidget(
  Widget widget, {
  Map<String, dynamic> initialValue = const {},
  bool clearValueOnUnregister = false,
}) {
  return MaterialApp(
    home: Scaffold(
      body: FormBuilder(
        key: _formKey,
        initialValue: initialValue,
        clearValueOnUnregister: clearValueOnUnregister,
        child: widget,
      ),
    ),
  );
}

bool formSave() => _formKey.currentState!.saveAndValidate();
void formFieldDidChange(String fieldName, dynamic value) {
  _formKey.currentState!.fields[fieldName]!.didChange(value);
}

T formValue<T>(String name) => _formKey.currentState!.value[name];
T formInstantValue<T>(String name) => _formKey.currentState!.instantValue[name];
