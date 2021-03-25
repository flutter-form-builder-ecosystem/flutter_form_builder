// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'it';

  static m4(value) =>
      "Il valore di questo campo deve essere uguale a ${value}.";

  static m0(max) => "Il valore inserito deve essere minore o uguale a ${max}";

  static m1(maxLength) =>
      "Il valore inserito deve avere una lunghezza minore o uguale a ${maxLength}";

  static m2(min) =>
      "Il valore inserito deve essere maggiore o uguale a ${min}.";

  static m3(minLength) =>
      "Il valore inserito deve avere una lunghezza maggiore o uguale a ${minLength}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede un numero di carta di credito valido."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede una data valida."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede un indirizzo email valido."),
        "equalErrorText": m4,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Il valore deve essere un integer."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede un indirizzo IP valido."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Il valore non corrisponde al formato richiesto."),
        "maxErrorText": m0,
        "maxLengthErrorText": m1,
        "minErrorText": m2,
        "minLengthErrorText": m3,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "Il valore deve essere numerico."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo non può essere vuoto."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Questo campo richiede una URL valida.")
      };
}
