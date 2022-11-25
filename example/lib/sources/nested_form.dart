import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class NestedForm extends StatefulWidget {
  const NestedForm({
    Key? key,
  }) : super(key: key);

  @override
  State<NestedForm> createState() => _NestedFormState();
}

class _NestedFormState extends State<NestedForm> {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilder(
            key: formKey,
            initialValue: const {
              'foo': 'foo value0',
              'inner': {
                'bar': 'bar value1',
                'baz': 'baz value2',
                'inner2': {
                  'test': 'test value',
                },
              }
            },
            child: Column(
              children: [
                FormBuilderTextField(name: 'foo'),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: NestedFormBuilder(
                      name: 'inner',
                      child: Column(
                        children: [
                          FormBuilderTextField(name: 'bar'),
                          FormBuilderTextField(name: 'baz'),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: NestedFormBuilder(
                              name: 'inner2',
                              child: FormBuilderTextField(name: 'test'),
                            ),
                          )
                        ],
                      )),
                )
              ],
            )),
        ElevatedButton(
            onPressed: () {
              final st = formKey.currentState!;
              st.saveAndValidate();
              final value = st.value;
              print("debug form value $value");
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value.toString())));
            },
            child: const Text("Show Value"))
      ],
    );
  }
}
