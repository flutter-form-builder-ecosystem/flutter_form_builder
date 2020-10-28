import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

typedef ValueTransformer<T> = dynamic Function(T value);

class FormBuilder extends StatefulWidget {
  final Function(Map<String, dynamic>) onChanged;
  final WillPopCallback onWillPop;
  final Widget child;
  final bool readOnly;
  final AutovalidateMode autovalidateMode;
  final Map<String, dynamic> initialValue;

  const FormBuilder({
    Key key,
    @required this.child,
    this.readOnly = false,
    this.onChanged,
    this.autovalidateMode,
    this.onWillPop,
    this.initialValue = const {},
  }) : super(key: key);

  static FormBuilderState of(BuildContext context) =>
      context.findAncestorStateOfType<FormBuilderState>();

  @override
  FormBuilderState createState() => FormBuilderState();
}

class FormBuilderState extends State<FormBuilder> {
  //TODO: Find way to assert no duplicates in field attributes
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, GlobalKey<FormFieldState>> _fieldKeys;

  Map<String, dynamic> _value;

  Map<String, dynamic> get value => {...widget.initialValue ?? {}, ..._value};

  Map<String, dynamic> get initialValue => widget.initialValue;

  Map<String, GlobalKey<FormFieldState>> get fields => _fieldKeys;

  bool get readOnly => widget.readOnly;

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

  void registerFieldKey(String attribute, GlobalKey key) {
    // assert(_fieldKeys.containsKey(attribute) == false, "Field with attribute '$attribute' already exists. Make sure that two or more fields don't have the same attribute name.");
    _fieldKeys[attribute] = key;
  }

  void unregisterFieldKey(String attribute) {
    _fieldKeys.remove(attribute);
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

  bool saveAndValidate() {
    _formKey.currentState.save();
    return _formKey.currentState.validate();
  }

  void reset() {
    // _formKey.currentState.reset();
    _fieldKeys.forEach((mapKey, fieldKey) {
      // print("Reseting $mapKey");
      fieldKey.currentState.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: widget.child,
      autovalidateMode: widget.autovalidateMode,
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

abstract class FormBuilderField<T> extends StatefulWidget {
  /// Unique Attribute Name
  final String attribute;

  /// Whether the field can be changed. Defaults to false.
  final bool readOnly;
  final List<FormFieldValidator<T>> validators;
  final ValueTransformer valueTransformer;

  // Common FormField fields...
  final AutovalidateMode autovalidateMode;

  /// Whether the form is able to receive user input. Defaults to true.
  final bool enabled;
  final T initialValue;
  final FormFieldSetter<T> onSaved;

  FormBuilderField({
    Key key,
    @required this.attribute,
    this.readOnly = false,
    this.autovalidateMode,
    this.enabled = true,
    this.initialValue,
    this.onSaved,
    this.valueTransformer,
    this.validators = const [],
  })  : assert(null != attribute),
        assert(null != readOnly),
        assert(null != enabled),
        super(key: key);

  void _save(FormBuilderState formBuilderState, T newValue) {
    final saveValue =
        null != valueTransformer ? valueTransformer.call(newValue) : newValue;
    formBuilderState?.setAttributeValue(attribute, saveValue);
    onSaved?.call(saveValue);
  }
}

abstract class FormBuilderFieldState<F extends FormBuilderField<T>, T>
    extends State<F> {
  final GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState formState;

  /// Field's Read Only state when either Field or Form is read only.
  bool readOnly;

  T initialValue;

  @override
  void initState() {
    super.initState();
    formState = FormBuilder.of(context);
    formState?.registerFieldKey(widget.attribute, fieldKey);
    readOnly = widget.readOnly || formState?.readOnly == true;
    initialValue = widget.initialValue ??
        ((formState?.initialValue?.containsKey(widget.attribute) ?? false)
            ? formState.initialValue[widget.attribute]
            : null);
  }

  @override
  void dispose() {
    formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  void save(T newValue) => widget._save(formState, newValue);

  String validate(T val) =>
      FormBuilderValidators.validateValidators(val, widget.validators);
}
