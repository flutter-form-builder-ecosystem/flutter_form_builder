import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFields extends StatefulWidget {
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
              onChanged: (val) => print(val),
              builder: (FormFieldState field) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text('Name'),
                      flex: 1,
                    ),
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
                if (valueCandidate == null ||
                    (valueCandidate is String && valueCandidate.isEmpty) ||
                    (valueCandidate is Iterable && valueCandidate.isEmpty) ||
                    (valueCandidate is Map && valueCandidate.isEmpty)) {
                  return 'This field is required.';
                }
                return null;
              },
            ),
            FormBuilderField<String>(
              name: "option",
              validator: (valueCandidate) {
                if (valueCandidate == null ||
                    (valueCandidate is String && valueCandidate.isEmpty) ||
                    (valueCandidate is Iterable && valueCandidate.isEmpty) ||
                    (valueCandidate is Map && valueCandidate.isEmpty)) {
                  return 'This field is required.';
                }
                return null;
              },
              builder: (FormFieldState<String?> field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Select option",
                    contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                    border: InputBorder.none,
                    errorText: field.errorText,
                  ),
                  child: Container(
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
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        print(_formKey.currentState!.value);
                      } else {
                        print("validation failed");
                      }
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Text(
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
