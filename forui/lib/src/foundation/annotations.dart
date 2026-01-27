import 'package:meta/meta.dart';

@internal
class Variants {
  /// The widget the variants are associated with.
  final Type widget;

  /// The variants and their associated tier and documentation.
  final Map<String, (int, String)> variants;

  const Variants(this.widget, this.variants);
}

@internal
class Sentinels {
  /// The corresponding style.
  final Type style;

  /// The field name and their associated sentinel values which is typically a const field name.
  final Map<String, String> values;

  const Sentinels(this.style, this.values);
}
