// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(value) => "Значение поля должно быть равно ${value}.";

  static String m1(max) => "Значение должно быть меньше или равно ${max}.";

  static String m2(maxLength) =>
      "Длина значения должно быть меньше или равно ${maxLength}.";

  static String m3(min) => "Значение должно быть больше или равно ${min}.";

  static String m4(minLength) =>
      "Длина значения должно быть больше или равно ${minLength}.";

  static String m5(value) => "Значение поля не должно быть равным ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Значение поля должно быть номером кредитной карты."),
        "dateStringErrorText":
            MessageLookupByLibrary.simpleMessage("Поле должно быть датой."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Поле должно быть email адресом."),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Поле должно быть целым числом."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Поле должно быть IP номером."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Значение должно удовлетворять шаблону."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "Значение должно быть числом."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("Поле не может быть пустым."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Поле должно быть URL адресом.")
      };
}
