// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sk locale. All the
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
  String get localeName => 'sk';

  static String m0(value) => "Hodnota tohto poľa musí byť ${value}.";

  static String m1(max) => "Hodnota musí byť menšia alebo rovná ako ${max}.";

  static String m2(maxLength) =>
      "Hodnota musí mať dĺžku najviac ${maxLength} znakov.";

  static String m3(min) => "Hodnota musí byť väčšia alebo rovná ako ${min}.";

  static String m4(minLength) =>
      "Hodnota musí mať dĺžku aspoň ${minLength} znakov.";

  static String m5(value) => "Hodnota tohto poľa nesmie byť ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Toto pole vyžaduje platné číslo platobnej karty."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Toto pole vyžaduje platný dátum."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Toto pole vyžaduje platnú emailovú adresu."),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Hodnota musí byť celé číslo."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Toto pole vyžaduje platnú IP adresu."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Hodnota nevyhovuje očakávanému tvaru."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("Hodnota musí byť číslo."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Toto pole nesmie byť prázdne."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Toto pole vyžaduje platnú URL adresu.")
      };
}
