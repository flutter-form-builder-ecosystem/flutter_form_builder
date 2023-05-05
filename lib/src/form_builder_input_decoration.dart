import 'package:flutter/material.dart';

mixin FormBuilderInputDecoration {
  final InputDecoration decoration = const InputDecoration();

  InputDecoration get getdecoration => decoration.copyWith();

  bool get hasDecorationError => decoration.errorText != null;
}
