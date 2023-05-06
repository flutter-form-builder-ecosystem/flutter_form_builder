import 'package:flutter/widgets.dart';

/// An option for fields with selection options.
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class FormBuilderFieldOption<T> extends StatelessWidget {
  final Widget? child;
  final T value;

  /// Creates an option for fields with selection options
  const FormBuilderFieldOption({
    super.key,
    required this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child ?? Text(value.toString());
  }
}
