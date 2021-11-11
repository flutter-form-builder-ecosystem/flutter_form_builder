// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(value) => "이 필드의 값은 반드시 ${value}와 같아야 합니다.";

  static String m1(max) => "이 필드의 값은 반드시 ${max} 이하이어야 합니다.";

  static String m2(maxLength) => "이 필드는 반드시 ${maxLength}자 이하이어야 합니다.";

  static String m3(min) => "이 필드의 값은 반드시 ${min} 이상이어야 합니다.";

  static String m4(minLength) => "이 필드는 반드시 ${minLength}자 이상이어야 합니다.";

  static String m5(value) => "이 필드의 값은 반드시 ${value}와 달라야 합니다.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText":
            MessageLookupByLibrary.simpleMessage("유효한 카드 번호를 입력해 주세요."),
        "dateStringErrorText":
            MessageLookupByLibrary.simpleMessage("날짜 형식이 올바르지 않습니다."),
        "emailErrorText":
            MessageLookupByLibrary.simpleMessage("이메일 주소 형식이 올바르지 않습니다."),
        "equalErrorText": m0,
        "integerErrorText":
            MessageLookupByLibrary.simpleMessage("정수만 입력 가능합니다."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage("유효한 IP를 입력해 주세요."),
        "matchErrorText":
            MessageLookupByLibrary.simpleMessage("필드의 값이 패턴과 맞지 않습니다."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("숫자만 입력 가능합니다."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("이 필드는 반드시 입력해야 합니다."),
        "urlErrorText":
            MessageLookupByLibrary.simpleMessage("URL 형식이 올바르지 않습니다.")
      };
}
