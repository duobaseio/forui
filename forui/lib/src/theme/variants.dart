import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
FVariants<K, E, V, D> createVariants<K extends FVariantConstraint, E extends FVariant, V, D extends Delta>(
  V base,
  Map<K, V> variants,
) => .raw(base, variants);

/// Maps variant constraints to values.
///
/// See also:
/// * [FVariantConstraint] which represents a combination of variants under which a widget is styled differently.
class FVariants<K extends FVariantConstraint, E extends FVariant, V, D extends Delta>
    with Diagnosticable
    implements FVariantsDelta<K, E, V, D>, FVariantsValueDelta<K, E, V, D> {
  /// Linearly interpolates between two [FVariants] containing [BoxDecoration]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, E, BoxDecoration, D>
  lerpBoxDecoration<K extends FVariantConstraint, E extends FVariant, D extends Delta>(
    FVariants<K, E, BoxDecoration, D> a,
    FVariants<K, E, BoxDecoration, D> b,
    double t,
  ) => lerpWhere(a, b, t, BoxDecoration.lerp);

  /// Linearly interpolates between two [FVariants] containing [Decoration]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, E, Decoration, D>
  lerpDecoration<K extends FVariantConstraint, E extends FVariant, D extends Delta>(
    FVariants<K, E, Decoration, D> a,
    FVariants<K, E, Decoration, D> b,
    double t,
  ) => lerpWhere(a, b, t, Decoration.lerp);

  /// Linearly interpolates between two [FVariants] containing [Color]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, E, Color, D> lerpColor<K extends FVariantConstraint, E extends FVariant, D extends Delta>(
    FVariants<K, E, Color, D> a,
    FVariants<K, E, Color, D> b,
    double t,
  ) => lerpWhere(a, b, t, FColors.lerpColor);

  /// Linearly interpolates between two [FVariants] containing [IconThemeData]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, E, IconThemeData, D>
  lerpIconThemeData<K extends FVariantConstraint, E extends FVariant, D extends Delta>(
    FVariants<K, E, IconThemeData, D> a,
    FVariants<K, E, IconThemeData, D> b,
    double t,
  ) => lerpWhere(a, b, t, IconThemeData.lerp);

  /// Linearly interpolates between two [FVariants] containing [TextStyle]s.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, E, TextStyle, D> lerpTextStyle<K extends FVariantConstraint, E extends FVariant, D extends Delta>(
    FVariants<K, E, TextStyle, D> a,
    FVariants<K, E, TextStyle, D> b,
    double t,
  ) => lerpWhere(a, b, t, TextStyle.lerp);

  /// Linearly interpolates between two [FVariants] using the given [lerp] function.
  ///
  /// {@macro forui.FVariants.lerpWhereUsing}
  static FVariants<K, E, V, D> lerpWhere<K extends FVariantConstraint, E extends FVariant, V, D extends Delta>(
    FVariants<K, E, V, D> a,
    FVariants<K, E, V, D> b,
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
  static T
  lerpWhereUsing<T extends FVariants<K, E, V, D>, K extends FVariantConstraint, E extends FVariant, V, D extends Delta>(
    FVariants<K, E, V, D> a,
    FVariants<K, E, V, D> b,
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

  /// Creates an [FVariants] with variants derived from deltas applied to [base].
  FVariants.from(this.base, {required Map<List<K>, D> variants})
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
  ///     [.hovered]: 'A',
  ///     [.hovered.and(.focused)]: 'B',
  ///     [.disabled]: 'C',
  ///   },
  /// );
  ///
  /// variants.resolve([.hovered]);           // 'A'
  /// variants.resolve([.hovered, .focused]); // 'B' (more tier-1 operands)
  /// variants.resolve([.hovered, .disabled]); // 'C' (tier 2 > tier 1)
  /// variants.resolve([.pressed]);           // 'base' (no match)
  /// ```
  @useResult
  V resolve(Iterable<FVariant> variants) {
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
  ///   .all(.delta(color: Colors.blue)),
  ///   .exact([.disabled], .delta(color: Colors.grey)),
  /// ]);
  /// ```
  ///
  /// See also:
  /// * [applyValues] for applying value-based operations.
  @useResult
  FVariants<K, E, V, D> apply(List<FVariantOperation<K, E, V, D>> operations) => FVariantsDelta.delta(operations)(this);

  /// Applies a sequence of value-based [operations] to this [FVariants].
  ///
  /// ```dart
  /// final updated = variants.applyValues([
  ///   .all(Colors.blue),
  ///   .exact([.disabled], Colors.grey),
  /// ]);
  /// ```
  ///
  /// See also:
  /// * [apply] for applying delta-based operations.
  @useResult
  FVariants<K, E, V, D> applyValues(List<FVariantValueDeltaOperation<K, E, V, D>> operations) =>
      FVariantsValueDelta<K, E, V, D>.delta(operations)(this);

  /// Returns a new [FVariants] with the variant type parameters cast to [T1] and [T2].
  ///
  /// ## Implementation details
  /// This is always valid if [T1] and [T2] are both extension types over [FVariantConstraint] and [FVariant] as in the
  /// case with the generated widget-specific variant constraints.
  FVariants<T1, T2, V, D> cast<T1 extends FVariantConstraint, T2 extends FVariant>() => this as FVariants<T1, T2, V, D>;

  @override
  FVariants<K, E, V, D> call(covariant FVariants<K, E, V, D> _) => this;


  @override
  FVariants<K, E, V, D> Function(V base, Map<K, V> variants) get _call =>
          (_, _) => this;

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
      other is FVariants<K, E, V, D> &&
          runtimeType == other.runtimeType &&
          base == other.base &&
          mapEquals(variants, other.variants);

  @override
  int get hashCode => Object.hash(base, Object.hashAllUnordered(variants.entries));
}

/// Describes modifications to an [FVariants] in terms of deltas.
class FVariantsDelta<K extends FVariantConstraint, E extends FVariant, V, D extends Delta> with Delta {
  final FVariants<K, E, V, D> Function(V base, Map<K, V> variants) _call;

  /// Creates a sequence of concrete modifications to [FVariants].
  FVariantsDelta.delta(List<FVariantOperation<K, E, V, D>> operations)
    : _call = ((base, variants) {
        for (final operation in operations) {
          final result = operation._call(base, variants);
          base = result.base;
          variants = result.variants;
        }

        return .raw(base, variants);
      });

  @override
  FVariants<K, E, V, D> call(covariant FVariants<K, E, V, D> variants) => _call(variants.base, variants.variants);
}

/// An operation in [FVariantsDelta.delta] that modifies [FVariants] using deltas.
class FVariantOperation<K extends FVariantConstraint, E extends FVariant, V, D extends Delta> {
  final FVariants<K, E, V, D> Function(V base, Map<K, V> variants) _call;

  /// Applies [delta] to the base without modifying existing variants.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2}
  /// .base(Delta(10)) // base: 10, {a: 1, b: 2}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.exact] for setting exact constraint entries.
  /// * [FVariantOperation.match] for applying to variants whose constraint's variants are all present.
  /// * [FVariantOperation.variants] for applying to all variants.
  /// * [FVariantOperation.all] for applying to all variants and base.
  FVariantOperation.base(D delta) : _call = ((base, existing) => .raw(delta(base) as V, {...existing}));

  /// Applies [delta] to the base and associates the result with each constraint in [constraints].
  ///
  /// Unlike [FVariantOperation.match], this creates exact entries rather than matching existing variants.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 1}
  /// .exact([b, c], Delta(2)) // {a: 1, b: 2, c: 2}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.match] for applying to variants whose constraint's variants are all present.
  /// * [FVariantOperation.base] for applying to the base.
  /// * [FVariantOperation.variants] for applying to all variants.
  /// * [FVariantOperation.all] for applying to all variants and base.
  FVariantOperation.exact(Iterable<K> constraints, D delta)
    : _call = ((base, existing) {
        final addition = delta(base) as V;
        return .raw(base, {...existing, for (final constraint in constraints) constraint: addition});
      });

  /// Applies [delta] to existing variants whose constraint's variants are all present in [variants].
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3, a & b: 4, a & c: 5}
  /// .match([a, b], AddDelta(10)) // base: 0, {a: 11, b: 12, c: 3, a & b: 14, a & c: 5}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.exact] for setting exact constraint entries.
  /// * [FVariantOperation.base] for applying to the base.
  /// * [FVariantOperation.variants] for applying to all variants.
  /// * [FVariantOperation.all] for applying to all variants and base.
  FVariantOperation.match(Iterable<E> variants, D delta)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries)
          constraint: constraint.satisfiedBy(variants) ? delta(value) as V : value,
      }));

  /// Applies [delta] to all existing variants.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3}
  /// .variants(AddDelta(10)) // base: 0, {a: 11, b: 12, c: 13}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.exact] for setting exact constraint entries.
  /// * [FVariantOperation.match] for applying to variants whose constraint's variants are all present.
  /// * [FVariantOperation.base] for applying to the base.
  /// * [FVariantOperation.all] for applying to all variants and base.
  FVariantOperation.variants(D delta)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries) constraint: delta(value) as V,
      }));

  /// Applies [delta] to all variants and base.
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3}
  /// .all(AddDelta(10)) // base: 10, {a: 11, b: 12, c: 13}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.exact] for setting exact constraint entries.
  /// * [FVariantOperation.match] for applying to variants whose constraint's variants are all present.
  /// * [FVariantOperation.base] for applying to the base.
  /// * [FVariantOperation.variants] for applying to all variants.
  FVariantOperation.all(D delta)
    : _call = ((base, existing) => .raw(delta(base) as V, {
        for (final MapEntry(key: constraint, :value) in existing.entries) constraint: delta(value) as V,
      }));

  /// Removes exact [constraints] from existing variants.
  ///
  /// Unlike [FVariantOperation.removeMatch], this removes exact entries rather than matching existing variants.
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3}
  /// .remove([a, b]) // {c: 3}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.removeMatch] for removing variants whose constraint's variants are all present.
  /// * [FVariantOperation.removeAll] for removing all variants.
  FVariantOperation.remove(Iterable<K> constraints)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries)
          if (!constraints.contains(constraint)) constraint: value,
      }));

  /// Removes existing variants whose constraint's variants are all present in [variants].
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3, a & b: 4, a & c: 5}
  /// .removeMatch([a, b]) // {c: 3, a & c: 5}
  /// ```
  ///
  /// See also:
  /// * [FVariantOperation.remove] for removing exact constraint entries.
  /// * [FVariantOperation.removeAll] for removing all variants.
  FVariantOperation.removeMatch(Iterable<E> variants)
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
  /// * [FVariantOperation.removeMatch] for removing variants whose constraint's variants are all present.
  FVariantOperation.removeAll() : _call = ((base, _) => .raw(base, {}));
}

/// A delta that describes modifications to an [FVariants] in terms of concrete values.
class FVariantsValueDelta<K extends FVariantConstraint, E extends FVariant, V, D extends Delta> with Delta {
  final FVariants<K, E, V, D> Function(V base, Map<K, V> variants) _call;

  /// Creates a sequence of modifications to [FVariants].
  FVariantsValueDelta.delta(List<FVariantValueDeltaOperation<K, E, V, D>> operations)
    : _call = ((base, variants) {
        for (final operation in operations) {
          final result = operation._call(base, variants);
          base = result.base;
          variants = result.variants;
        }

        return .raw(base, variants);
      });

  @override
  FVariants<K, E, V, D> call(covariant FVariants<K, E, V, D> variants) => _call(variants.base, variants.variants);
}

/// An operation in [FVariantsValueDelta.delta] that modifies [FVariants] using concrete values.
class FVariantValueDeltaOperation<K extends FVariantConstraint, E extends FVariant, V, D extends Delta> {
  final FVariants<K, E, V, D> Function(V base, Map<K, V> variants) _call;

  /// Replaces the base with [base].
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2}
  /// .base(10) // base: 10, {a: 1, b: 2}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.exact] for setting exact constraint entries.
  /// * [FVariantValueDeltaOperation.match] for replacing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.variants] for replacing all variants.
  /// * [FVariantValueDeltaOperation.all] for replacing all variants and base.
  FVariantValueDeltaOperation.base(V base) : _call = ((_, variants) => .raw(base, {...variants}));

  /// Sets [value] for each constraint in [constraints], creating or overriding entries.
  ///
  /// Unlike [FVariantValueDeltaOperation.match], this creates exact entries rather than matching existing variants.
  ///
  /// ```dart
  /// // Given {a: 1, b: 1}
  /// .exact([b, c], 2) // {a: 1, b: 2, c: 2}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.base] for replacing the base.
  /// * [FVariantValueDeltaOperation.match] for replacing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.variants] for replacing all variants.
  /// * [FVariantValueDeltaOperation.all] for replacing all variants and base.
  FVariantValueDeltaOperation.exact(Iterable<K> constraints, V value)
    : _call = ((base, existing) => .raw(base, {...existing, for (final constraint in constraints) constraint: value}));

  /// Replaces existing variants whose constraint's variants are all present in [variants].
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3, a & b: 4, a & c: 5}
  /// .match([a, b], 10) // {a: 10, b: 10, c: 3, a & b: 10, a & c: 5}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.exact] for setting exact constraint entries.
  /// * [FVariantValueDeltaOperation.base] for replacing the base.
  /// * [FVariantValueDeltaOperation.variants] for replacing all variants.
  /// * [FVariantValueDeltaOperation.all] for replacing all variants and base.
  FVariantValueDeltaOperation.match(Iterable<E> variants, V value)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, value: v) in existing.entries)
          constraint: constraint.satisfiedBy(variants) ? value : v,
      }));

  /// Replaces all variants with [value].
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2, c: 3}
  /// .variants(10) // base: 0, {a: 10, b: 10, c: 10}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.exact] for setting exact constraint entries.
  /// * [FVariantValueDeltaOperation.match] for replacing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.base] for replacing the base.
  /// * [FVariantValueDeltaOperation.all] for replacing all variants and base.
  FVariantValueDeltaOperation.variants(V value)
    : _call = ((base, variants) => .raw(base, {for (final key in variants.keys) key: value}));

  /// Replaces all variants and base with [value].
  ///
  /// ```dart
  /// // Given base: 0, {a: 1, b: 2
  /// .all(10) // base: 10, {a: 10, b: 10}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.exact] for setting exact constraint entries.
  /// * [FVariantValueDeltaOperation.match] for replacing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.base] for replacing the base.
  /// * [FVariantValueDeltaOperation.variants] for replacing all variants.
  FVariantValueDeltaOperation.all(V value)
    : _call = ((_, variants) => .raw(value, {for (final key in variants.keys) key: value}));

  /// Removes exact [constraints] from existing variants.
  ///
  /// Unlike [FVariantValueDeltaOperation.removeMatch], this removes exact entries rather than matching existing variants.
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3}
  /// .remove([a, b]) // {c: 3}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.removeMatch] for removing variants whose constraint's variants are all present.
  /// * [FVariantValueDeltaOperation.removeAll] for removing all variants.
  FVariantValueDeltaOperation.remove(Iterable<K> constraints)
    : _call = ((base, existing) => .raw(base, {
        for (final MapEntry(key: constraint, :value) in existing.entries)
          if (!constraints.contains(constraint)) constraint: value,
      }));

  /// Removes existing variants whose constraint's variants are all present in [variants].
  ///
  /// ```dart
  /// // Given {a: 1, b: 2, c: 3, a & b: 4, a & c: 5}
  /// .removeMatch([a, b]) // {c: 3, a & c: 5}
  /// ```
  ///
  /// See also:
  /// * [FVariantValueDeltaOperation.remove] for removing exact constraint entries.
  /// * [FVariantValueDeltaOperation.removeAll] for removing all variants.
  FVariantValueDeltaOperation.removeMatch(Iterable<E> variants)
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
  /// * [FVariantValueDeltaOperation.removeMatch] for removing variants whose constraint's variants are all present.
  FVariantValueDeltaOperation.removeAll() : _call = ((base, _) => .raw(base, {}));
}
