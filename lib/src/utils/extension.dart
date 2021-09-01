import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension FormKey on GlobalKey<FormBuilderState> {
  void invalidateField({
    required String name,
    String? reason,
  }) =>
      currentState?.fields[name]?.invalidateField(reason ?? '');

  void invalidateFirstField({required String reason}) =>
      currentState?.fields.values.first.invalidateField(reason);
}