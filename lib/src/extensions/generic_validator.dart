extension GenericValidator<T> on T? {
  bool emptyValidator() {
    if (this == null) return true;
    if (this is Iterable) return (this as Iterable).isEmpty;
    if (this is String) return (this as String).isEmpty;
    if (this is List) return (this as List).isEmpty;
    if (this is Map) return (this as Map).isEmpty;
    if (this is Set) return (this as Set).isEmpty;
    return false;
  }
}
