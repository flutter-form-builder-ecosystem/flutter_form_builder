import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/src/utils/validators.dart';

/// For creation of [FormFieldValidator]s.
class FormBuilderValidators {
  /// [FormFieldValidator] that is composed of other [FormFieldValidator]s.
  /// Each validator is run against the [FormField] value and if any returns a
  /// non-null result validation fails, otherwise, validation passes
  static FormFieldValidator<T> compose<T>(
      List<FormFieldValidator<T>> validators) {
    return (valueCandidate) {
      for (var validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field have a non-empty value.
  static FormFieldValidator<T> required<T>(
    BuildContext context, {
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate == null ||
          (valueCandidate is String && valueCandidate.trim().isEmpty) ||
          (valueCandidate is Iterable && valueCandidate.isEmpty) ||
          (valueCandidate is Map && valueCandidate.isEmpty)) {
        return errorText ??
            FormBuilderLocalizations.of(context).requiredErrorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value be equal to the
  /// provided value.
  static FormFieldValidator<T> equal<T>(
    BuildContext context,
    Object value, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate != value
          ? errorText ??
              FormBuilderLocalizations.of(context).equalErrorText(value)
          : null;

  /// [FormFieldValidator] that requires the field's value be not equal to
  /// the provided value.
  static FormFieldValidator<T> notEqual<T>(
    BuildContext context,
    Object value, {
    String? errorText,
  }) =>
      (valueCandidate) => valueCandidate == value
          ? errorText ??
              FormBuilderLocalizations.of(context).notEqualErrorText(value)
          : null;

  /// [FormFieldValidator] that requires the field's value to be greater than
  /// (or equal) to the provided number.
  static FormFieldValidator<T> min<T>(
    BuildContext context,
    num min, {
    bool inclusive = true,
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate != null) {
        assert(valueCandidate is num || valueCandidate is String);
        final number = valueCandidate is num
            ? valueCandidate
            : num.tryParse(valueCandidate.toString());

        if (number != null && (inclusive ? number < min : number <= min)) {
          return errorText ??
              FormBuilderLocalizations.of(context).minErrorText(min);
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be less than
  /// (or equal) to the provided number.
  static FormFieldValidator<T> max<T>(
    BuildContext context,
    num max, {
    bool inclusive = true,
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate != null) {
        assert(valueCandidate is num || valueCandidate is String);
        final number = valueCandidate is num
            ? valueCandidate
            : num.tryParse(valueCandidate.toString());

        if (number != null && (inclusive ? number > max : number >= max)) {
          return errorText ??
              FormBuilderLocalizations.of(context).maxErrorText(max);
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// greater than or equal to the provided minimum length.
  static FormFieldValidator<T> minLength<T>(
    BuildContext context,
    int minLength, {
    bool allowEmpty = false,
    String? errorText,
  }) {
    assert(minLength > 0);
    return (T? valueCandidate) {
      assert(valueCandidate is String ||
          valueCandidate is Iterable ||
          valueCandidate == null);
      var valueLength = 0;
      if (valueCandidate is String) valueLength = valueCandidate.length;
      if (valueCandidate is Iterable) valueLength = valueCandidate.length;
      return valueLength < minLength && (!allowEmpty || valueLength > 0)
          ? errorText ??
              FormBuilderLocalizations.of(context).minLengthErrorText(minLength)
          : null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// less than or equal to the provided maximum length.
  static FormFieldValidator<T> maxLength<T>(
    BuildContext context,
    int maxLength, {
    String? errorText,
  }) {
    assert(maxLength > 0);
    return (T? valueCandidate) {
      assert(valueCandidate is String ||
          valueCandidate is Iterable ||
          valueCandidate == null);
      var valueLength = 0;
      if (valueCandidate is String) valueLength = valueCandidate.length;
      if (valueCandidate is Iterable) valueLength = valueCandidate.length;
      return null != valueCandidate && valueLength > maxLength
          ? errorText ??
              FormBuilderLocalizations.of(context).maxLengthErrorText(maxLength)
          : null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid email address.
  static FormFieldValidator<String> email(
    BuildContext context, {
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isEmail(valueCandidate!.trim())
              ? errorText ?? FormBuilderLocalizations.of(context).emailErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid url.
  static FormFieldValidator<String> url(
    BuildContext context, {
    String? errorText,
    List<String> protocols = const ['http', 'https', 'ftp'],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscore = false,
    List<String> hostWhitelist = const [],
    List<String> hostBlacklist = const [],
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !isURL(valueCandidate!,
                  protocols: protocols,
                  requireTld: requireTld,
                  requireProtocol: requireProtocol,
                  allowUnderscore: allowUnderscore,
                  hostWhitelist: hostWhitelist,
                  hostBlacklist: hostBlacklist)
          ? errorText ?? FormBuilderLocalizations.of(context).urlErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to match the provided regex pattern.
  static FormFieldValidator<String> match(
    BuildContext context,
    String pattern, {
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              !RegExp(pattern).hasMatch(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.of(context).matchErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  static FormFieldValidator<String> numeric(
    BuildContext context, {
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              null == num.tryParse(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.of(context).numericErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid integer.
  static FormFieldValidator<String> integer(
    BuildContext context, {
    String? errorText,
    int? radix,
  }) =>
      (valueCandidate) => true == valueCandidate?.isNotEmpty &&
              null == int.tryParse(valueCandidate!, radix: radix)
          ? errorText ?? FormBuilderLocalizations.of(context).integerErrorText
          : null;

  /// [FormFieldValidator] that requires the field's value to be a valid credit card number.
  static FormFieldValidator<String> creditCard(
    BuildContext context, {
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isCreditCard(valueCandidate!)
              ? errorText ??
                  FormBuilderLocalizations.of(context).creditCardErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid IP address.
  /// * [version] is a `String` or an `int`.
  static FormFieldValidator<String> ip(
    BuildContext context, {
    int? version,
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isIP(valueCandidate!, version)
              ? errorText ?? FormBuilderLocalizations.of(context).ipErrorText
              : null;

  /// [FormFieldValidator] that requires the field's value to be a valid date string.
  static FormFieldValidator<String> dateString(
    BuildContext context, {
    String? errorText,
  }) =>
      (valueCandidate) =>
          true == valueCandidate?.isNotEmpty && !isDate(valueCandidate!)
              ? errorText ??
                  FormBuilderLocalizations.of(context).dateStringErrorText
              : null;
}
