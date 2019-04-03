import 'package:test/test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  test('FormBuilderValidators.maxLength', () {
    expect(FormBuilderValidators.maxLength(5)("something long"), equals("Value must have a length less than or equal to 5"));
    expect(FormBuilderValidators.maxLength(5)("two"), equals(null));
    // expect(FormBuilderValidators.maxLength(5)(5), equals(null));
  });

  test('FormBuilderValidators.email', () {
    expect(FormBuilderValidators.email()("john@flutter"), equals("This field requires a valid email address."));
    expect(FormBuilderValidators.email()("john@flutter.dev"), equals(null));
    expect(FormBuilderValidators.email()(null), equals(null));
    expect(FormBuilderValidators.email()(""), equals(null));
  });

  test('FormBuilderValidators.max', () {
    expect(FormBuilderValidators.max(20)("70"), equals("Value must be less than or equal to 20"));
    expect(FormBuilderValidators.max(30)(70), equals("Value must be less than or equal to 30"));
  });
}
