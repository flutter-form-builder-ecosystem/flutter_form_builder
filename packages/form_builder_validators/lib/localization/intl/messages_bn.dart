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

  static String m0(value) => "এই ক্ষেত্রের মান সমান হতে হবে ${value}।";

  static String m1(max) => "মান এর থেকে কম বা সমান হতে হবে ${max}।";

  static String m2(maxLength) =>
      "মান অবশ্যই এর থেকে কম বা সমান দৈর্ঘ্য থাকতে হবে ${maxLength}।";

  static String m3(min) => "মান এর থেকে বেশি বা সমান হতে হবে ${min}।";

  static String m4(minLength) =>
      "মান অবশ্যই এর চেয়ে বেশি বা সমান দৈর্ঘ্য থাকতে হবে ${minLength}।";

  static String m5(value) => "এই ক্ষেত্রের মান সমান হওয়া উচিত নয় ${value}।";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "এই ক্ষেত্রে একটি বৈধ ক্রেডিট কার্ড নম্বর প্রয়োজন।"),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "এই ক্ষেত্রে একটি বৈধ তারিখ স্ট্রিং প্রয়োজন।"),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "এই ক্ষেত্রে একটি বৈধ ইমেল ঠিকানা প্রয়োজন।"),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "এই ক্ষেত্রের একটি বৈধ পূর্ণসংখ্যা প্রয়োজন।"),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "এই ক্ষেত্রে একটি বৈধ আইপি প্রয়োজন।"),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "মান প্যাটার্নের সাথে মেলে না।"),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "মান অবশ্যই সাংখ্যিক হতে হবে।"),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "এই ক্ষেত্রটি খালি রাখা যাবে না।"),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "এই ক্ষেত্রের একটি বৈধ ওয়েব ঠিকানা প্রয়োজন।")
      };
}
