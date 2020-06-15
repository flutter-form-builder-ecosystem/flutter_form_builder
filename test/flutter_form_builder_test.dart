import 'package:test/test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  test('FormBuilderValidators.required', () {
    expect(FormBuilderValidators.required()('something long'), isNull);
    expect(FormBuilderValidators.required()(DateTime.now()), isNull);
    expect(FormBuilderValidators.required()(''), isNotNull);
    expect(FormBuilderValidators.required()([]), isNotNull);
    // expect(FormBuilderValidators.maxLength(5)(5), equals(null));
  });

  test('FormBuilderValidators.maxLength', () {
    expect(FormBuilderValidators.maxLength(5)('something long'), equals('Value must have a length less than or equal to 5'));
    expect(FormBuilderValidators.maxLength(5)('two'), equals(null));
    // expect(FormBuilderValidators.maxLength(5)(5), equals(null));
  });

  test('FormBuilderValidators.email', () {
    expect(FormBuilderValidators.email()('john@flutter'), isNotNull);
    expect(FormBuilderValidators.email()('john@flutter.dev'), isNull);
    expect(FormBuilderValidators.email()(' john@flutter.dev '), isNull);
    expect(FormBuilderValidators.email()('john@flutter.dev '), isNull);
    expect(FormBuilderValidators.email()(' john@flutter.dev'), isNull);
    expect(FormBuilderValidators.email()(null), isNull);
    expect(FormBuilderValidators.email()(''),isNull);
  });

  test('FormBuilderValidators.max', () {
    expect(FormBuilderValidators.max(20)('70'), isNotNull);
    expect(FormBuilderValidators.max(30)(70), isNotNull);
    expect(FormBuilderValidators.max(30)(20), isNull);
  });

  test('FormBuilderValidators.min', () {
    expect(FormBuilderValidators.min(30)('10'), isNotNull);
    expect(FormBuilderValidators.min(30)(10), isNotNull);
    expect(FormBuilderValidators.min(30)(70), isNull);
  });

  test('FormBuilderValidators.url', () {
    expect(FormBuilderValidators.url()(null), isNull);
    expect(FormBuilderValidators.url()('https://www.google.com'), isNull);
    expect(FormBuilderValidators.url()('www.google.com'), isNull);
    expect(FormBuilderValidators.url()('google.com'), isNull);
    expect(FormBuilderValidators.url()('http://google.com'), isNull);
    expect(FormBuilderValidators.url()('.com'), isNotNull);
    expect(FormBuilderValidators.url(protocols: ['https', 'http'], errorText: 'Only HTTP and HTTPS allowed')('ftp://www.google.com'), isNotNull);
  });

  test('FormBuilderValidators.IP', () {
    expect(FormBuilderValidators.IP()(null), isNull);
    expect(FormBuilderValidators.IP()('192.168.0.1'), isNull);
    expect(FormBuilderValidators.IP()('256.168.0.1'), isNotNull);
  });
}
