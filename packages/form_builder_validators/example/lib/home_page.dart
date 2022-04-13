import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Builder Validators')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: FormBuilderValidators.required(),
              autovalidateMode: AutovalidateMode.always,
            ),

            // Composing multiple validators
            TextFormField(
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.always,
              validator: FormBuilderValidators.compose([
                /// Makes this field required
                FormBuilderValidators.required(),

                /// Ensures the value entered is numeric - with custom error message
                FormBuilderValidators.numeric(
                    errorText: 'La edad debe ser numérica.'),

                /// Sets a maximum value of 70
                FormBuilderValidators.max(70),

                /// Include your own custom `FormFieldValidator` function, if you want
                /// Ensures positive values only. We could also have used `FormBuilderValidators.min( 0)` instead
                (val) {
                  final number = int.tryParse(val);
                  if (number == null) return null;
                  if (number < 0) return 'We cannot have a negative age';
                  return null;
                }
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
