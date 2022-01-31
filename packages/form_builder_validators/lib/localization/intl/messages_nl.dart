// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  String get localeName => 'nl';

  static String m0(value) => "De veldwaarde moet gelijk zijn aan ${value}.";

  static String m1(max) =>
      "De waarde moet kleiner zijn dan of gelijk aan ${max}";

  static String m2(maxLength) =>
      "De waarde moet een lengte hebben die kleiner is dan of gelijk is aan ${maxLength}";

  static String m3(min) =>
      "De waarde moet groter zijn dan of gelijk aan ${min}.";

  static String m4(minLength) =>
      "De waarde moet een lengte hebben die groter of gelijk is aan ${minLength}";

  static String m5(value) => "De veldwaarde mag niet gelijk zijn aan ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Een geldig creditcardnummer is vereist. "),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Een geldige datum is vereist. "),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Een geldig e-mailadres is vereist. "),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Dit veld vereist een geheel getal. "),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Een geldig IP-adres is vereist."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "De waarde komt niet overeen met het patroon."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "De waarde moet numeriek zijn."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Dit veld mag niet leeg zijn."),
        "urlErrorText":
            MessageLookupByLibrary.simpleMessage("Een geldige URL is vereist.")
      };
}
