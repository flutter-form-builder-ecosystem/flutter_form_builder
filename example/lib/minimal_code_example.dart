import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Example',
      debugShowCheckedModeBanner: false,
      home: const _ExamplePage(),
    );
  }
}

class _ExamplePage extends StatefulWidget {
  const _ExamplePage();

  @override
  State<_ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<_ExamplePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'full_name',
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  Builder(
                    builder: (innerContext) {
                      return Text(
                        FormBuilder.of(innerContext).isValid
                            ? 'OK Valid'
                            : 'X Invalid',
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Builder(builder: (innerContext) {
                    return ElevatedButton(
                      onPressed: () {
                        FormBuilder.of(innerContext).saveAndValidate();
                        debugPrint(
                            FormBuilder.of(innerContext).value.toString());
                      },
                      child: const Text('Print'),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
