// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(value) => "Dieser Feldwert muss ${value} gleich sein.";

  static String m1(max) => "Der Wert muss kleiner als oder gleich ${max} sein.";

  static String m2(maxLength) =>
      "Der Wert muss eine Länge kleiner als oder gleich ${maxLength} haben.";

  static String m3(min) => "Der Wert muss größer als oder gleich ${min} sein.";

  static String m4(minLength) =>
      "Der Wert muss eine Länge größer als oder gleich ${minLength} haben.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Für dieses Feld ist eine gültige Kreditkartennummer erforderlich."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Dieses Feld erfordert ein gültiges Datum."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Für dieses Feld ist eine gültige E-Mail-Adresse erforderlich."),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Der Wert muss eine integer sein."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Dieses Feld erfordert eine gültige IP-Adresse."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Der Wert stimmt nicht mit dem Muster überein."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "Der Wert muss numerisch sein."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Dieses Feld kann nicht leer sein."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Für dieses Feld ist eine gültige URL-Adresse erforderlich.")
      };
}
