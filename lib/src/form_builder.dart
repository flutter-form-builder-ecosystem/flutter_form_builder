import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

typedef ValueTransformer<T> = dynamic Function(T value);

/*class FormBuilder extends Form {
  @override
  final VoidCallback onChanged;
  @override
  final WillPopCallback onWillPop;
  @override
  final Widget child;
  @override
  final bool autovalidate;
  final bool readOnly;
  final Map<String, dynamic> initialValue;

  const FormBuilder({
    Key key,
    @required this.child,
    this.autovalidate = false,
    this.onWillPop,
    this.onChanged,
    this.readOnly,
    this.initialValue = const {},
  }) : super(
          key: key,
          autovalidate: autovalidate,
          child: child,
          onChanged: onChanged,
          onWillPop: onWillPop,
        );

  static FormBuilderState of(BuildContext context) =>
      context.findAncestorStateOfType<FormBuilderState>();
}

class FormBuilderState extends FormState {
  @override
  FormBuilder get widget => super.widget;

  Map<String, dynamic> _value;

  Map<String, dynamic> get value => {...widget.initialValue ?? {}, ..._value};

  Map<String, dynamic> get initialValue => widget.initialValue;

  bool get readOnly => widget.readOnly;

  @override
  void initState() {
    super.initState();
    // _fieldKeys = {};
    _value = {};
  }

  void updateFormAttributeValue(String name, dynamic value) {
    setState(() {
      _value = {..._value, name: value};
    });
  }

  bool saveAndValidate() {
    save();
    return validate();
  }
}*/

class FormBuilder extends StatefulWidget {
  /// Called when one of the form fields changes.
  ///
  /// In addition to this callback being invoked, all the form fields themselves
  /// will rebuild.
  final VoidCallback onChanged;

  /// Enables the form to veto attempts by the user to dismiss the [ModalRoute]
  /// that contains the form.
  ///
  /// If the callback returns a Future that resolves to false, the form's route
  /// will not be popped.
  ///
  /// See also:
  ///
  ///  * [WillPopScope], another widget that provides a way to intercept the
  ///    back button.
  final WillPopCallback onWillPop;

  /// The widget below this widget in the tree.
  ///
  /// This is the root of the widget hierarchy that contains this form.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// Whether the field value can be changed. Defaults to false.
  /// If true, all form fields will not accept user input.
  final bool readOnly;

  /// If true, form fields will validate and update their error text
  /// immediately after every change. Otherwise, you must call
  /// [FormState.validate] to validate.
  final bool autovalidate;

  /// An optional Map of field initialValues. Keys correspond to the field's
  /// name and value to the initialValue of the field.
  ///
  /// The initialValues set here will be ignored if the field has a local
  /// initialValue set.
  final Map<String, dynamic> initialValue;

  const FormBuilder({
    Key key,
    @required this.child,
    this.readOnly = false,
    this.onChanged,
    this.autovalidate = false,
    this.onWillPop,
    this.initialValue = const {},
  }) : super(key: key);

  static FormBuilderState of(BuildContext context) =>
      context.findAncestorStateOfType<FormBuilderState>();

  @override
  FormBuilderState createState() => FormBuilderState();
}

class FormBuilderState extends State<FormBuilder> {
  //TODO: Find way to assert no duplicates in field names
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, FormBuilderFieldState> _fields;

  Map<String, dynamic> _value;

  Map<String, dynamic> get value => {...widget.initialValue ?? {}, ..._value};

  Map<String, dynamic> get initialValue => widget.initialValue;

  Map<String, FormBuilderFieldState> get fields => _fields;

  bool get readOnly => widget.readOnly;

  @override
  void initState() {
    super.initState();
    _fields = {};
    _value = {};
  }

  @override
  void dispose() {
    _fields = null;
    super.dispose();
  }

  void setInternalFieldValue(String name, dynamic value) {
    setState(() {
      _value = {..._value, name: value};
    });
  }

  void registerField(String name, FormBuilderFieldState field) {
    _fields[name] = field;
  }

  void unregisterField(String name) {
    _fields.remove(name);
  }

  void save() {
    _formKey.currentState.save();
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  bool saveAndValidate() {
    _formKey.currentState.save();
    return _formKey.currentState.validate();
  }

  void reset() {
    _formKey.currentState.reset();
  }

  void patchValue(Map<String, dynamic> val){
    val.forEach((key, value) {
      _fields[key]?.patchValue(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: FocusTraversalGroup(
        policy: WidgetOrderTraversalPolicy(),
        child: widget.child,
      ),
      autovalidate: widget.autovalidate,
      onWillPop: widget.onWillPop,
      onChanged: widget.onChanged,
    );
  }
}
