import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

part 'variant_platform.dart';

/// Represents a combination of variants under which a widget can be styled differently.
///
/// Users should generally use the provided widget-specific variants instead of this.
///
/// See also:
/// * [FVariants], which maps variant constraints to values.
sealed class FVariantConstraint {
  /// Returns the more specific of two constraints.
  ///
  /// Specificity is determined tier-by-tier from highest to lowest. At each tier, the constraint with more operands
  /// wins. This means a compound constraint with two tier-2 operands beats one with only one tier-2 operand, even if
  /// the latter has additional lower-tier operands.
  ///
  /// ```dart
  /// max(hovered, disabled); // disabled (tier 2 > tier 1)
  /// max(disabled.and(selected), disabled.and(hovered)); // disabled & selected (2 tier-2 operands > 1 tier-2 + 1 tier-1)
  /// ```
  ///
  /// If all tiers have equal counts, ties are broken by total operand count, then lexicographically by sorted operand
  /// names.
  ///
  /// ```dart
  /// max(hovered, hovered.and(focused)); // hovered & focused (2 > 1)
  /// max(hovered.and(focused), focused.and(pressed)); // focused & hovered ("focused" < "pressed")
  /// ```
  static T max<T extends FVariantConstraint>(T a, T b) {
    const maxTiers = 3;

    final operandsA = <String>[];
    final operandsB = <String>[];
    final tiersA = List.filled(maxTiers, 0);
    final tiersB = List.filled(maxTiers, 0);
    a._accept(operandsA, tiersA);
    b._accept(operandsB, tiersB);

    // Compare tier-by-tier from highest to lowest.
    for (var tier = maxTiers - 1; tier >= 0; tier--) {
      if (tiersA[tier] != tiersB[tier]) {
        return tiersA[tier] > tiersB[tier] ? a : b;
      }
    }

    // Fall back to total operand count.
    if (operandsA.length != operandsB.length) {
      return operandsA.length > operandsB.length ? a : b;
    }

    // Fall back to lexicographic comparison.
    operandsA.sort();
    operandsB.sort();

    return operandsA.join().compareTo(operandsB.join()) <= 0 ? a : b;
  }

  /// Returns true if this constraint is satisfied by [variants].
  ///
  /// ```dart
  /// final variants = {.hovered, .focused};
  ///
  /// .hovered.satisfiedBy(variants);                  // true
  /// .pressed.satisfiedBy(variants);                  // false
  /// .hovered.and(.focused).satisfiedBy(variants);    // true
  /// .hovered.and(.pressed).satisfiedBy(variants);    // false
  /// ```
  bool satisfiedBy(Set<FVariant> variants);

  void _accept(List<String> operands, List<int> tiers);
}

/// Represents a condition under which a widget can be styled differently.
///
/// Each variant has a tier that determines its specificity. Higher tiers take precedence over lower tiers.
/// Tiers typically follow: platform (tier 0) < interaction (tier 1) < semantic (tier 2).
///
/// Unlike [WidgetState], it is extended by widget-specific variants, allowing widgets to define their own states.
sealed class FVariant implements FVariantConstraint {
  /// Creates a variant.
  const factory FVariant(int priority, String value) = Value;
}

@internal
class Value implements FVariant {
  final int _tier;
  final String _value;

  const Value(this._tier, this._value);

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(this);

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands.add(_value);
    tiers[_tier] = tiers[_tier] + 1;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Value && runtimeType == other.runtimeType && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => _value;
}

@internal
class And implements FVariantConstraint {
  final FVariantConstraint _left;
  final FVariantConstraint _right;

  const And(this._left, this._right);

  @override
  bool satisfiedBy(Set<FVariant> variants) => _left.satisfiedBy(variants) && _right.satisfiedBy(variants);

  @override
  void _accept(List<String> operands, List<int> tiers) {
    _left._accept(operands, tiers);
    _right._accept(operands, tiers);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is And &&
          runtimeType == other.runtimeType &&
          ((_left == other._left && _right == other._right) || (_left == other._right && _right == other._left));

  @override
  int get hashCode => Object.hash(_left, _right);

  @override
  String toString() => '($_left & $_right)';
}

@internal
class Not implements FVariantConstraint {
  final FVariantConstraint _operand;

  const Not(this._operand);

  @override
  bool satisfiedBy(Set<FVariant> variants) => !_operand.satisfiedBy(variants);

  @override
  void _accept(List<String> operands, List<int> tiers) => _operand._accept(operands, tiers);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Not && runtimeType == other.runtimeType && _operand == other._operand;

  @override
  int get hashCode => _operand.hashCode;

  @override
  String toString() => '!$_operand';
}
