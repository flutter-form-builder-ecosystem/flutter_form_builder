import 'package:flutter/material.dart';

class FormBuilderFieldOption<T> extends StatelessWidget {
  final Widget child;
  final T value;

  const FormBuilderFieldOption({
    Key key,
    @required this.value,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child ?? Text(value.toString());
  }
}
