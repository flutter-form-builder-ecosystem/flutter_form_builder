import 'package:flutter/material.dart';

class FormBuilderFieldOption extends StatelessWidget {
  final Widget child;
  final dynamic value;

  FormBuilderFieldOption({
    Key key,
    @required this.value,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return child;
    } else {
      return Text("${value.toString()}");
    }
  }
}
