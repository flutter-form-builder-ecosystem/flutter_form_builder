// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a bn locale. All the
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
  String get localeName => 'bn';

  static String m0(value) => "মান ${value} সমান হতে হবে।";

  static String m1(max) => "মান অবশ্যই ${max} এর কম বা সমান হতে হবে।";

  static String m2(maxLength) =>
      "মান অবশ্যই ${maxLength} এর থেকে কম বা সমান সংখ্যা হতে হবে।";

  static String m3(min) => "মান অবশ্যই ${min} এর থেকে বেশি বা সমান হতে হবে।";

  static String m4(minLength) =>
      "মান অবশ্যই ${minLength} এর চেয়ে বেশি বা সমান সংখ্যা হতে হবে।";

  static String m5(value) => "মান ${value} এর সমান হওয়া উচিত নয়।";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "বৈধ ক্রেডিট কার্ড নম্বর প্রয়োজন।"),
        "dateStringErrorText":
            MessageLookupByLibrary.simpleMessage("একটি বৈধ তারিখ প্রয়োজন।"),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "একটি বৈধ ইমেল আইডি প্রয়োজন।"),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "মান অবশ্যই একটি পূর্ণসংখ্যা হতে হবে।"),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "একটি বৈধ আইপি এড্রেস প্রয়োজন।"),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "মান প্যাটার্নের সাথে মেলে না।"),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "মান অবশ্যই সংখ্যায় হতে হবে।"),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("খালি রাখা যাবে না।"),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "একটি বৈধ ওয়েব এড্রেস প্রয়োজন।")
      };
}
