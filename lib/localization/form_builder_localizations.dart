import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/l10n/messages_all.dart';
import 'package:intl/intl.dart';

class FormBuilderLocalizations {
  static Future<FormBuilderLocalizations> load(Locale locale) {
    final name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return FormBuilderLocalizations();
    });
  }

  static FormBuilderLocalizations of(BuildContext context) {
    return Localizations.of<FormBuilderLocalizations>(
        context, FormBuilderLocalizations);
  }

  String get requiredErrorText {
    return Intl.message(
      'This field cannot be empty.',
      name: 'requiredErrorText',
      desc: 'Error Text for required field',
    );
  }

  String get requireTrueErrorText => Intl.message(
        'This field must be set to true.',
        name: 'requireTrueErrorText',
        desc: 'Error Text for required field',
      );

  String minErrorText(min) => Intl.message(
        'Value must be greater than or equal to $min.',
        name: 'minErrorText',
        args: [min],
        desc: 'Error Text for required field',
      );

  String minLengthErrorText(minLength) => Intl.message(
        'Value must have a length greater than or equal to $minLength',
        name: 'minLengthErrorText',
        args: [minLength],
        desc: 'Error Text for required field',
      );

  String maxErrorText(max) => Intl.message(
        'Value must be less than or equal to $max',
        name: 'maxErrorText',
        args: [max],
        desc: 'Error Text for required field',
      );

  String maxLengthErrorText(maxLength) => Intl.message(
        'Value must have a length less than or equal to $maxLength',
        name: 'maxLengthErrorText',
        args: [maxLength],
        desc: 'Error Text for required field',
      );

  String get emailErrorText => Intl.message(
        'This field requires a valid email address.',
        name: 'emailErrorText',
        desc: 'Error Text for email field',
      );

  String get urlErrorText => Intl.message(
        'This field requires a valid URL address.',
        name: 'urlErrorText',
        desc: 'Error Text for URL field',
      );

  String get patternErrorText => Intl.message(
        'Value does not match pattern.',
        name: 'patternErrorText',
        desc: 'Error Text for pattern field',
      );

  String get numericErrorText => Intl.message(
        'Value must be numeric.',
        name: 'numericErrorText',
        desc: 'Error Text for numeric field',
      );

  String get creditCardErrorText => Intl.message(
        'This field requires a valid credit card number.',
        name: 'creditCardErrorText',
        desc: 'Error Text for credit card field',
      );

  String get ipErrorText => Intl.message(
        'This field requires a valid IP.',
        name: 'ipErrorText',
        desc: 'Error Text for IP address field',
      );

  String get dateStringErrorText => Intl.message(
    'This field requires a valid date string.',
        name: 'dateStringErrorText',
        desc: 'Error Text for date string field',
      );
}

class FormBuilderLocalizationsDelegate
    extends LocalizationsDelegate<FormBuilderLocalizations> {
  const FormBuilderLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<FormBuilderLocalizations> load(Locale locale) {
    return FormBuilderLocalizations.load(locale);
  }

  @override
  bool shouldReload(FormBuilderLocalizationsDelegate old) {
    return false;
  }
}
