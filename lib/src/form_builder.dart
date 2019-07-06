import 'package:flutter/material.dart';

typedef ValueTransformer<T> = dynamic Function(T value);

class FormBuilder extends StatefulWidget {
  //final BuildContext context;
  final Function(Map<String, dynamic>) onChanged;
  final WillPopCallback onWillPop;
  final Widget child;
  final bool readonly;
  final bool autovalidate;
  final Key key;

  const FormBuilder( //this.context,
      {
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
  Map<String, GlobalKey<FormFieldState>> _fieldKeys;
  Map<String, dynamic> _value;

  Map<String, dynamic> get value => _value;

  Map<String, GlobalKey<FormFieldState>> get fields => _fieldKeys;

  bool get readonly => widget.readonly;

  @override
  void initState() {
    _fieldKeys = {};
    _value = {};
    super.initState();
  }

  @override
  void dispose() {
    _fieldKeys = null;
    super.dispose();
  }

  void setAttributeValue(String attribute, dynamic value) {
    setState(() {
      _value[attribute] = value;
    });
  }

  registerFieldKey(String attribute, GlobalKey key) {
    // assert(_fieldKeys.containsKey(attribute) == false, "Field with attribute '$attribute' already exists. Make sure that two or more fields don't have the same attribute name.");
    this._fieldKeys[attribute] = key;
  }

  unregisterFieldKey(String attribute) {
    this._fieldKeys.remove(attribute);
  }

  /*changeAttributeValue(String attribute, dynamic newValue) {
    print(this.fieldKeys[attribute]);
    if (this.fieldKeys[attribute] != null){
      print("Current $attribute value: ${this.fieldKeys[attribute].currentState.value}");
      print("Trying to change $attribute to $newValue");
      this.fieldKeys[attribute].currentState.didChange(newValue);
      print("$attribute value after: ${this.fieldKeys[attribute].currentState.value}");
    }
  }*/

  void save() {
    _formKey.currentState.save();
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  void reset() {
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: widget.child,
      autovalidate: widget.autovalidate,
      onWillPop: widget.onWillPop,
      onChanged: () {
        if (widget.onChanged != null) {
          save();
          widget.onChanged(value);
        }
      },
    );
  }
}
