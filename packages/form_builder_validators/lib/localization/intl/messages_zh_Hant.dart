// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hant locale. All the
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
  String get localeName => 'zh_Hant';

  static String m0(value) => "此字段必須與${value}相符";

  static String m1(max) => "此字段必須小於或等於${max}";

  static String m2(maxLength) => "此字段的長度必須小於或等於${maxLength}";

  static String m3(min) => "此字段必須大於或等於${min}";

  static String m4(minLength) => "此字段的長度必須大於或等於${minLength}";

  static String m5(value) => "此字段不得等於${value}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText":
            MessageLookupByLibrary.simpleMessage("此字段需要有效的信用卡號碼。"),
        "dateStringErrorText":
            MessageLookupByLibrary.simpleMessage("此字段需要有效的日期字符串。"),
        "emailErrorText":
            MessageLookupByLibrary.simpleMessage("此字段需要有效的電子郵件地址。"),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage("此字段需要有效的整數。"),
        "ipErrorText": MessageLookupByLibrary.simpleMessage("此字段需要有效的IP。"),
        "matchErrorText": MessageLookupByLibrary.simpleMessage("此字段與格式不匹配。"),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText": MessageLookupByLibrary.simpleMessage("此字段必須是數字。"),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage("此字段不能為空。"),
        "urlErrorText": MessageLookupByLibrary.simpleMessage("此字段需要有效的URL地址。")
      };
}
