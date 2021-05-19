// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m1(max) => "O valor deve ser menor ou igual a ${max}";

  static String m2(maxLength) =>
      "O valor deve ter um comprimento menor ou igual a ${maxLength}";

  static String m3(min) => "O valor deve ser maior ou igual a ${min}.";

  static String m4(minLength) =>
      "O valor deve ter um comprimento maior ou igual a ${minLength}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Este campo requer um número de cartão de crédito válido."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Este campo requer uma string de data válida."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Este campo requer um endereço de e-mail válido."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Este campo requer um IP válido."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "O valor não corresponde ao padrão."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("O valor deve ser numérico."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Este campo não pode ficar vazio."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Este campo requer um endereço de URL válido.")
      };
}
