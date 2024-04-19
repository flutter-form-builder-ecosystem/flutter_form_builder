import 'package:flutter/material.dart';
import 'package:flutter_form_builder/src/form_builder_field_option.dart';



class InfoModalConfig {
  final Widget leadingIcon;
  final Widget description;
  final ShapeBorder shape;
  final Gradient? gradient;

  const InfoModalConfig({
    required this.leadingIcon,
    required this.description,
    required this.shape,
    this.gradient,
  });
}


class SelectionCardOption<T> extends FormBuilderFieldOption<T> {
  final Widget? avatar;

  final InfoModalConfig? infoModalConfig;


  /// Creates an option for fields with selection options
  const SelectionCardOption({
    super.key,
    required super.value,
    this.avatar,
    this.infoModalConfig,
    super.child,
  });

  @override
  Widget build(BuildContext context) {
    return child ?? Text(value.toString());
  }
}
