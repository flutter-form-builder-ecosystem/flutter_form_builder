extension GenericValidator<T> on T? {
  bool emptyValidator() {
    if (this == null) return true;
    if (this is Iterable) return (this as Iterable<T>).isEmpty;
    if (this is String) return (this as String).isEmpty;
    if (this is List) return (this as List<T>).isEmpty;
    if (this is Map) return (this as Map<dynamic, dynamic>).isEmpty;
    if (this is Set) return (this as Set<T>).isEmpty;
    return false;
  }
}
