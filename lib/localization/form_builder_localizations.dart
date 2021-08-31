import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/l10n/messages_all.dart';
import 'package:intl/intl.dart';

class FormBuilderLocalizations {
  static Future<FormBuilderLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? true)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return FormBuilderLocalizations();
    });
  }

  static const LocalizationsDelegate<FormBuilderLocalizations> delegate =
      _FormBuilderLocalizationsDelegate();

  static FormBuilderLocalizations of(BuildContext context) {
    /*return Localizations.of<FormBuilderLocalizations>(
        context, FormBuilderLocalizations);*/
    return Localizations.of<FormBuilderLocalizations>(
          context,
          FormBuilderLocalizations,
        ) ??
        FormBuilderLocalizations();
  }

  String get requiredErrorText {
    return Intl.message(
      'This field cannot be empty.',
      name: 'requiredErrorText',
      desc: 'Error Text for required validator',
    );
  }

  String equalErrorText<T>(T value) => Intl.message(
        'This field value must be equal to $value.',
        name: 'equalErrorText',
        args: [value!],
        desc: 'Error Text for equal validator',
      );

  String notEqualErrorText<T>(T value) => Intl.message(
        'This field value must not be equal to $value.',
        name: 'notEqualErrorText',
        args: [value!],
        desc: 'Error Text for not-equal validator',
      );

  String minErrorText(num min) => Intl.message(
        'Value must be greater than or equal to $min.',
        name: 'minErrorText',
        args: [min],
        desc: 'Error Text for required field',
      );

  String minLengthErrorText(int minLength) => Intl.message(
        'Value must have a length greater than or equal to $minLength',
        name: 'minLengthErrorText',
        args: [minLength],
        desc: 'Error Text for minLength validator',
      );

  String maxErrorText(num max) => Intl.message(
        'Value must be less than or equal to $max',
        name: 'maxErrorText',
        args: [max],
        desc: 'Error Text for max validator',
      );

  String maxLengthErrorText(int maxLength) => Intl.message(
        'Value must have a length less than or equal to $maxLength',
        name: 'maxLengthErrorText',
        args: [maxLength],
        desc: 'Error Text for required field',
      );

  String get emailErrorText => Intl.message(
        'This field requires a valid email address.',
        name: 'emailErrorText',
        desc: 'Error Text for email validator',
      );

  String get urlErrorText => Intl.message(
        'This field requires a valid URL address.',
        name: 'urlErrorText',
        desc: 'Error Text for URL validator',
      );

  String get matchErrorText => Intl.message(
        'Value does not match pattern.',
        name: 'matchErrorText',
        desc: 'Error Text for pattern validator',
      );

  String get numericErrorText => Intl.message(
        'Value must be numeric.',
        name: 'numericErrorText',
        desc: 'Error Text for numeric validator',
      );

  String get integerErrorText => Intl.message(
        'Value must be an integer.',
        name: 'integerErrorText',
        desc: 'Error Text for integer validator',
      );

  String get creditCardErrorText => Intl.message(
        'This field requires a valid credit card number.',
        name: 'creditCardErrorText',
        desc: 'Error Text for credit card validator',
      );

  String get ipErrorText => Intl.message(
        'This field requires a valid IP.',
        name: 'ipErrorText',
        desc: 'Error Text for IP address validator',
      );

  String get dateStringErrorText => Intl.message(
        'This field requires a valid date string.',
        name: 'dateStringErrorText',
        desc: 'Error Text for date string validator',
      );
}

class _FormBuilderLocalizationsDelegate
    extends LocalizationsDelegate<FormBuilderLocalizations> {
  const _FormBuilderLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['de', 'en', 'es', 'fa', 'fr', 'hu', 'it', 'ja', 'pt', 'sk', 'pl', 'ar']
        .contains(locale.languageCode);
  }

  @override
  Future<FormBuilderLocalizations> load(Locale locale) {
    return FormBuilderLocalizations.load(locale);
  }

  @override
  bool shouldReload(_FormBuilderLocalizationsDelegate old) {
    return false;
  }
}
