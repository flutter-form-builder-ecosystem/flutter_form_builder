import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ConditionalFields extends StatefulWidget {
  const ConditionalFields({super.key});

  @override
  State<ConditionalFields> createState() => _ConditionalFieldsState();
}

class _ConditionalFieldsState extends State<ConditionalFields> {
  final _formKey = GlobalKey<FormBuilderState>();
  int? option;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          FormBuilderDropdown<int>(
            name: 'options',
            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(
              label: Text('Select the option'),
            ),
            onChanged: (value) {
              setState(() {
                option = value;
              });
            },
            items: const [
              DropdownMenuItem(value: 0, child: Text('Show textfield')),
              DropdownMenuItem(value: 1, child: Text('Show info text')),
            ],
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: option == 0,
            // Can use to recreate completely the field
            // maintainState: false,
            child: FormBuilderTextField(
              name: 'textfield',
              validator: FormBuilderValidators.minLength(4),
              decoration: const InputDecoration(
                label: Text('Magic field'),
              ),
            ),
          ),
          Visibility(
            visible: option == 1,
            child: const Text('Magic info'),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _formKey.currentState!.saveAndValidate();
              debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
            },
          ),
        ],
      ),
    );
  }
}
