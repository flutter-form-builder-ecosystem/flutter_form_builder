import 'package:flutter/foundation.dart';

T enumValueFromString<T>(String key, Iterable<T> values) {
  return values.firstWhere(
    (v) => v != null && key == describeEnum(v),
    orElse: () => null,
  );
}
