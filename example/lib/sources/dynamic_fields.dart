import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

/// ## Caveats
/// There is a limitation of 2^53 - 1 (approximately 10^15) on the number of new
/// fields that can be added to this widget. For the purposes of the widget, it
/// is more than sufficient.
class DynamicFields extends StatefulWidget {
  const DynamicFields({super.key});

  @override
  State<DynamicFields> createState() => _DynamicFieldsState();
}

class _DynamicFieldsState extends State<DynamicFields> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<Widget> fields = [];
  var _newTextFieldId = 0;
  String savedValue = '';

  @override
  void initState() {
    savedValue = _formKey.currentState?.value.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      // IMPORTANT to remove all references from dynamic field when delete
      clearValueOnUnregister: true,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          FormBuilderTextField(
            name: 'name',
            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(
              label: Text('Started field'),
            ),
          ),
          ...fields,
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    _formKey.currentState!.saveAndValidate();
                    setState(() {
                      savedValue =
                          _formKey.currentState?.value.toString() ?? '';
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  child: const Text("Add field"),
                  onPressed: () {
                    final newTextFieldName = 'name_${_newTextFieldId++}';
                    final newTextFieldKey = ValueKey(_newTextFieldId);
                    setState(() {
                      fields.add(NewTextField(
                        key: newTextFieldKey,
                        name: newTextFieldName,
                        onDelete: () {
                          setState(() {
                            fields.removeWhere((e) => e.key == newTextFieldKey);
                          });
                        },
                      ));
                    });
                  },
                ),
              ),
            ],
          ),
          const Divider(height: 40),
          Text('Saved value: $savedValue'),
        ],
      ),
    );
  }
}

class NewTextField extends StatelessWidget {
  const NewTextField({
    super.key,
    required this.name,
    this.onDelete,
  });
  final String name;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: FormBuilderTextField(
              name: name,
              validator: FormBuilderValidators.minLength(4),
              decoration: const InputDecoration(
                label: Text('New field'),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
