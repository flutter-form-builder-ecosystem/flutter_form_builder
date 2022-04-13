import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Builder Validators Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      supportedLocales: const [
        Locale('ar'),
        Locale('bn'),
        Locale('ca'),
        Locale('de'),
        Locale('en'),
        Locale('es'),
        Locale('et'),
        Locale('fa'),
        Locale('fr'),
        Locale('hu'),
        Locale('id'),
        Locale('it'),
        Locale('ja'),
        Locale('ko'),
        Locale('lo'),
        Locale('nl'),
        Locale('ro'),
        Locale('sw'),
        Locale('uk'),
        Locale('zh_Hans'),
        Locale('zh_Hant'),
      ],
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
