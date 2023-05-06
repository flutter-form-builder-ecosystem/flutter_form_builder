import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// An option for filter chips.
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class FormBuilderChipOption<T> extends FormBuilderFieldOption<T> {
  final Widget? avatar;

  /// Creates an option for fields with selection options
  const FormBuilderChipOption({
    super.key,
    required super.value,
    this.avatar,
    super.child,
  });

  @override
  Widget build(BuildContext context) {
    return child ?? Text(value.toString());
  }
}
