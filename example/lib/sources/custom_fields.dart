import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFields extends StatefulWidget {
  const CustomFields({Key? key}) : super(key: key);

  @override
  State<CustomFields> createState() => _CustomFieldsState();
}

class _CustomFieldsState extends State<CustomFields> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          FormBuilderField<String?>(
            name: 'name',
            builder: (FormFieldState field) {
              return CupertinoTextField(
                onChanged: (value) => field.didChange(value),
              );
            },
          ),
          const SizedBox(height: 10),
          FormBuilderField<bool>(
            name: 'terms',
            builder: (FormFieldState field) {
              return CheckboxListTile(
                title: const Text('I Accept the terms and conditions'),
                value: field.value ?? false,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) => field.didChange(value),
              );
            },
          ),
          const SizedBox(height: 10),
          FormBuilderField<String?>(
            name: 'name',
            builder: (FormFieldState field) {
              return CupertinoFormRow(
                prefix: const Text('Name: '),
                error: field.errorText != null ? Text(field.errorText!) : null,
                child: CupertinoTextField(
                  onChanged: (value) => field.didChange(value),
                ),
              );
            },
            autovalidateMode: AutovalidateMode.always,
            validator: (valueCandidate) {
              if (valueCandidate?.isEmpty ?? true) {
                return 'This field is required.';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      debugPrint(_formKey.currentState!.value.toString());
                    } else {
                      debugPrint("validation failed");
                    }
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
