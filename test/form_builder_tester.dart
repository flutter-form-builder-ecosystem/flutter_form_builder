import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final formKey = GlobalKey<FormBuilderState>();

Widget buildTestableFieldWidget(
  Widget widget, {
  Map<String, dynamic> initialValue = const {},
  bool clearValueOnUnregister = false,
}) {
  return MaterialApp(
    home: Scaffold(
      body: FormBuilder(
        key: formKey,
        initialValue: initialValue,
        clearValueOnUnregister: clearValueOnUnregister,
        child: widget,
      ),
    ),
  );
}

bool formSave() => formKey.currentState!.saveAndValidate();
void formFieldDidChange(String fieldName, dynamic value) {
  formKey.currentState!.fields[fieldName]!.didChange(value);
}

T formValue<T>(String name) => formKey.currentState!.value[name];
T formInstantValue<T>(String name) => formKey.currentState!.instantValue[name];
