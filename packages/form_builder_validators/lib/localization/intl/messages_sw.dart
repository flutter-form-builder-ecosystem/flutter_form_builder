// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sw locale. All the
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
  String get localeName => 'sw';

  static String m0(value) =>
      "Thamani ya sehemu hii lazima iwe sawa na ${value}.";

  static String m1(max) => "Thamani lazima iwe chini ya au sawa na ${max}";

  static String m2(maxLength) =>
      "Thamani lazima iwe na urefu chini ya au sawa na ${maxLength}";

  static String m3(min) => "Thamani lazima iwe kubwa kuliko au sawa na ${min}.";

  static String m4(minLength) =>
      "Thamani lazima iwe na urefu mkubwa kuliko au sawa na ${minLength}.";

  static String m5(value) =>
      "Thamani hii ya sehemu haifai kuwa sawa na ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Sehemu hii inahitaji nambari halali ya kadi ya mkopo."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Sehemu hii inahitaji mfuatano halali wa tarehe."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Sehemu hii inahitaji barua pepe halali."),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Sehemu hii inahitaji nambari kamili halali."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Sehemu hii inahitaji IP halali."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Thamani hailingani na muundo."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("Thamani lazima iwe nambari."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Sehemu hii haiwezi kuwa tupu."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Sehemu hii inahitaji anwani sahihi ya tovuti.")
      };
}
