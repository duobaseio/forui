import 'package:flutter/foundation.dart';

@internal
class const ListKey<T>(final List<T> items) extends LocalKey {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is ListKey<T> && listEquals(other.items, items);
  }

  @override
  int get hashCode => Object.hashAll(items);

  @override
  String toString() => 'ListKey(${items.join(', ')})';
}

@internal
class const SetKey<T>(final Set<T> items) extends LocalKey {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is SetKey<T> && setEquals(other.items, items);
  }

  @override
  int get hashCode => Object.hashAll(items.toList()..sort((a, b) => a.hashCode.compareTo(b.hashCode)));

  @override
  String toString() => 'SetKey(${items.join(', ')})';
}
