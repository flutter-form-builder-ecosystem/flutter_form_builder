// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ca locale. All the
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
  String get localeName => 'ca';

  static String m0(value) => "Aquest valor de camp ha de ser igual a ${value}.";

  static String m1(max) => "El valor ha de ser inferior o igual a ${max}";

  static String m2(maxLength) =>
      "El valor ha de tenir una longitud inferior o igual a ${maxLength}";

  static String m3(min) => "El valor ha de ser superior o igual a ${min}.";

  static String m4(minLength) =>
      "El valor ha de tenir una longitud superior o igual a ${minLength}";

  static String m5(value) =>
      "Aquest valor de camp no ha de ser igual a ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Aquest camp requereix un número de targeta de crèdit vàlid."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Aquest camp requereix una cadena de data vàlida."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Aquest camp requereix una adreça de correu electrònic vàlida."),
        "equalErrorText": m0,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Aquest camp requereix un nombre enter vàlid."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Aquest camp requereix una IP vàlida."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "El valor no coincideix amb el patró."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("El valor ha de ser numèric."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Aquest camp no pot estar buit."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Aquest camp requereix una adreça URL vàlida.")
      };
}
