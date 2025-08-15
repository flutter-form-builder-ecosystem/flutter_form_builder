import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/src/extensions/autovalidatemode_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AutoValidateModeExtension', () {
    test('when mode is always then return true', () {
      final mode = AutovalidateMode.always;
      final result = mode.isAlways;
      expect(result, isTrue);
    });
    test('when mode is onUserInteraction then return true', () {
      final mode = AutovalidateMode.onUserInteraction;
      final result = mode.isOnUserInteraction;
      expect(result, isTrue);
    });
    test('when mode is disabled then return false', () {
      final mode = AutovalidateMode.disabled;
      final result = mode.isEnable;
      expect(result, isFalse);
    });
    test('when mode is always then isEnable should return true', () {
      final mode = AutovalidateMode.always;
      final result = mode.isEnable;
      expect(result, isTrue);
    });
    test('when mode is onUserInteraction then isEnable should return true', () {
      final mode = AutovalidateMode.onUserInteraction;
      final result = mode.isEnable;
      expect(result, isTrue);
    });
  });
}
