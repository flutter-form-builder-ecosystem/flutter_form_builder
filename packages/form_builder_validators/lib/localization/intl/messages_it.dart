// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(value) =>
      "Il valore di questo campo deve essere uguale a ${value}.";

  static String m1(max) =>
      "Il valore inserito deve essere minore o uguale a ${max}";

  static String m2(maxLength) =>
      "Il valore inserito deve avere una lunghezza minore o uguale a ${maxLength}";

  static String m3(min) =>
      "Il valore inserito deve essere maggiore o uguale a ${min}.";

  static String m4(minLength) =>
      "Il valore inserito deve avere una lunghezza maggiore o uguale a ${minLength}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede un numero di carta di credito valido."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede una data valida."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede un indirizzo email valido."),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Il valore deve essere un integer."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede un indirizzo IP valido."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Il valore non corrisponde al formato richiesto."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "Il valore deve essere numerico."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo non può essere vuoto."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede una URL valida.")
      };
}
