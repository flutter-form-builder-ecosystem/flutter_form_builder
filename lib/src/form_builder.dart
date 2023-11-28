import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// A container for form fields.
class FormBuilder extends StatefulWidget {
  /// Called when one of the form fields changes.
  ///
  /// In addition to this callback being invoked, all the form fields themselves
  /// will rebuild.
  final VoidCallback? onChanged;

  /// {@macro flutter.widgets.navigator.onPopInvoked}
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how to use this parameter to show a confirmation
  /// dialog when a navigation pop would cause form data to be lost.
  ///
  /// ** See code in examples/api/lib/widgets/form/form.1.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [canPop], which also comes from [PopScope] and is often used in
  ///    conjunction with this parameter.
  ///  * [PopScope.onPopInvoked], which is what [Form] delegates to internally.ther widget that provides a way to intercept the
  ///    back button.
  final void Function(bool)? onPopInvoked;

  /// {@macro flutter.widgets.PopScope.canPop}
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how to use this parameter to show a confirmation
  /// dialog when a navigation pop would cause form data to be lost.
  ///
  /// ** See code in examples/api/lib/widgets/form/form.1.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [onPopInvoked], which also comes from [PopScope] and is often used in
  ///    conjunction with this parameter.
  ///  * [PopScope.canPop], which is what [Form] delegates to internally.
  final bool? canPop;

  /// The widget below this widget in the tree.
  ///
  /// This is the root of the widget hierarchy that contains this form.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// Used to enable/disable form fields auto validation and update their error
  /// text.
  ///
  /// {@macro flutter.widgets.form.autovalidateMode}
  final AutovalidateMode? autovalidateMode;

  /// An optional Map of field initialValues. Keys correspond to the field's
  /// name and value to the initialValue of the field.
  ///
  /// The initialValues set here will be ignored if the field has a local
  /// initialValue set.
  final Map<String, dynamic> initialValue;

  /// Whether the form should ignore submitting values from fields where
  /// `enabled` is `false`.
  ///
  /// This behavior is common in HTML forms where _readonly_ values are not
  /// submitted when the form is submitted.
  ///
  /// `true` = Disabled / `false` = Read only
  ///
  /// When `true`, the final form value will not contain disabled fields.
  /// Default is `false`.
  final bool skipDisabled;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true.
  ///
  /// When `false` all the form fields will be disabled - won't accept input -
  /// and their enabled state will be ignored.
  final bool enabled;

  /// Whether to clear the internal value of a field when it is unregistered.
  ///
  /// Defaults to `false`.
  ///
  /// When set to `true`, the form builder will not keep the internal values
  /// from disposed [FormBuilderField]s. This is useful for dynamic forms where
  /// fields are registered and unregistered due to state change.
  ///
  /// This setting will have no effect when registering a field with the same
  /// name as the unregistered one.
  final bool clearValueOnUnregister;

  /// Creates a container for form fields.
  ///
  /// The [child] argument must not be null.
  const FormBuilder({
    super.key,
    required this.child,
    this.onChanged,
    this.autovalidateMode,
    this.onPopInvoked,
    this.initialValue = const <String, dynamic>{},
    this.skipDisabled = false,
    this.enabled = true,
    this.clearValueOnUnregister = false,
    this.canPop,
  });

  static FormBuilderState? of(BuildContext context) =>
      context.findAncestorStateOfType<FormBuilderState>();

  @override
  FormBuilderState createState() => FormBuilderState();
}

/// A type alias for a map of form fields.
typedef FormBuilderFields
    = Map<String, FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>;

class FormBuilderState extends State<FormBuilder> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FormBuilderFields _fields = {};
  final Map<String, dynamic> _instantValue = {};
  final Map<String, dynamic> _savedValue = {};
  // Because dart type system will not accept ValueTransformer<dynamic>
  final Map<String, Function> _transformers = {};
  bool _focusOnInvalid = true;

  /// Will be true if will focus on invalid field when validate
  ///
  /// Only used to internal logic
  bool get focusOnInvalid => _focusOnInvalid;

  bool get enabled => widget.enabled;

  /// Verify if all fields on form are valid.
  bool get isValid => fields.values.every((field) => field.isValid);

  /// Will be true if some field on form are dirty.
  ///
  /// Dirty: The value of field is changed by user or by logic code.
  bool get isDirty => fields.values.any((field) => field.isDirty);

  /// Will be true if some field on form are touched.
  ///
  /// Touched: The field is focused by user or by logic code.
  bool get isTouched => fields.values.any((field) => field.isTouched);

  /// Get a map of errors
  Map<String, String> get errors => {
        for (var element
            in fields.entries.where((element) => element.value.hasError))
          element.key.toString(): element.value.errorText ?? ''
      };

  /// Get initialValue.
  Map<String, dynamic> get initialValue => widget.initialValue;

  /// Get all fields of form.
  FormBuilderFields get fields => _fields;

  Map<String, dynamic> get instantValue =>
      Map<String, dynamic>.unmodifiable(_instantValue.map((key, value) =>
          MapEntry(key, _transformers[key]?.call(value) ?? value)));

  /// Returns the saved value only
  Map<String, dynamic> get value =>
      Map<String, dynamic>.unmodifiable(_savedValue.map((key, value) =>
          MapEntry(key, _transformers[key]?.call(value) ?? value)));

  dynamic transformValue<T>(String name, T? v) {
    final t = _transformers[name];
    return t != null ? t.call(v) : v;
  }

  dynamic getTransformedValue<T>(String name, {bool fromSaved = false}) {
    return transformValue<T>(name, getRawValue(name));
  }

  T? getRawValue<T>(String name, {bool fromSaved = false}) {
    return (fromSaved ? _savedValue[name] : _instantValue[name]) ??
        initialValue[name];
  }

  void setInternalFieldValue<T>(String name, T? value) {
    _instantValue[name] = value;
    widget.onChanged?.call();
  }

  void removeInternalFieldValue(String name) {
    _instantValue.remove(name);
  }

  void registerField(String name, FormBuilderFieldState field) {
    // Each field must have a unique name.  Ideally we could simply:
    //   assert(!_fields.containsKey(name));
    // However, Flutter will delay dispose of deactivated fields, so if a
    // field is being replaced, the new instance is registered before the old
    // one is unregistered.  To accommodate that use case, but also provide
    // assistance to accidental duplicate names, we check and emit a warning.
    final oldField = _fields[name];
    assert(() {
      if (oldField != null) {
        debugPrint('Warning! Replacing duplicate Field for $name'
            ' -- this is OK to ignore as long as the field was intentionally replaced');
      }
      return true;
    }());

    _fields[name] = field;
    field.registerTransformer(_transformers);

    field.setValue(
      oldField?.value ?? (_instantValue[name] ??= field.initialValue),
      populateForm: false,
    );
  }

  void unregisterField(String name, FormBuilderFieldState field) {
    assert(_fields.containsKey(name));
    // Only remove the field when it is the one registered.  It's possible that
    // the field is replaced (registerField is called twice for a given name)
    // before unregisterField is called for the name, so just emit a warning
    // since it may be intentional.
    if (field == _fields[name]) {
      _fields.remove(name);
      _transformers.remove(name);
      if (widget.clearValueOnUnregister) {
        _instantValue.remove(name);
        _savedValue.remove(name);
      }
    } else {
      assert(() {
        // This is OK to ignore when you are intentionally replacing a field
        // with another field using the same name.
        debugPrint('Warning! Ignoring Field unregistration for $name'
            ' -- this is OK to ignore as long as the field was intentionally replaced');
        return true;
      }());
    }
  }

  void save() {
    _formKey.currentState!.save();
    // Copy values from instant to saved
    _savedValue.clear();
    _savedValue.addAll(_instantValue);
  }

  @Deprecated(
      'Will be remove to avoid redundancy. Use fields[name]?.invalidate(errorText) instead')
  void invalidateField({required String name, String? errorText}) =>
      fields[name]?.invalidate(errorText ?? '');

  @Deprecated(
      'Will be remove to avoid redundancy. Use fields.first.invalidate(errorText) instead')
  void invalidateFirstField({required String errorText}) =>
      fields.values.first.invalidate(errorText);

  /// Validate all fields of form
  ///
  /// Focus to first invalid field when has field invalid, if [focusOnInvalid] is `true`.
  /// By default `true`
  ///
  /// Auto scroll to first invalid field focused if [autoScrollWhenFocusOnInvalid] is `true`.
  /// By default `false`.
  ///
  /// Note: If a invalid field is from type **TextField** and will focused,
  /// the form will auto scroll to show this invalid field.
  /// In this case, the automatic scroll happens because is a behavior inside the framework,
  /// not because [autoScrollWhenFocusOnInvalid] is `true`.
  bool validate({
    bool focusOnInvalid = true,
    bool autoScrollWhenFocusOnInvalid = false,
  }) {
    _focusOnInvalid = focusOnInvalid;
    final hasError = !_formKey.currentState!.validate();
    if (hasError) {
      final wrongFields =
          fields.values.where((element) => element.hasError).toList();
      if (wrongFields.isNotEmpty) {
        if (focusOnInvalid) {
          wrongFields.first.focus();
        }
        if (autoScrollWhenFocusOnInvalid) {
          wrongFields.first.ensureScrollableVisibility();
        }
      }
    }
    return !hasError;
  }

  /// Save form values and validate all fields of form
  ///
  /// Focus to first invalid field when has field invalid, if [focusOnInvalid] is `true`.
  /// By default `true`
  ///
  /// Auto scroll to first invalid field focused if [autoScrollWhenFocusOnInvalid] is `true`.
  /// By default `false`.
  ///
  /// Note: If a invalid field is from type **TextField** and will focused,
  /// the form will auto scroll to show this invalid field.
  /// In this case, the automatic scroll happens because is a behavior inside the framework,
  /// not because [autoScrollWhenFocusOnInvalid] is `true`.
  bool saveAndValidate({
    bool focusOnInvalid = true,
    bool autoScrollWhenFocusOnInvalid = false,
  }) {
    save();
    return validate(
      focusOnInvalid: focusOnInvalid,
      autoScrollWhenFocusOnInvalid: autoScrollWhenFocusOnInvalid,
    );
  }

  /// Reset form to `initialValue`
  void reset() {
    _formKey.currentState?.reset();
  }

  /// Update fields values of form.
  /// Useful when need update all values at once, after init.
  ///
  /// To load all values at once on init, use `initialValue` property
  void patchValue(Map<String, dynamic> val) {
    val.forEach((key, dynamic value) {
      _fields[key]?.didChange(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: widget.autovalidateMode,
      onPopInvoked: widget.onPopInvoked,
      canPop: widget.canPop,
      // `onChanged` is called during setInternalFieldValue else will be called early
      child: _FormBuilderScope(
        formState: this,
        child: FocusTraversalGroup(
          policy: WidgetOrderTraversalPolicy(),
          child: widget.child,
        ),
      ),
    );
  }
}

class _FormBuilderScope extends InheritedWidget {
  const _FormBuilderScope({
    required super.child,
    required FormBuilderState formState,
  }) : _formState = formState;

  final FormBuilderState _formState;

  /// The [Form] associated with this widget.
  FormBuilder get form => _formState.widget;

  @override
  bool updateShouldNotify(_FormBuilderScope oldWidget) =>
      oldWidget._formState != _formState;
}
