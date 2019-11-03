import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

class TestForm extends StatefulWidget {

  final Widget child;

  const TestForm({Key key, @required this.child}) : super(key: key);

  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormBuilder(
          key: _fbKey,
          child: Column(
            children: <Widget>[
              widget.child,
              FlatButton(
                key: Key('done button'),
                onPressed: () {
                  if (_fbKey.currentState.saveAndValidate()){
                    print(_fbKey.currentState.value);
                    assert(_fbKey.currentState.value.isNotEmpty);
                  }
                },
                child: Text('Done'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future insertWidget({WidgetTester tester, Widget child}) async {
  await tester.pumpWidget(TestForm(
    child: child,
  ));

  await tester.pump();
}
