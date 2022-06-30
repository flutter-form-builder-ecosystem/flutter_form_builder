// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
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
  String get localeName => 'tr';

  static String m0(value) =>
      "Bu alanın değeri, ${value} değerine eşit olmalıdır.";

  static String m6(length) =>
      "Değerin uzunluğu ${length} değerine eşit olmalıdır.";

  static String m1(max) => "Değer ${max} değerinden küçük veya eşit olmalıdır.";

  static String m2(maxLength) =>
      "Değerin uzunluğu ${maxLength} değerinden küçük veya eşit olmalıdır.";

  static String m3(min) => "Değer ${min} değerinden büyük veya eşit olmalıdır.";

  static String m4(minLength) =>
      "Değerin uzunluğu ${minLength} değerinden büyük veya eşit olmalıdır.";

  static String m5(value) =>
      "Bu alanın değeri, ${value} değerine eşit olmamalıdır.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Bu alan geçerli bir kredi kartı numarası gerektirir."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Bu alan geçerli bir tarih gerektirir."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Bu alan geçerli bir e-posta adresi gerektirir."),
        "equalErrorText": m0,
        "equalLengthErrorText": m6,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Bu alan geçerli bir tamsayı gerektirir."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Bu alan geçerli bir IP adresi gerektirir."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Lütfen geçerli bir değer giriniz."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("Değer sayısal olmalıdır."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("Bu alan boş olamaz."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Bu alan geçerli bir URL adresi gerektirir.")
      };
}
