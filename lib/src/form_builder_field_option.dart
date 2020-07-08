import 'package:flutter/material.dart';

class FormBuilderFieldOption extends StatelessWidget {
  @Deprecated('Use `child` instead. Will be removed in the next major version.')
  final String label;
  final Widget child;
  final dynamic value;

  const FormBuilderFieldOption({
    Key key,
    @Deprecated('Use `child` instead. Will be removed in the next major version.')
        // ignore: deprecated_member_use_from_same_package
        this.label,
    @required
        this.value,
    this.child,
  })  :
        // ignore: deprecated_member_use_from_same_package
        assert(label == null || child == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use_from_same_package
    return child ?? Text(label ?? value.toString());
  }
}
