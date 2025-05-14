import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Example',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.supportedLocales,
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
      appBar: AppBar(title: const Text('Minimal code example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              FormBuilderFilterChips<String>(
                decoration: const InputDecoration(
                  labelText: 'The language of my people',
                ),
                name: 'languages_filter',
                selectedColor: Colors.red,
                options: const [
                  FormBuilderChipOption(
                    value: 'Dart',
                    avatar: CircleAvatar(child: Text('D')),
                  ),
                  FormBuilderChipOption(
                    value: 'Kotlin',
                    avatar: CircleAvatar(child: Text('K')),
                  ),
                  FormBuilderChipOption(
                    value: 'Java',
                    avatar: CircleAvatar(child: Text('J')),
                  ),
                  FormBuilderChipOption(
                    value: 'Swift',
                    avatar: CircleAvatar(child: Text('S')),
                  ),
                  FormBuilderChipOption(
                    value: 'Objective-C',
                    avatar: CircleAvatar(child: Text('O')),
                  ),
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.minLength(1),
                  FormBuilderValidators.maxLength(3),
                ]),
              ),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.saveAndValidate();
                  debugPrint(_formKey.currentState?.value.toString());
                },
                child: const Text('Print'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
