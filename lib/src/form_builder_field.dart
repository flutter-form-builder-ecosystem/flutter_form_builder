import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum OptionsOrientation { horizontal, vertical, wrap, auto }

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

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Called to validate the field asynchronously.
  final Future<String?> Function(T? value)? asyncValidator;

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
    super.errorBuilder,
    super.onReset,
    super.forceErrorText,
    required this.name,
    this.valueTransformer,
    this.onChanged,
    this.focusNode,
    this.asyncValidator,
  });

  @override
  FormBuilderFieldState<FormBuilderField<T>, T> createState() =>
      FormBuilderFieldState<FormBuilderField<T>, T>();
}

class FormBuilderFieldState<F extends FormBuilderField<T>, T>
    extends FormFieldState<T> {
  String? _customErrorText;
  String? _asyncErrorText;
  bool _isValidating = false;
  int _asyncValidationCount = 0;
  FormBuilderState? _formBuilderState;
  bool _touched = false;
  bool _dirty = false;

  /// Returns true if the field is currently performing asynchronous validation.
  bool get isValidating => _isValidating;

  /// The focus node that is used to focus this field.
  late FocusNode effectiveFocusNode;

  /// The focus attachment for the [effectiveFocusNode].
  FocusAttachment? focusAttachment;

  @override
  F get widget => super.widget as F;

  /// Returns the parent [FormBuilderState] if it exists.
  FormBuilderState? get formState => _formBuilderState;

  /// Returns the initial value, which may be declared at the field, or by the
  /// parent [FormBuilder.initialValue]. When declared at both levels, the field
  /// initialValue prevails.
  T? get initialValue =>
      widget.initialValue ??
      (_formBuilderState?.initialValue ??
              const <String, dynamic>{})[widget.name]
          as T?;

  dynamic get transformedValue =>
      widget.valueTransformer == null ? value : widget.valueTransformer!(value);

  @override
  /// Returns the current error text,
  /// which may be a validation error, custom error text, or async validation error.
  String? get errorText =>
      super.errorText ?? _customErrorText ?? _asyncErrorText;

  @override
  /// Returns `true` if the field has an error or has a custom/async error text.
  bool get hasError => super.hasError || errorText != null;

  @override
  /// Returns `true` if the field is valid and has no custom/async error text.
  bool get isValid =>
      super.isValid && _customErrorText == null && _asyncErrorText == null;

  /// Returns `true` if the field is valid.
  bool get valueIsValid => super.isValid;

  /// Returns `true` if the field has an error.
  bool get valueHasError => super.hasError;

  /// Returns `true` if the field is enabled and the parent FormBuilder is enabled.
  bool get enabled => widget.enabled && (_formBuilderState?.enabled ?? true);

  /// Returns `true` if the field is read only.
  ///
  /// See [FormBuilder.skipDisabled] for more information.
  bool get readOnly => !(_formBuilderState?.widget.skipDisabled ?? false);

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
      effectiveFocusNode =
          widget.focusNode ?? FocusNode(canRequestFocus: enabled);
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
    if (_customErrorText != null) {
      setState(() => _customErrorText = null);
    }
    if (_asyncErrorText != null) {
      setState(() => _asyncErrorText = null);
    }
    _informFormForFieldChange();
    widget.onChanged?.call(value);
  }

  @override
  /// Reset field value to initial value
  ///
  /// Also reset custom/async error text if exists, and set [isDirty] to `false`.
  void reset() {
    super.reset();
    _asyncValidationCount++;
    setState(() {
      _isValidating = false;
      _asyncErrorText = null;
      _customErrorText = null;
    });
    didChange(initialValue);
    _dirty = false;
  }

  void _handleFocusAndScroll({
    required bool focusOnInvalid,
    required bool autoScrollWhenFocusOnInvalid,
  }) {
    final fields =
        _formBuilderState?.fields ??
        <String, FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>{};

    if (hasError &&
        focusOnInvalid &&
        (formState?.focusOnInvalid ?? true) &&
        enabled &&
        !fields.values.any((e) => e.effectiveFocusNode.hasFocus)) {
      focus();
      if (autoScrollWhenFocusOnInvalid) ensureScrollableVisibility();
    }
  }

  /// Validate field
  ///
  /// **BREAKING CHANGE**:
  /// In previous versions, calling `validate()` would automatically clear any custom errors set via `invalidate()`.
  /// Now, `validate()` does not clear custom errors by default.
  /// If you want to clear the custom error when validating, you must explicitly pass `clearCustomError: true`.
  ///
  /// Clear custom error if [clearCustomError] is `true`.
  /// By default `false`
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
    bool clearCustomError = false,
    bool focusOnInvalid = true,
    bool autoScrollWhenFocusOnInvalid = false,
  }) {
    if (clearCustomError) {
      setState(() => _customErrorText = null);
    }
    final isValid = super.validate() && !hasError;

    if (!isValid) {
      _handleFocusAndScroll(
        focusOnInvalid: focusOnInvalid,
        autoScrollWhenFocusOnInvalid: autoScrollWhenFocusOnInvalid,
      );
    }

    return isValid;
  }

  /// Validate field asynchronously
  Future<bool> validateAsync({
    bool clearCustomError = false,
    bool focusOnInvalid = true,
    bool autoScrollWhenFocusOnInvalid = false,
  }) async {
    if (clearCustomError) {
      setState(() {
        _customErrorText = null;
        _asyncErrorText = null;
      });
    }

    // Run synchronous validation first
    final isSyncValid = super.validate() && _customErrorText == null;
    if (!isSyncValid) {
      _handleFocusAndScroll(
        focusOnInvalid: focusOnInvalid,
        autoScrollWhenFocusOnInvalid: autoScrollWhenFocusOnInvalid,
      );
      return false;
    }

    if (widget.asyncValidator == null) {
      return true;
    }

    final isValid = await _runAsyncValidator(value);

    if (!isValid) {
      _handleFocusAndScroll(
        focusOnInvalid: focusOnInvalid,
        autoScrollWhenFocusOnInvalid: autoScrollWhenFocusOnInvalid,
      );
    }

    return isValid;
  }

  Future<bool> _runAsyncValidator(T? valueCandidate) async {
    final currentValidation = ++_asyncValidationCount;
    setState(() {
      _isValidating = true;
      _asyncErrorText = null;
    });

    try {
      final error = await widget.asyncValidator!(valueCandidate);

      if (currentValidation != _asyncValidationCount) {
        return false;
      }

      setState(() {
        _asyncErrorText = error;
        _isValidating = false;
      });

      return error == null;
    } catch (e) {
      if (currentValidation == _asyncValidationCount) {
        setState(() {
          _asyncErrorText = e.toString();
          _isValidating = false;
        });
      }
      return false;
    }
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

  /// Focus field
  void focus() {
    FocusScope.of(context).requestFocus(effectiveFocusNode);
  }

  /// Scroll to show field
  void ensureScrollableVisibility() {
    Scrollable.ensureVisible(context);
  }
}
