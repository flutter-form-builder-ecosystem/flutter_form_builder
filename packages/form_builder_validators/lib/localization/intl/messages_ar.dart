// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(value) => "يجب أن تكون القيمة المدخلة مساوية لـ ${value}.";

  static String m1(max) => "يجب أن لا تزيد القيمة المدخلة عن ${max}.";

  static String m2(maxLength) =>
      "يجب أن لا يزيد طول القيمة المدخلة عن ${maxLength}.";

  static String m3(min) => "يجب أن لا تقل القيمة المدخلة عن ${min}.";

  static String m4(minLength) =>
      "يجب أن لا يقل طول القيمة المدخلة عن ${minLength}.";

  static String m5(value) =>
      "يجب أن لا تكون القيمة المدخلة مساوية لـ ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "القيمة المدخلة لا تصلح كرقم بطاقة إئتمانية."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "هذا الحقل يتطلب تاريخا صالحا."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "هذا الحقل يتطلب عنوان بريد إلكتروني صالح."),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "القيمة المدخلة ليست رقما صحيحا."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "هذا الحقل يتطلب عنوان IP صالح."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "القيمة المدخلة لا تطابق الصيغة المطلوبة."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("القيمة المدخلة ليست رقما."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("هذا الحقل يجب ملؤه."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "هذا الحقل يتطلب عنوان URL صالح.")
      };
}
