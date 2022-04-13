// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ro locale. All the
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
  String get localeName => 'ro';

  static String m0(value) =>
      "Valoarea câmpului trebuie să fie egală cu ${value}.";

  static String m1(max) =>
      "Valoarea trebuie să fie mai mică sau egală cu ${max}";

  static String m2(maxLength) =>
      "Valoarea trebuie să aibă o lungime mai mică sau egală cu ${maxLength}";

  static String m3(min) =>
      "Valoarea trebuie să fie mai mare sau egală cu ${min}.";

  static String m4(minLength) =>
      "Valoarea trebuie să aibă o lungime mai mare sau egală cu ${minLength}";

  static String m5(value) =>
      "Valoarea câmpului nu trebuie să fie egală cu ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Acest câmp necesită un număr valid de card de credit."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Acest câmp necesită un șir de date valid."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Acest câmp necesită o adresă de e-mail validă."),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Acest câmp necesită un număr întreg valid."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Acest câmp necesită un IP valid."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Valoarea nu se potrivește cu modelul."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "Valoarea trebuie să fie numerică."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("Acest câmp nu poate fi gol."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Acest câmp necesită o adresă URL validă.")
      };
}
