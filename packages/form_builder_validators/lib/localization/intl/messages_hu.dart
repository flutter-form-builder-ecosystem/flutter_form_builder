// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hu locale. All the
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
  String get localeName => 'hu';

  static String m1(max) => "Az érték legyen legfeljebb ${max}";

  static String m2(maxLength) =>
      "Value must have a length less than or equal to ${maxLength}";

  static String m3(min) => "Az érték legyen legalább ${min}.";

  static String m4(minLength) =>
      "Az értéknel legalább ${minLength} karakter hosszúnak kell lennie";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "A megadott érték nem egy érvényes bankkártya szám."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Ennek a mezőnek dátumnak kell lennie."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "A megadott érték nem egy érvényes email cím."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "A megadott érték nem egy érvényes IP cím."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "A megadott érték nem egyezik a szükséges formátummal."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "Ebbe a mezőbe csak számot lehet írni."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Ennek a mezőnek értéket kell adni."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "A megadott érték nem egy érvényes URL cím.")
      };
}
