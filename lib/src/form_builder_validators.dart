import 'package:flutter/material.dart';

class FormBuilderValidators {
  static FormFieldValidator required({
    String errorMessage = "This field cannot be empty.",
  }) {
    return (val) {
      if (val == null || val.isEmpty) {
        return errorMessage;
      }
    };
  }

  static FormFieldValidator requiredTrue({
    String errorMessage = "This field must be set to true",
  }) {
    return (val) {
      if (val != true) {
        return errorMessage;
      }
    };
  }

  static FormFieldValidator min(
    num min, {
    String errorMessage,
  }) {
    return (val) {
      if (val != null &&
          ((val is num && val < min) ||
              (val is String &&
                  num.tryParse(val) != null &&
                  num.tryParse(val) < min))) {
        return errorMessage ?? "Value must be greater than or equal to $min";
      }
    };
  }

  static FormFieldValidator max(
    num max, {
    String errorMessage,
  }) {
    return (val) {
      if (val != null) {
        if ((val is num && val > max) ||
            (val is String &&
                num.tryParse(val) != null &&
                num.tryParse(val) > max)) {
          return errorMessage ?? "Value must be less than or equal to $max";
        }
      }
    };
  }

  static FormFieldValidator minLength(
    num minLength, {
    String errorMessage,
  }) {
    return (val) {
      if (val != null && val.length < minLength) {
        return errorMessage ??
            "Value must have a length greater than or equal to $minLength";
      }
    };
  }

  static FormFieldValidator maxLength(
    num maxLength, {
    String errorMessage,
  }) {
    return (val) {
      if (val != null && val.length > maxLength) {
        return errorMessage ??
            "Value must have a length less than or equal to $maxLength";
      }
    };
  }

  static FormFieldValidator email({
    String errorMessage = "This field requires a valid email address.",
  }) {
    return (val) {
      if (val != null && val.isNotEmpty) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        if (!RegExp(pattern).hasMatch(val)) return errorMessage;
      }
    };
  }

  static FormFieldValidator url({
    String errorMessage = "This field requires a valid email address.",
  }) {
    return (val) {
      if (val != null && val.isNotEmpty) {
        Pattern pattern =
            r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
        if (!RegExp(pattern).hasMatch(val)) return errorMessage;
      }
    };
  }

  static FormFieldValidator pattern(
    Pattern pattern, {
    String errorMessage = "Value does not match pattern.",
  }) {
    return (val) {
      if (val != null && val.isNotEmpty) {
        if (!RegExp(pattern).hasMatch(val)) return errorMessage;
      }
    };
  }

  static FormFieldValidator numeric({
    String errorMessage = "Value must be numeric.",
  }) {
    return (val) {
      if (num.tryParse(val) == null && val.isNotEmpty) return errorMessage;
    };
  }
}
