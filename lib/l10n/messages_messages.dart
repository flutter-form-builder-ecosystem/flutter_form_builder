// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  static m4(value) => "This field value must be equal to ${value}.";

  static m0(max) => "Value must be less than or equal to ${max}";

  static m1(maxLength) => "Value must have a length less than or equal to ${maxLength}";

  static m2(min) => "Value must be greater than or equal to ${min}.";

  static m3(minLength) => "Value must have a length greater than or equal to ${minLength}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "creditCardErrorText" : MessageLookupByLibrary.simpleMessage("This field requires a valid credit card number."),
    "dateStringErrorText" : MessageLookupByLibrary.simpleMessage("This field requires a valid date string."),
    "emailErrorText" : MessageLookupByLibrary.simpleMessage("This field requires a valid email address."),
    "equalErrorText" : m4,
    "integerErrorText" : MessageLookupByLibrary.simpleMessage("Value must be an integer."),
    "ipErrorText" : MessageLookupByLibrary.simpleMessage("This field requires a valid IP."),
    "matchErrorText" : MessageLookupByLibrary.simpleMessage("Value does not match pattern."),
    "maxErrorText" : m0,
    "maxLengthErrorText" : m1,
    "minErrorText" : m2,
    "minLengthErrorText" : m3,
    "numericErrorText" : MessageLookupByLibrary.simpleMessage("Value must be numeric."),
    "requiredErrorText" : MessageLookupByLibrary.simpleMessage("This field cannot be empty."),
    "urlErrorText" : MessageLookupByLibrary.simpleMessage("This field requires a valid URL address.")
  };
}
