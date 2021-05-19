import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      supportedLocales: [
        Locale('de'),
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('it'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
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

            // Composing multiple validators
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.always,
              validator: FormBuilderValidators.compose([
                /// Makes this field required
                FormBuilderValidators.required(context),

                /// Ensures the value entered is numeric - with custom error message
                FormBuilderValidators.numeric(context,
                    errorText: 'La edad debe ser numérica.'),

                /// Sets a maximum value of 70
                FormBuilderValidators.max(context, 70),

                /// Include your own custom `FormFieldValidator` function, if you want
                /// Ensures positive values only. We could also have used `FormBuilderValidators.min(context, 0)` instead
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
