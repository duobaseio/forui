import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

class _Variants<C extends FVariantConstraint, T> with Diagnosticable {
  /// The base value.
  final T base;
  final Map<C, T> _variants;

  _Variants(this.base, this._variants);

  T resolve(Set<FVariant> variants) {
    C? constraint;
    T? variant;
    for (final MapEntry(key: current, :value) in _variants.entries) {
      if (!current.satisfiedBy(variants)) {
        continue;
      }

      if (constraint == null || FVariantConstraint.max(constraint, current) != constraint) {
        constraint = current;
        variant = value;
      }
    }

    return variant ?? base;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('base', base))
      ..add(IterableProperty('variants', _variants.entries));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Variants<C, T> &&
          runtimeType == other.runtimeType &&
          base == other.base &&
          mapEquals(_variants, other._variants);

  @override
  int get hashCode => Object.hash(base, Object.hashAllUnordered(_variants.entries));
}

/// Maps constraints to deltas that are applied to a base value.
///
/// See also:
/// * [FLiteralVariants], which maps constraints to concrete values.
/// * [FVariantConstraint], which represents a condition under which a widget is styled differently.
class FVariants<C extends FVariantConstraint, T, D extends Delta<T>> extends _Variants<C, T> {
  /// Creates an [FVariants].
  FVariants(T base, {required Map<Set<C>, D> deltas})
    : super(base, {
        for (final MapEntry(key: constraints, :value) in deltas.entries)
          for (final constraint in constraints) constraint: value.apply(base),
      });

  /// Returns [base] with the most specific matching delta applied, or [base] if no constraints match.
  ///
  /// ## Resolution
  /// Resolution uses a **most-specific-wins strategy**, i.e. the constraint with the highest operand count wins. Ties
  /// are broken lexicographically.
  ///
  /// ```dart
  /// final variants = FVariants(
  ///   'base',
  ///   deltas: {
  ///     {.hovered}: A(),                // operands: 1
  ///     {.hovered.and(.focused) }: B(), // operands: 2
  ///   },
  /// );
  ///
  /// variants.resolve({.hovered});           // A applied
  /// variants.resolve({.hovered, .focused}); // B applied (more specific)
  /// variants.resolve({.pressed});           // base returned (no match)
  /// ```
  @override
  @useResult
  T resolve(Set<FVariant> variants) => super.resolve(variants);
}

/// Maps variant constraints to concrete values.
///
/// See also:
/// * [FVariants], which maps constraints to deltas.
/// * [FVariantConstraint], which represents a condition under which a widget is styled differently.
class FLiteralVariants<C extends FVariantConstraint, T> extends _Variants<C, T> {
  /// Creates an [FLiteralVariants].
  FLiteralVariants(T base, {required Map<Set<C>, T> values})
    : super(base, {
        for (final MapEntry(key: constraints, :value) in values.entries)
          for (final constraint in constraints) constraint: value,
      });

  /// Returns value with the most specific matching delta applied, or [base] if no constraints match.
  ///
  /// ## Resolution
  /// Resolution uses a **most-specific-wins strategy**, i.e. the constraint with the highest operand count wins. Ties
  /// are broken lexicographically.
  ///
  /// ```dart
  /// final variants = FVariants(
  ///   'base',
  ///   deltas: {
  ///     {.hovered}: A(),                // operands: 1
  ///     {.hovered.and(.focused) }: B(), // operands: 2
  ///   },
  /// );
  ///
  /// variants.resolve({.hovered});           // A applied
  /// variants.resolve({.hovered, .focused}); // B applied (more specific)
  /// variants.resolve({.pressed});           // base returned (no match)
  /// ```
  @override
  @useResult
  T resolve(Set<FVariant> variants) => super.resolve(variants);
}
