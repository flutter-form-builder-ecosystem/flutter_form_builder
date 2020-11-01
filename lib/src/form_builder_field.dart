import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum OptionsOrientation { horizontal, vertical, wrap }
enum ControlAffinity { leading, trailing }

class FormBuilderField<T> extends FormField<T> {
  /// Used to reference the field within the form, or to reference form data
  /// after the form is submitted.
  final String name;

  /// Called just before field value is saved. Used to massage data just before
  /// committing the value.
  ///
  /// This sample shows how to convert age in a [FormBuilderTextField] to number
  /// so that the final value is numeric instead of a String
  ///
  /// ```dart
  ///   FormBuilderTextField(
  ///     name: 'age',
  ///     decoration: InputDecoration(labelText: 'Age'),
  ///     valueTransformer: (text) => num.tryParse(text),
  ///     validator: FormBuilderValidators.numeric(context),
  ///     initialValue: '18',
  ///     keyboardType: TextInputType.number,
  ///  ),
  /// ```
  final ValueTransformer valueTransformer;

  /// Called when the field value is changed.
  final ValueChanged<T> onChanged;

  /// Whether the field value can be changed. Defaults to false
  final bool readOnly;

  /// The border, labels, icons, and styles used to decorate the field.
  final InputDecoration decoration;

  /// Called when the field value is reset.
  final VoidCallback onReset;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode focusNode;

  //TODO: implement bool autofocus, ValueChanged<bool> onValidated

  FormBuilderField({
    Key key,
    //From Super
    FormFieldSetter<T> onSaved,
    T initialValue,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    bool enabled = true,
    FormFieldValidator validator,
    @required FormFieldBuilder<T> builder,
    @required this.name,
    this.valueTransformer,
    this.onChanged,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.onReset,
    this.focusNode,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          builder: builder,
          validator: validator,
        );

  @override
  FormBuilderFieldState<T> createState() => FormBuilderFieldState();
}

class FormBuilderFieldState<T> extends FormFieldState<T> with AfterInitMixin {
  @override
  FormBuilderField<T> get widget => super.widget;

  FormBuilderState get formState => _formBuilderState;

  bool get readOnly => _formBuilderState?.readOnly == true || widget.readOnly;

  T get initialValue =>
      widget.initialValue ??
      ((_formBuilderState?.initialValue?.containsKey(widget.name) ?? false)
          ? _formBuilderState.initialValue[widget.name]
          : null);

  FormBuilderState _formBuilderState;

  @override
  bool get hasError => super.hasError || widget.decoration?.errorText != null;

  @override
  bool get isValid => super.isValid && widget.decoration?.errorText == null;

  bool _touched = false;

  FocusNode _focusNode;

  FocusNode get effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void didInitState() {
    _formBuilderState = FormBuilder.of(context);
    _formBuilderState?.registerField(widget.name, this);
    effectiveFocusNode.addListener(setTouchedHandler);
    setValue(initialValue);
  }

  @override
  void save() {
    super.save();
    if (!_formBuilderState.widget.skipReadOnly ||
        (_formBuilderState.widget.skipReadOnly && !readOnly)) {
      _formBuilderState?.setInternalFieldValue(
          widget.name, widget.valueTransformer?.call(value) ?? value);
    } else {
      _formBuilderState?.removeInternalFieldValue(widget.name);
    }
  }

  void setTouchedHandler() {
    if (effectiveFocusNode.hasFocus && _touched == false) {
      setState(() => _touched = true);
      print('${widget.name} touched');
    }
  }

  @override
  void didChange(T val) {
    super.didChange(val);
    widget.onChanged?.call(value);
  }

  @override
  void reset() {
    super.reset();
    setValue(initialValue);
    widget.onReset?.call();
  }

  @override
  bool validate() {
    return super.validate() && widget.decoration?.errorText == null;
  }

  void requestFocus() {
    FocusScope.of(context).requestFocus(effectiveFocusNode);
  }

  @override
  void dispose() {
    effectiveFocusNode.removeListener(setTouchedHandler);
    _formBuilderState?.unregisterField(widget.name);
    // The attachment will automatically be detached in dispose().
    _focusNode?.dispose();
    super.dispose();
  }

  void patchValue(T value) {
    didChange(value);
  }
}
