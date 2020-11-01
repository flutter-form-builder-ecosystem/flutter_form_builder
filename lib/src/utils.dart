String enumValueToString(Object o) {
  return o.toString().split('.').last;
}

T enumValueFromString<T>(String key, Iterable<T> values) {
  return values.firstWhere(
    (v) => v != null && key == enumValueToString(v),
    orElse: () => null,
  );
}
