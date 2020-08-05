import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:validators/validators.dart';

class FormBuilderValidators {
  /// [FormFieldValidator] that is composed of other [FormFieldValidator]s.
  /// Each validator is run against the [FormField] value and if any returns a
  /// non-null result validation fails, otherwise, validation passes
  static FormFieldValidator compose(List<FormFieldValidator> validators) {
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
  static FormFieldValidator required(
    BuildContext context, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate == null ||
          ((valueCandidate is Iterable ||
                  valueCandidate is String ||
                  valueCandidate is Map) &&
              valueCandidate.length == 0)) {
        return errorText ??
            FormBuilderLocalizations.of(context).requiredErrorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value be true.
  /// Commonly used for required checkboxes.
  static FormFieldValidator equal(
    BuildContext context,
    dynamic value, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != value) {
        return errorText ??
            FormBuilderLocalizations.of(context).requiredErrorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be greater than
  /// or equal to the provided number.
  static FormFieldValidator min(
    BuildContext context,
    num min, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null &&
          ((valueCandidate is num && valueCandidate < min) ||
              (valueCandidate is String &&
                  num.tryParse(valueCandidate) != null &&
                  num.tryParse(valueCandidate) < min))) {
        return errorText ??
            FormBuilderLocalizations.of(context).minErrorText(min);
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be less than
  /// or equal to the provided number.
  static FormFieldValidator max(
    BuildContext context,
    num max, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null) {
        if ((valueCandidate is num && valueCandidate > max) ||
            (valueCandidate is String &&
                num.tryParse(valueCandidate) != null &&
                num.tryParse(valueCandidate) > max)) {
          return errorText ??
              FormBuilderLocalizations.of(context).maxErrorText(max);
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// greater than or equal to the provided minimum length.
  static FormFieldValidator minLength(
    BuildContext context,
    num minLength, {
    bool allowEmpty = false,
    String errorText,
  }) {
    return (valueCandidate) {
      final valueLength = valueCandidate?.length ?? 0;
      if (valueLength < minLength && (!allowEmpty || valueLength > 0)) {
        return errorText ??
            FormBuilderLocalizations.of(context).minLengthErrorText(minLength);
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// less than or equal to the provided maximum length.
  static FormFieldValidator maxLength(
    BuildContext context,
    num maxLength, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.length > maxLength) {
        return errorText ??
            FormBuilderLocalizations.of(context).maxLengthErrorText(maxLength);
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid email address.
  static FormFieldValidator email(
    BuildContext context, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!isEmail(valueCandidate.trim())) {
          return errorText ??
              FormBuilderLocalizations.of(context).emailErrorText;
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid url.
  static FormFieldValidator url(
    BuildContext context, {
    String errorText,
    List<String> protocols = const ['http', 'https', 'ftp'],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscore = false,
    List<String> hostWhitelist = const [],
    List<String> hostBlacklist = const [],
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!isURL(valueCandidate,
            protocols: protocols,
            requireTld: requireTld,
            requireProtocol: requireProtocol,
            allowUnderscore: allowUnderscore,
            hostWhitelist: hostWhitelist,
            hostBlacklist: hostBlacklist)) {
          return errorText ?? FormBuilderLocalizations.of(context).urlErrorText;
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to match the provided regex pattern.
  static FormFieldValidator match(
    BuildContext context,
    Pattern pattern, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!RegExp(pattern).hasMatch(valueCandidate)) {
          return errorText ??
              FormBuilderLocalizations.of(context).matchErrorText;
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  static FormFieldValidator numeric(
    BuildContext context, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (num.tryParse(valueCandidate) == null && valueCandidate.isNotEmpty) {
        return errorText ??
            FormBuilderLocalizations.of(context).numericErrorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid credit card number.
  static FormFieldValidator creditCard(
    BuildContext context, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!isCreditCard(valueCandidate)) {
          return errorText ??
              FormBuilderLocalizations.of(context).creditCardErrorText;
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid IP address.
  /// * [version] is a String or an `int`.
  // ignore: non_constant_identifier_names
  static FormFieldValidator IP(
    BuildContext context, {
    dynamic version,
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!isIP(valueCandidate, version)) {
          return errorText ?? FormBuilderLocalizations.of(context).ipErrorText;
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid date string.
  static FormFieldValidator dateString(
    BuildContext context, {
    String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!isDate(valueCandidate)) {
          return errorText ??
              FormBuilderLocalizations.of(context).dateStringErrorText;
        }
      }
      return null;
    };
  }
}
