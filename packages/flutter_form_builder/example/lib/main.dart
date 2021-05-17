import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormBuilder Example',
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
  final _formKey = GlobalKey<FormBuilderState>();
  var options = ["Option 1", "Option 2", "Option 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormBuilder Example'),
      ),
      body: Column(
        children: <Widget>[
          FormBuilder(
            key: _formKey,
            child: Column(
              children: <Widget>[
                FormBuilderField<String>(
                  name: "option",
                  validator: (valueCandidate) {
                    if (valueCandidate == null ||
                        (valueCandidate is String && valueCandidate.isEmpty) ||
                        (valueCandidate is Iterable &&
                            valueCandidate.isEmpty) ||
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
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).accentColor,
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
                  color: Theme.of(context).accentColor,
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
    );
  }
}
