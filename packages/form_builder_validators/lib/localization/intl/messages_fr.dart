// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m1(max) => "La valeur doit être inférieure ou égale à ${max}";

  static String m2(maxLength) =>
      "La valeur doit avoir une longueur inférieure ou égale à ${maxLength}";

  static String m3(min) => "La valeur doit être supérieure ou égale à ${min}.";

  static String m4(minLength) =>
      "La valeur doit avoir une longueur supérieure ou égale à ${minLength}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite un numéro de carte de crédit valide."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite une chaîne de date valide."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite une adresse e-mail valide."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite une adresse IP valide."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "La valeur ne correspond pas au modèle."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "La valeur doit être numérique."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ ne peut pas être vide."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite une adresse URL valide.")
      };
}
