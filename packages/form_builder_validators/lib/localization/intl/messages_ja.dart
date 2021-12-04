// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(value) => "${value}に一致していません。";

  static String m1(max) => "${max}以下にしてください。";

  static String m2(maxLength) => "${maxLength}文字以下で入力してください。";

  static String m3(min) => "${min}以上にしてください。";

  static String m4(minLength) => "${minLength}文字以上で入力してください。";

  static String m5(value) => "${value}と違うものにしてください。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText":
            MessageLookupByLibrary.simpleMessage("有効なクレジットカード番号を入力してください。"),
        "dateStringErrorText":
            MessageLookupByLibrary.simpleMessage("正しい日付を入力してください。"),
        "emailErrorText":
            MessageLookupByLibrary.simpleMessage("有効なメールアドレスを入力してください。"),
        "equalErrorText": m0,
        "integerErrorText":
            MessageLookupByLibrary.simpleMessage("整数で入力してください。"),
        "ipErrorText":
            MessageLookupByLibrary.simpleMessage("有効なIPアドレスを入力してください。"),
        "matchErrorText":
            MessageLookupByLibrary.simpleMessage("有効な正規表現を指定してください。"),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("半角数字で入力してください。"),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage("必須項目です。"),
        "urlErrorText": MessageLookupByLibrary.simpleMessage("有効なURLを入力してください。")
      };
}
