// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a et locale. All the
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
  String get localeName => 'et';

  static String m0(value) => "See väärtus peab olema ${value}.";

  static String m1(max) => "Väärtus ei tohi olla üle ${max}";

  static String m2(maxLength) => "Sisendi pikkus ei tohi olla üle ${maxLength}";

  static String m3(min) => "Väärtus peab olema vähemalt ${min}.";

  static String m4(minLength) =>
      "Sisendi pikkus peab olema vähemalt ${minLength}";

  static String m5(value) => "See väärtus ei tohi olla ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Sellele väljale tuleb sisestada korrektne krediitkaardi number."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Sellele väljale tuleb sisestada korrektne kuupäev."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Sellele väljale tuleb sisestada korrektne meiliaadress."),
        "equalErrorText": m0,
        "integerErrorText":
            MessageLookupByLibrary.simpleMessage("Sisend peab olema täisarv."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Sellele väljale tuleb sisestada korrektne IP-aadress."),
        "matchErrorText":
            MessageLookupByLibrary.simpleMessage("Sisend ei vasta mustrile."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("Sisend peab olema arv."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("See väli ei tohi olla tühi."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Sellele väljale tuleb sisestada korrektne URL.")
      };
}
