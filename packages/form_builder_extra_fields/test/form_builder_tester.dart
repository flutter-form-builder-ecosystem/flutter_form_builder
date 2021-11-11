import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final _formKey = GlobalKey<FormBuilderState>();

Widget buildTestableFieldWidget(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: widget,
      ),
    ),
  );
}

bool formSave() => _formKey.currentState!.saveAndValidate();
dynamic formFieldValue(String name) => _formKey.currentState!.value[name];
