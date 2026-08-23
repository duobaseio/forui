import 'package:meta/meta.dart';

@internal
class const Variants(
  /// The variant's prefix, i.e. `<prefix>Variant` and `<prefix>VariantConstraint`.
  final String prefix,

  /// The variants and their associated tier and documentation.
  final Map<String, (int, String)> variants,
);

@internal
class const SentinelValues(
  /// The corresponding style.
  final Type style,

  /// The field name and their associated sentinel values which is typically a const field name.
  final Map<String, String> values,
);
