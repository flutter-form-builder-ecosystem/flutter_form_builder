import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

Widget buildTestableFieldWidget(
  Widget widget, {
  Map<String, dynamic> initialValue = const <String, dynamic>{},
  bool skipDisabled = false,
  bool clearValueOnUnregister = false,
  AutovalidateMode? autovalidateMode,
}) {
  return MaterialApp(
    home: Scaffold(
      body: FormBuilder(
        key: formKey,
        skipDisabled: skipDisabled,
        initialValue: initialValue,
        clearValueOnUnregister: clearValueOnUnregister,
        autovalidateMode: autovalidateMode,
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
