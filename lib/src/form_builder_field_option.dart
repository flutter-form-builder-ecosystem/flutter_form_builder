import 'package:flutter/material.dart';

class FormBuilderFieldOption extends StatelessWidget {
  @Deprecated("Use `child` instead. Will be removed in the next major version.")
  final String label;
  final Widget child;
  final dynamic value;

  FormBuilderFieldOption({
    Key key,
    this.label,
    @required this.value,
    this.child,
  })  : assert(label == null || child == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return child;
    } else {
      // ignore: deprecated_member_use_from_same_package
      return Text("${label ?? value.toString()}");
    }
  }
}
