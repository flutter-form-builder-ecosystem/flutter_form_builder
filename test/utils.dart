import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

class TestForm extends StatefulWidget {
  final Widget child;

  final GlobalKey<FormBuilderState> formKey;

  const TestForm({Key key, @required this.child, this.formKey})
      : super(key: key);

  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormBuilder(
          key: widget.formKey,
          child: Column(
            children: <Widget>[
              widget.child,
              FlatButton(
                key: Key('done button'),
                onPressed: () {
                  if (widget.formKey.currentState.saveAndValidate()) {
                    assert(widget.formKey.currentState.value.isNotEmpty);
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

Future insertWidget({
  WidgetTester tester,
  Widget child,
  @required GlobalKey<FormBuilderState> formKey,
}) async {
  await tester.pumpWidget(TestForm(
    child: child,
    formKey: formKey,
  ));

  await tester.pump();
}
