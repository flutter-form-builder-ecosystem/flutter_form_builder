// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pl';

  static String m0(value) => "Wartość tego pola musi wynosić ${value}.";

  static String m1(max) => "Wartość musi być mniejsza lub równa ${max}.";

  static String m2(maxLength) =>
      "Wartość nie może mieć więcej niż ${maxLength} znaków.";

  static String m3(min) => "Wartość musi być większa lub równa ${min}.";

  static String m4(minLength) =>
      "Wartość musi mieć co najmniej ${minLength} znaków.";

  static String m5(value) => "Wartość tego pola nie może być ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "To pole wymaga podania ważnego numeru karty kredytowej."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "To pole wymaga prawidłowej daty."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "To pole wymaga prawidłowego adresu e-mail."),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Wartość musi być liczbą całkowitą."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "To pole wymaga prawidłowego adresu IP."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Wartość nie pasuje do oczekiwanego kształtu."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("Wartość musi być liczbą."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("To pole nie może być puste."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "To pole wymaga prawidłowego adresu URL.")
      };
}
