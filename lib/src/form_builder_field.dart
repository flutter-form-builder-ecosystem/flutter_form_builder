import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/extensions/autovalidatemode_extension.dart';

enum OptionsOrientation { horizontal, vertical, wrap }

enum ControlAffinity { leading, trailing }

typedef ValueTransformer<T> = dynamic Function(T value);

/// A single form field.
///
/// This widget maintains the current state of the form field, so that updates
/// and validation errors are visually reflected in the UI.
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
  final ValueTransformer<T?>? valueTransformer;

  /// Called when the field value is changed.
  final ValueChanged<T?>? onChanged;

  /// Called when the field value is reset.
  final VoidCallback? onReset;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Creates a single form field.
  const FormBuilderField({
    super.key,
    super.onSaved,
    super.initialValue,
    super.autovalidateMode,
    super.enabled = true,
    super.validator,
    super.restorationId,
    required super.builder,
    required this.name,
    this.valueTransformer,
    this.onChanged,
    this.onReset,
    this.focusNode,
  });

  @override
  FormBuilderFieldState<FormBuilderField<T>, T> createState() =>
      FormBuilderFieldState<FormBuilderField<T>, T>();
}

class FormBuilderFieldState<F extends FormBuilderField<T>, T>
    extends FormFieldState<T> {
  String? _customErrorText;
  FormBuilderState? _formBuilderState;
  bool _touched = false;
  bool _dirty = false;
  late FocusNode effectiveFocusNode;
  FocusAttachment? focusAttachment;

  @override
  F get widget => super.widget as F;

  FormBuilderState? get formState => _formBuilderState;

  /// Returns the initial value, which may be declared at the field, or by the
  /// parent [FormBuilder.initialValue]. When declared at both levels, the field
  /// initialValue prevails.
  T? get initialValue =>
      widget.initialValue ??
      (_formBuilderState?.initialValue ??
          const <String, dynamic>{})[widget.name] as T?;

  dynamic get transformedValue => widget.valueTransformer?.call(value) ?? value;

  @override
  String? get errorText => super.errorText ?? _customErrorText;

  @override
  bool get hasError => super.hasError || errorText != null;

  @override
  bool get isValid => super.isValid && errorText == null;

  bool get valueIsValid => super.isValid;
  bool get valueHasError => super.hasError;

  bool get enabled => widget.enabled && (_formBuilderState?.enabled ?? true);
  bool get readOnly => !(_formBuilderState?.widget.skipDisabled ?? false);
  bool get _isAlwaysValidate =>
      widget.autovalidateMode.isAlways ||
      (_formBuilderState?.widget.autovalidateMode?.isAlways ?? false);

  /// Will be true if the field is dirty
  ///
  /// The value of field is changed by user or by logic code.
  bool get isDirty => _dirty;

  /// Will be true if the field is touched
  ///
  /// The field is focused by user or by logic code
  bool get isTouched => _touched;

  void registerTransformer(Map<String, Function> map) {
    final fun = widget.valueTransformer;
    if (fun != null) {
      map[widget.name] = fun;
    }
  }

  @override
  void initState() {
    super.initState();
    // Register this field when there is a parent FormBuilder
    _formBuilderState = FormBuilder.of(context);
    // Set the initial value
    _formBuilderState?.registerField(widget.name, this);

    effectiveFocusNode = widget.focusNode ?? FocusNode(debugLabel: widget.name);
    // Register a touch handler
    effectiveFocusNode.addListener(_touchedHandler);
    focusAttachment = effectiveFocusNode.attach(context);

    // Verify if need auto validate form
    if ((enabled || readOnly) && _isAlwaysValidate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validate();
      });
    }
  }

  @override
  void didUpdateWidget(covariant FormBuilderField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.name != oldWidget.name) {
      _formBuilderState?.unregisterField(oldWidget.name, this);
      _formBuilderState?.registerField(widget.name, this);
    }
    if (widget.focusNode != oldWidget.focusNode) {
      focusAttachment?.detach();
      effectiveFocusNode.removeListener(_touchedHandler);
      effectiveFocusNode = widget.focusNode ?? FocusNode();
      effectiveFocusNode.addListener(_touchedHandler);
      focusAttachment = effectiveFocusNode.attach(context);
    }
  }

  @override
  void dispose() {
    effectiveFocusNode.removeListener(_touchedHandler);
    // Checking if the focusNode is handled by the parent or not
    if (widget.focusNode == null) {
      effectiveFocusNode.dispose();
    }
    _formBuilderState?.unregisterField(widget.name, this);
    super.dispose();
  }

  void _informFormForFieldChange() {
    if (_formBuilderState != null) {
      _dirty = true;
      if (enabled || readOnly) {
        _formBuilderState!.setInternalFieldValue<T>(widget.name, value);
        return;
      }
      _formBuilderState!.removeInternalFieldValue(widget.name);
    }
  }

  void _touchedHandler() {
    if (effectiveFocusNode.hasFocus && _touched == false) {
      setState(() => _touched = true);
    }
  }

  @override
  void setValue(T? value, {bool populateForm = true}) {
    super.setValue(value);
    if (populateForm) {
      _informFormForFieldChange();
    }
  }

  @override
  void didChange(T? value) {
    super.didChange(value);
    _informFormForFieldChange();
    widget.onChanged?.call(value);
  }

  @override
  void reset() {
    super.reset();
    didChange(initialValue);
    _dirty = false;
    if (_customErrorText != null) {
      setState(() => _customErrorText = null);
    }
    widget.onReset?.call();
  }

  /// Validate field
  ///
  /// Clear custom error if [clearCustomError] is `true`.
  /// By default `true`
  ///
  /// Focus when field is invalid if [focusOnInvalid] is `true`.
  /// By default `true`
  ///
  /// Auto scroll when focus invalid if [autoScrollWhenFocusOnInvalid] is `true`.
  /// By default `false`.
  ///
  /// Note: If a invalid field is from type **TextField** and will focused,
  /// the form will auto scroll to show this invalid field.
  /// In this case, the automatic scroll happens because is a behavior inside the framework,
  /// not because [autoScrollWhenFocusOnInvalid] is `true`.
  @override
  bool validate({
    bool clearCustomError = true,
    bool focusOnInvalid = true,
    bool autoScrollWhenFocusOnInvalid = false,
  }) {
    if (clearCustomError) {
      setState(() => _customErrorText = null);
    }
    final isValid = super.validate() && !hasError;

    final fields = _formBuilderState?.fields ??
        <String, FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>{};

    if (!isValid &&
        focusOnInvalid &&
        (formState?.focusOnInvalid ?? true) &&
        enabled &&
        !fields.values.any((e) => e.effectiveFocusNode.hasFocus)) {
      focus();
      if (autoScrollWhenFocusOnInvalid) ensureScrollableVisibility();
    }

    return isValid;
  }

  /// Invalidate field with a [errorText]
  ///
  /// Focus field if [shouldFocus] is `true`.
  /// By default `true`
  ///
  /// Auto scroll when focus invalid if [shouldAutoScrollWhenFocus] is `true`.
  /// By default `false`.
  ///
  /// Note: If a invalid field is from type **TextField** and will focused,
  /// the form will auto scroll to show this invalid field.
  /// In this case, the automatic scroll happens because is a behavior inside the framework,
  /// not because [shouldAutoScrollWhenFocus] is `true`.
  void invalidate(
    String errorText, {
    bool shouldFocus = true,
    bool shouldAutoScrollWhenFocus = false,
  }) {
    setState(() => _customErrorText = errorText);

    validate(
      clearCustomError: false,
      autoScrollWhenFocusOnInvalid: shouldAutoScrollWhenFocus,
      focusOnInvalid: shouldFocus,
    );
  }

  void focus() {
    FocusScope.of(context).requestFocus(effectiveFocusNode);
  }

  void ensureScrollableVisibility() {
    Scrollable.ensureVisible(context);
  }
}
