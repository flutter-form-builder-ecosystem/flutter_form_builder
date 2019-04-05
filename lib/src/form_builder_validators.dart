import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class FormBuilderValidators {
  /// [FormFieldValidator] that requires the field have a non-empty value.
  static FormFieldValidator required({
    String errorText = "This field cannot be empty.",
  }) {
    return (val) {
      if (val == null || val.isEmpty) {
        return errorText;
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value be true.
  /// Commonly used for required checkboxes.
  static FormFieldValidator requiredTrue({
    String errorText = "This field must be set to true",
  }) {
    return (val) {
      if (val != true) {
        return errorText;
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value to be greater than
  /// or equal to the provided number.
  static FormFieldValidator min(
    num min, {
    String errorText,
  }) {
    return (val) {
      if (val != null &&
          ((val is num && val < min) ||
              (val is String &&
                  num.tryParse(val) != null &&
                  num.tryParse(val) < min))) {
        return errorText ?? "Value must be greater than or equal to $min";
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value to be less than
  /// or equal to the provided number.
  static FormFieldValidator max(
    num max, {
    String errorText,
  }) {
    return (val) {
      if (val != null) {
        if ((val is num && val > max) ||
            (val is String &&
                num.tryParse(val) != null &&
                num.tryParse(val) > max)) {
          return errorText ?? "Value must be less than or equal to $max";
        }
      }
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// greater than or equal to the provided minimum length.
  static FormFieldValidator minLength(
    num minLength, {
    String errorText,
  }) {
    return (val) {
      if (val != null && val.length < minLength) {
        return errorText ??
            "Value must have a length greater than or equal to $minLength";
      }
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// less than or equal to the provided maximum length.
  static FormFieldValidator maxLength(
    num maxLength, {
    String errorText,
  }) {
    return (val) {
      if (val != null && val.length > maxLength) {
        return errorText ??
            "Value must have a length less than or equal to $maxLength";
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid url.
  static FormFieldValidator email({
    String errorText = "This field requires a valid email address.",
  }) {
    return (val) {
      if (val != null && val.isNotEmpty) {
        if (!isEmail(val)) return errorText;
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid url.
  static FormFieldValidator url(
      {String errorText = "This field requires a valid URL address.",
      List<String> protocols = const ['http', 'https', 'ftp'],
      bool requireTld = true,
      bool requireProtocol = false,
      bool allowUnderscore = false,
      List<String> hostWhitelist = const [],
      List<String> hostBlacklist = const []}) {
    return (val) {
      if (val != null && val.isNotEmpty) {
        if (!isURL(val,
            protocols: protocols,
            requireTld: requireTld,
            requireProtocol: requireProtocol,
            allowUnderscore: allowUnderscore,
            hostWhitelist: hostWhitelist,
            hostBlacklist: hostBlacklist)) return errorText;
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value to match a regex
  /// pattern.
  static FormFieldValidator pattern(
    Pattern pattern, {
    String errorText = "Value does not match pattern.",
  }) {
    return (val) {
      if (val != null && val.isNotEmpty) {
        if (!RegExp(pattern).hasMatch(val)) return errorText;
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  static FormFieldValidator numeric({
    String errorText = "Value must be numeric.",
  }) {
    return (val) {
      if (num.tryParse(val) == null && val.isNotEmpty) return errorText;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid credit card number.
  static FormFieldValidator creditCard({
    String errorText = "This field requires a valid credit card number.",
  }) {
    return (val) {
      if (val != null && val.isNotEmpty) {
        if (!isCreditCard(val)) return errorText;
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid IP.
  // ignore: non_constant_identifier_names
  static FormFieldValidator IP({
    dynamic version,
    String errorText = "This field requires a valid IP.",
  }) {
    return (val) {
      if (val != null && val.isNotEmpty) {
        if (!isIP(val, version)) return errorText;
      }
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid date string.
  static FormFieldValidator date({
    String errorText = "This field requires a valid date string.",
  }) {
    return (val) {
      if (val != null && val.isNotEmpty) {
        if (!isDate(val)) return errorText;
      }
    };
  }
}
