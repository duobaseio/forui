import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
FVariants<K, V, D> createVariants<K extends FVariantConstraint, V, D extends Delta>(V base, Map<K, V> variants) =>
    .raw(base, variants);

/// Maps variant constraints to values.
///
/// See also:
/// * [FVariantConstraint] which represents a combination of variants under which a widget is styled differently.
class FVariants<K extends FVariantConstraint, V, D extends Delta> with Diagnosticable {
  /// Linearly interpolates between two [FVariants] containing [BoxDecoration]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, BoxDecoration, D> lerpBoxDecoration<K extends FVariantConstraint, D extends Delta>(
    FVariants<K, BoxDecoration, D> a,
    FVariants<K, BoxDecoration, D> b,
    double t,
  ) => lerpWhere(a, b, t, BoxDecoration.lerp);

  /// Linearly interpolates between two [FVariants] containing [Decoration]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, Decoration, D> lerpDecoration<K extends FVariantConstraint, D extends Delta>(
    FVariants<K, Decoration, D> a,
    FVariants<K, Decoration, D> b,
    double t,
  ) => lerpWhere(a, b, t, Decoration.lerp);

  /// Linearly interpolates between two [FVariants] containing [Color]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, Color, D> lerpColor<K extends FVariantConstraint, D extends Delta>(
    FVariants<K, Color, D> a,
    FVariants<K, Color, D> b,
    double t,
  ) => lerpWhere(a, b, t, FColors.lerpColor);

  /// Linearly interpolates between two [FVariants] containing [IconThemeData]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, IconThemeData, D> lerpIconThemeData<K extends FVariantConstraint, D extends Delta>(
    FVariants<K, IconThemeData, D> a,
    FVariants<K, IconThemeData, D> b,
    double t,
  ) => lerpWhere(a, b, t, IconThemeData.lerp);

  /// Linearly interpolates between two [FVariants] containing [TextStyle]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, TextStyle, D> lerpTextStyle<K extends FVariantConstraint, D extends Delta>(
    FVariants<K, TextStyle, D> a,
    FVariants<K, TextStyle, D> b,
    double t,
  ) => lerpWhere(a, b, t, TextStyle.lerp);

  /// Linearly interpolates between two [FVariants] using the given [lerp] function.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, V, D> lerpWhere<K extends FVariantConstraint, V, D extends Delta>(
    FVariants<K, V, D> a,
    FVariants<K, V, D> b,
    double t,
    V? Function(V?, V?, double) lerp,
  ) => lerpWhereUsing(a, b, t, lerp, FVariants.raw);

  /// Linearly interpolates between two [T] using the given [lerp] and [supply] function.
  ///
  /// {@template forui.FVariants.lerpWhereUsing}
  /// Only keys present in both [a] and [b] are lerped.
  /// {@endtemplate}
  ///
  /// See:
  /// * [lerpWhere] for a version that returns [FVariants].
  static T lerpWhereUsing<T extends FVariants<K, V, D>, K extends FVariantConstraint, V, D extends Delta>(
    FVariants<K, V, D> a,
    FVariants<K, V, D> b,
    double t,
    V? Function(V?, V?, double) lerp,
    T Function(V base, Map<K, V> variants) supply,
  ) {
    final base = lerp(a.base, b.base, t);
    final variants = <K, V>{};

    // V is V?. Casts are necessary as flow typing isn't smart enough to propagate this check.
    if (null is V) {
      for (final key in a.variants.keys) {
        if (b.variants.containsKey(key)) {
          variants[key] = lerp(a.variants[key], b.variants[key], t) as V;
        }
      }

      return supply(base as V, variants);
    } else {
      for (final key in a.variants.keys) {
        if (b.variants.containsKey(key)) {
          if (lerp(a.variants[key], b.variants[key], t) case final lerped?) {
            variants[key] = lerped;
          }
        }
      }

      return supply(base ?? (t < 0.5 ? a.base : b.base), variants);
    }
  }

  /// The base variant.
  final V base;

  /// The variants.
  final Map<K, V> variants;

  /// Creates an [FVariants] with concrete variants.
  FVariants(this.base, {required Map<List<K>, V> variants})
    : variants = {
        for (final MapEntry(key: constraints, :value) in variants.entries)
          for (final constraint in constraints) constraint: value,
      };

  /// Creates an [FVariants] with variants created from deltas applied to [base].
  FVariants.delta(this.base, {required Map<List<K>, D> variants})
    : variants = (() {
        final map = <K, V>{};
        for (final MapEntry(key: constraints, value: delta) in variants.entries) {
          final variant = delta(base) as V;
          for (final constraint in constraints) {
            map[constraint] = variant;
          }
        }

        return map;
      }());

  /// Creates an [FVariants] with only a base variant.
  const FVariants.all(this.base) : variants = const {};

  /// Creates an [FVariants] with raw variants.
  const FVariants.raw(this.base, this.variants);

  /// Returns most specific matching variant, or [base] if no constraints match.
  ///
  /// {@macro forui.theme.FVariantConstraint.max}
  ///
  /// ```dart
  /// final variants = FVariants(
  ///   'base',
  ///   variants: {
  ///     {.hovered}: 'A',
  ///     {.hovered.and(.focused)}: 'B',
  ///     {.disabled}: 'C',
  ///   },
  /// );
  ///
  /// variants.resolve({.hovered});           // 'A'
  /// variants.resolve({.hovered, .focused}); // 'B' (more tier-1 operands)
  /// variants.resolve({.hovered, .disabled}); // 'C' (tier 2 > tier 1)
  /// variants.resolve({.pressed});           // 'base' (no match)
  /// ```
  @useResult
  V resolve(Set<FVariant> variants) {
    K? constraint;
    V? variant;
    for (final MapEntry(key: current, :value) in this.variants.entries) {
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

  /// Applies a sequence of delta-based [operations] to this [FVariants].
  ///
  /// ```dart
  /// final updated = variants.apply([
  ///   .onAll(.delta(color: Colors.blue)),
  ///   .on({.disabled}, .delta(color: Colors.grey)),
  /// ]);
  /// ```
  ///
  /// See also:
  /// * [applyValues] for applying value-based operations.
  @useResult
  FVariants<K, V, D> apply<E extends FVariant>(List<FVariantOperation<K, E, V, D>> operations) =>
      FVariantsDelta.apply(operations)(this);

  /// Applies a sequence of value-based [operations] to this [FVariants].
  ///
  /// ```dart
  /// final updated = variants.applyValues([
  ///   .onAll(Colors.blue),
  ///   .on({.disabled}, Colors.grey),
  /// ]);
  /// ```
  ///
  /// See also:
  /// * [apply] for applying delta-based operations.
  @useResult
  FVariants<K, V, Delta> applyValues<E extends FVariant>(List<FVariantValueDeltaOperation<K, E, V>> operations) =>
      FVariantsValueDelta.apply(operations)(this);

  /// Returns a new [FVariants] with the constraint type parameter cast to [T].
  ///
  /// ## Implementation details
  /// This is always valid if [K] and [T] are both extension types over [FVariantConstraint] as in the case with the
  /// generated widget-specific variant constraints.
  FVariants<T, V, D> cast<T extends FVariantConstraint>() => this as FVariants<T, V, D>;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('base', base))
      ..add(IterableProperty('variants', variants.entries));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FVariants<K, V, D> &&
          runtimeType == other.runtimeType &&
          base == other.base &&
          mapEquals(variants, other.variants);

  @override
  int get hashCode => Object.hash(base, Object.hashAllUnordered(variants.entries));
}

/// Describes modifications to an [FVariants] in terms of deltas.
class FVariantsDelta<K extends FVariantConstraint, E extends FVariant, V, D extends Delta> with Delta {
  final FVariants<K, V, D> Function(V base, Map<K, V> variants) _call;

  /// Creates a complete replacement of a [FVariants].
  FVariantsDelta.value(FVariants<K, V, D> variants) : _call = ((_, _) => variants);

  /// Creates a sequence of concrete modifications to [FVariants].
  FVariantsDelta.apply(List<FVariantOperation<K, E, V, D>> operations)
    : _call = ((base, variants) {
        for (final operation in operations) {
          final result = operation._call(base, variants);
          base = result.base;
          variants = result.variants;
        }

        return .raw(base, variants);
      });

  @override
  FVariants<K, V, D> call(covariant FVariants<K, V, D> variants) => _call(variants.base, variants.variants);
}

/// An operation in [FVariantsDelta.apply] that modifies [FVariants] using deltas.
class FVariantOperation<K extends FVariantConstraint, E extends FVariant, V, D extends Delta> {
  final FVariants<K, V, D> Function(V base, Map<K, V> variants) _call;

  /// Applies [delta] to the base without modifying existing variants.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2}
  /// .onBase(Delta(10)) // base: 10, {a: 1, b: 2}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.on] for setting exact constraint entries.
  /// * [FVariantOperation.onMatching] for applying to variants whose constraint's variants are all present.
  /// * [FVariantOperation.onVariants] for applying to all variants.
  /// * [FVariantOperation.onAll] for applying to all variants and base.
  FVariantOperation.onBase(D delta) : _call = ((base, existing) => .raw(delta(base) as V, {...existing}));

  /// Applies [delta] to the base and associates the result with each constraint in [constraints].
  ///
  /// Unlike [FVariantOperation.onMatching], this creates exact entries rather than matching existing variants.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 1}
  /// .on({b, c}, Delta(2)) // {a: 1, b: 2, c: 2}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.onMatching] for applying to variants whose constraint's variants are all present.
  /// * [FVariantOperation.onBase] for applying to the base.
  /// * [FVariantOperation.onVariants] for applying to all variants.
  /// * [FVariantOperation.onAll] for applying to all variants and base.
  FVariantOperation.on(Set<K> constraints, D delta)
    : _call = ((base, existing) {
        final addition = delta(base) as V;
        return .raw(base, {...existing, for (final constraint in constraints) constraint: addition});
      });

  /// Applies [delta] to existing variants whose constraint's variants are all present in [variants].
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3, a & b: 4, a & c: 5}
  /// .onMatching({a, b}, AddDelta(10)) // base: 0, {a: 11, b: 12, c: 3, a & b: 14, a & c: 5}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.on] for setting exact constraint entries.
  /// * [FVariantOperation.onBase] for applying to the base.
  /// * [FVariantOperation.onVariants] for applying to all variants.
  /// * [FVariantOperation.onAll] for applying to all variants and base.
  FVariantOperation.onMatching(Set<E> variants, D delta)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries)
          constraint: constraint.satisfiedBy(variants) ? delta(value) as V : value,
      }));

  /// Applies [delta] to all existing variants.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3}
  /// .onVariants(AddDelta(10)) // base: 0, {a: 11, b: 12, c: 13}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.on] for setting exact constraint entries.
  /// * [FVariantOperation.onMatching] for applying to variants whose constraint's variants are all present.
  /// * [FVariantOperation.onBase] for applying to the base.
  /// * [FVariantOperation.onAll] for applying to all variants and base.
  FVariantOperation.onVariants(D delta)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries) constraint: delta(value) as V,
      }));

  /// Applies [delta] to all variants and base.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3}
  /// .onAll(AddDelta(10)) // base: 10, {a: 11, b: 12, c: 13}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.on] for setting exact constraint entries.
  /// * [FVariantOperation.onMatching] for applying to variants whose constraint's variants are all present.
  /// * [FVariantOperation.onBase] for applying to the base.
  /// * [FVariantOperation.onVariants] for applying to all variants.
  FVariantOperation.onAll(D delta)
    : _call = ((base, existing) => .raw(delta(base) as V, {
        for (final MapEntry(key: constraint, :value) in existing.entries) constraint: delta(value) as V,
      }));

  /// Removes exact [constraints] from existing variants.
  ///
  /// Unlike [FVariantOperation.removeMatching], this removes exact entries rather than matching existing variants.
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3}
  /// .remove({a, b}) // {c: 3}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.removeMatching] for removing variants whose constraint's variants are all present.
  /// * [FVariantOperation.removeAll] for removing all variants.
  FVariantOperation.remove(Set<K> constraints)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries)
          if (!constraints.contains(constraint)) constraint: value,
      }));

  /// Removes existing variants whose constraint's variants are all present in [variants].
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3, a & b: 4, a & c: 5}
  /// .removeMatching({a, b}) // {c: 3, a & c: 5}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.remove] for removing exact constraint entries.
  /// * [FVariantOperation.removeAll] for removing all variants.
  FVariantOperation.removeMatching(Set<E> variants)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries)
          if (!constraint.satisfiedBy(variants)) constraint: value,
      }));

  /// Removes all existing variants.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3}
  /// .removeAll() // base: 0, {}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.remove] for removing exact constraint entries.
  /// * [FVariantOperation.removeMatching] for removing variants whose constraint's variants are all present.
  FVariantOperation.removeAll() : _call = ((base, _) => .raw(base, {}));
}

/// A delta that describes modifications to an [FVariants] in terms of concrete values.
class FVariantsValueDelta<K extends FVariantConstraint, E extends FVariant, V> with Delta {
  final FVariants<K, V, Delta> Function(V base, Map<K, V> variants) _call;

  /// Creates a complete replacement of a [FVariants].
  FVariantsValueDelta.value(FVariants<K, V, Delta> variants) : _call = ((_, _) => variants);

  /// Creates a sequence of modifications to [FVariants].
  FVariantsValueDelta.apply(List<FVariantValueDeltaOperation<K, E, V>> operations)
    : _call = ((base, variants) {
        for (final operation in operations) {
          final result = operation._call(base, variants);
          base = result.base;
          variants = result.variants;
        }

        return .raw(base, variants);
      });

  @override
  FVariants<K, V, Delta> call(covariant FVariants<K, V, Delta> variants) => _call(variants.base, variants.variants);
}

/// An operation in [FVariantsValueDelta.apply] that modifies [FVariants] using concrete values.
class FVariantValueDeltaOperation<K extends FVariantConstraint, E extends FVariant, V> {
  final FVariants<K, V, Delta> Function(V base, Map<K, V> variants) _call;

  /// Replaces the base with [base].
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2}
  /// .onBase(10) // base: 10, {a: 1, b: 2}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.on] for setting exact constraint entries.
  /// * [FVariantValueDeltaOperation.onMatching] for replacing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.onVariants] for replacing all variants.
  /// * [FVariantValueDeltaOperation.onAll] for replacing all variants and base.
  FVariantValueDeltaOperation.onBase(V base) : _call = ((_, variants) => .raw(base, {...variants}));

  /// Sets [value] for each constraint in [constraints], creating or overriding entries.
  ///
  /// Unlike [FVariantValueDeltaOperation.onMatching], this creates exact entries rather than matching existing variants.
  ///
  /// ```dart
  /// // Given {a: 1, b: 1}
  /// .on({b, c}, 2) // {a: 1, b: 2, c: 2}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.onBase] for replacing the base.
  /// * [FVariantValueDeltaOperation.onMatching] for replacing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.onVariants] for replacing all variants.
  /// * [FVariantValueDeltaOperation.onAll] for replacing all variants and base.
  FVariantValueDeltaOperation.on(Set<K> constraints, V value)
    : _call = ((base, existing) => .raw(base, {...existing, for (final constraint in constraints) constraint: value}));

  /// Replaces existing variants whose constraint's variants are all present in [variants].
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3, a & b: 4, a & c: 5}
  /// .onMatching({a, b}, 10) // {a: 10, b: 10, c: 3, a & b: 10, a & c: 5}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.on] for setting exact constraint entries.
  /// * [FVariantValueDeltaOperation.onBase] for replacing the base.
  /// * [FVariantValueDeltaOperation.onVariants] for replacing all variants.
  /// * [FVariantValueDeltaOperation.onAll] for replacing all variants and base.
  FVariantValueDeltaOperation.onMatching(Set<E> variants, V value)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, value: v) in existing.entries)
          constraint: constraint.satisfiedBy(variants) ? value : v,
      }));

  /// Replaces all variants with [value].
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3}
  /// .onVariants(10) // base: 0, {a: 10, b: 10, c: 10}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.on] for setting exact constraint entries.
  /// * [FVariantValueDeltaOperation.onMatching] for replacing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.onBase] for replacing the base.
  /// * [FVariantValueDeltaOperation.onAll] for replacing all variants and base.
  FVariantValueDeltaOperation.onVariants(V value)
    : _call = ((base, variants) => .raw(base, {for (final key in variants.keys) key: value}));

  /// Replaces all variants and base with [value].
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2
  /// .onAll(10) // base: 10, {a: 10, b: 10}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.on] for setting exact constraint entries.
  /// * [FVariantValueDeltaOperation.onMatching] for replacing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.onBase] for replacing the base.
  /// * [FVariantValueDeltaOperation.onVariants] for replacing all variants.
  FVariantValueDeltaOperation.onAll(V value)
    : _call = ((_, variants) => .raw(value, {for (final key in variants.keys) key: value}));

  /// Removes exact [constraints] from existing variants.
  ///
  /// Unlike [FVariantValueDeltaOperation.removeMatching], this removes exact entries rather than matching existing variants.
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3}
  /// .remove({a, b}) // {c: 3}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.removeMatching] for removing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.removeAll] for removing all variants.
  FVariantValueDeltaOperation.remove(Set<K> constraints)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries)
          if (!constraints.contains(constraint)) constraint: value,
      }));

  /// Removes existing variants whose constraint's variants are all present in [variants].
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3, a & b: 4, a & c: 5}
  /// .removeMatching({a, b}) // {c: 3, a & c: 5}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.remove] for removing exact constraint entries.
  /// * [FVariantValueDeltaOperation.removeAll] for removing all variants.
  FVariantValueDeltaOperation.removeMatching(Set<E> variants)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries)
          if (!constraint.satisfiedBy(variants)) constraint: value,
      }));

  /// Removes all existing variants.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3}
  /// .removeAll() // {}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.remove] for removing exact constraint entries.
  /// * [FVariantValueDeltaOperation.removeMatching] for removing variants whose constraint's variants are all present.
  FVariantValueDeltaOperation.removeAll() : _call = ((base, _) => .raw(base, {}));
}
