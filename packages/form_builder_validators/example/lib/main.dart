import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Builder Validators Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Builder Validators'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: FormBuilderValidators.required(context),
              autovalidateMode: AutovalidateMode.always,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.numeric(context,
                    errorText: 'La edad debe ser numérica.'),
                FormBuilderValidators.max(context, 70),
                (val) {
                  var number = double.tryParse(val ?? '');
                  if (number != null) if (number < 0)
                    return 'We cannot have a negative age';
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
