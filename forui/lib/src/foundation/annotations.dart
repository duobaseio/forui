import 'package:meta/meta.dart';

@internal
class Variants {
  /// The widget the variants are associated with.
  final Type type;
  /// The variants and their associated documentation.
  final Map<String, String> variants;

  const Variants(this.type, this.variants);
}

@internal
class Sentinels {
  /// The nullable and their associated sentinel values, typically a const field name.
  final Map<String, String> values;

  const Sentinels(this.values);
}
