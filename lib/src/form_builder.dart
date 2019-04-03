import 'package:flutter/material.dart';

class FormBuilder extends StatefulWidget {
  final BuildContext context;
  final Function(Map<String, dynamic>) onChanged;
  final WillPopCallback onWillPop;
  final Widget child;
  final bool readonly;
  final bool autovalidate;
  final Key key;

  const FormBuilder(
    this.context, {
    @required this.child,
    this.readonly = false,
    this.key,
    this.onChanged,
    this.autovalidate = false,
    this.onWillPop,
  }) : super(key: key);

  static FormBuilderState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<FormBuilderState>());

  @override
  FormBuilderState createState() => FormBuilderState();
}

class FormBuilderState extends State<FormBuilder> {
  //FIXME: Find way to assert no duplicates in control attributes
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _value = {};

  Map<String, dynamic> get value => _value;

  setValue(String attribute, dynamic value){
    setState(() {
      _value[attribute] = value;
    });
  }

  save() {
    _formKey.currentState.save();
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  reset() {
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: widget.child,
      autovalidate: widget.autovalidate,
      onWillPop: widget.onWillPop,
      onChanged: (){
        if(widget.onChanged != null){
          save();
          widget.onChanged(value);
        }
      },
    );
  }
}
