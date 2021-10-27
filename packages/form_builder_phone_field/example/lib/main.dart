import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FormBuilderPhoneField")),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FormBuilderPhoneField(
                name: 'phone_number',
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Hint',
                ),
                // onChanged: _onChanged,
                priorityListByIsoCode: const ['KE'],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(context),
                  FormBuilderValidators.required(context),
                ]),
              ),
              const SizedBox(height: 15),
              FormBuilderPhoneField(
                name: 'phone_number_cupertino',
                isCupertinoPicker: true,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Hint',
                ),
                // onChanged: _onChanged,
                priorityListByIsoCode: const ['US'],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(context),
                  FormBuilderValidators.required(context),
                ]),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    debugPrint(_formKey.currentState!.value.toString());
                  }
                },
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
