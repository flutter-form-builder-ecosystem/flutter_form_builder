import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFields extends StatefulWidget {
  const CustomFields({Key? key}) : super(key: key);

  @override
  _CustomFieldsState createState() => _CustomFieldsState();
}

class _CustomFieldsState extends State<CustomFields> {
  final _formKey = GlobalKey<FormBuilderState>();
  var options = ["Option 1", "Option 2", "Option 3"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: <Widget>[
            FormBuilderField<String?>(
              name: 'name',
              onChanged: (val) => debugPrint(val.toString()),
              builder: (FormFieldState field) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: Text('Name'), flex: 1),
                    Expanded(
                      flex: 2,
                      child: InputDecorator(
                        decoration: InputDecoration(
                            errorText: field.errorText,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero),
                        child: CupertinoTextField(
                          onChanged: (value) => field.didChange(value),
                        ),
                      ),
                    ),
                  ],
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
            FormBuilderField<String?>(
              name: "option",
              validator: (valueCandidate) {
                if (valueCandidate?.isEmpty ?? true) {
                  return 'This field is required.';
                }
                return null;
              },
              builder: (FormFieldState<String?> field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Select option",
                    contentPadding:
                        const EdgeInsets.only(top: 10.0, bottom: 0.0),
                    border: InputBorder.none,
                    errorText: field.errorText,
                  ),
                  child: SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      itemExtent: 30,
                      children: options.map((c) => Text(c)).toList(),
                      onSelectedItemChanged: (index) {
                        field.didChange(options[index]);
                      },
                    ),
                  ),
                );
              },
            ),
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
      ),
    );
  }
}
