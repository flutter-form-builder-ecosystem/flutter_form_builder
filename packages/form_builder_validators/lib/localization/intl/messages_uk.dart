// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
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
  String get localeName => 'uk';

  static String m0(value) => "Значення поля має дорівнювати ${value}.";

  static String m1(max) => "Значення має бути менше або дорівнює ${max}.";

  static String m2(maxLength) =>
      "Довжина значеня Має бути менше або дорівнює ${maxLength}.";

  static String m3(min) => "Значення має бути більш або дорівнює ${min}.";

  static String m4(minLength) =>
      "Довжина значеня Має бути більш або дорівнює ${minLength}.";

  static String m5(value) => "Значення поля не повинно бути рівним ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Значення поля має бути номером кредитної картки."),
        "dateStringErrorText":
            MessageLookupByLibrary.simpleMessage("Поле має бути датою."),
        "emailErrorText":
            MessageLookupByLibrary.simpleMessage("Поле має бути email адрес."),
        "equalErrorText": m0,
        "integerErrorText":
            MessageLookupByLibrary.simpleMessage("Поле має бути цілим числом."),
        "ipErrorText":
            MessageLookupByLibrary.simpleMessage("Поле має бути IP номером."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Значення має задовольняти шаблоном."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("Значення має бути числом."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("Поле не може бути порожнім."),
        "urlErrorText":
            MessageLookupByLibrary.simpleMessage("Поле має бути URL адресою.")
      };
}
