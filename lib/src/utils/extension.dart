import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension FormKey on GlobalKey<FormBuilderState> {
  void invalidateField({required String name, String? errorText}) =>
      currentState?.fields[name]?.invalidate(errorText ?? '');

  void invalidateFirstField({required String errorText}) =>
      currentState?.fields.values.first.invalidate(errorText);
}
