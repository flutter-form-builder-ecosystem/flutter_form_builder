// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static m1(max) => "يجب أن تكون قيمة هذا الفراغ مساوية او اقل من ${max}.";

  static m2(maxLength) =>
      "يجب أن يكون حجم هذا الفراغ مساوي او اقل من ${maxLength}.";

  static m3(min) => "يجب أن تكون قيمة هذا الفراغ مساوية او اكثر من ${min}.";

  static m4(minLength) =>
      "يجب أن يكون حجم هذا الفراغ مساوي او اكثر من ${minLength}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "قيمة الفراغ ليست رقم بطاقة ائتمانيه صحيحة."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
          "هذا الفراغ يتطلب تاريخ صالح.",
        ),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "هذا الفراغ يتطلب عنوان بريد إلكتروني صالح."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "هذا الفراغ يتطلب رقم IP صالح."),
        "matchErrorText":
            MessageLookupByLibrary.simpleMessage("قيمة الفراغ لا تطابق النمط."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("قيمة الفراغ ليست رقمية."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("هذا الفراغ يجب املاؤه."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "هذا الفراغ يتطلب عنوان موقع URL صالح.")
      };
}
