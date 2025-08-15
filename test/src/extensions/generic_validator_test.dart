import 'package:flutter_form_builder/src/extensions/generic_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenericValidator -', () {
    test('when type is String and value is empty then return true', () {
      final String value = '';
      final result = value.emptyValidator();
      expect(result, isTrue);
    });
    test('when type is String and value is not empty then return false', () {
      final String value = 'not empty';
      final result = value.emptyValidator();
      expect(result, isFalse);
    });
    test('when type is List and value is empty then return true', () {
      final List<int> value = [];
      final result = value.emptyValidator();
      expect(result, isTrue);
    });
    test('when type is List and value is not empty then return false', () {
      final List<int> value = [1, 2, 3];
      final result = value.emptyValidator();
      expect(result, isFalse);
    });
    test('when type is Map and value is empty then return true', () {
      final Map<String, int> value = {};
      final result = value.emptyValidator();
      expect(result, isTrue);
    });
    test('when type is Map and value is not empty then return false', () {
      final Map<String, int> value = {'key': 1};
      final result = value.emptyValidator();
      expect(result, isFalse);
    });
    test('when type is Set and value is empty then return true', () {
      final Set<int> value = {};
      final result = value.emptyValidator();
      expect(result, isTrue);
    });
    test('when type is Set and value is not empty then return false', () {
      final Set<int> value = {1, 2, 3};
      final result = value.emptyValidator();
      expect(result, isFalse);
    });
    test('when type is Iterable and value is empty then return true', () {
      final Iterable<int> value = [];
      final result = value.emptyValidator();
      expect(result, isTrue);
    });
    test('when type is Iterable and value is not empty then return false', () {
      final Iterable<int> value = [1, 2, 3];
      final result = value.emptyValidator();
      expect(result, isFalse);
    });
    test('when type is not and empty possible then return false', () {
      final int value = 1;
      final result = value.emptyValidator();
      expect(result, isFalse);
    });
    test('when value is null then return true', () {
      final String? value = null;
      final result = value.emptyValidator();
      expect(result, isTrue);
    });
  });
}
