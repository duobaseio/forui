import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// Represents a combination of variants under which a widget is styled differently.
///
/// Users should generally use the provided widget-specific variants instead of this.
///
/// See also:
/// * [FVariants], which maps variant constraints to values.
sealed class FVariantConstraint {
  /// The Android platform variant.
  static const FVariant android = FVariant('android');

  /// The iOS platform variant.
  static const FVariant ios = FVariant('ios');

  /// The Fuchsia platform variant.
  static const FVariant fuchsia = FVariant('fuchsia');

  /// The Windows platform variant.
  static const FVariant windows = FVariant('windows');

  /// The macOS platform variant.
  static const FVariant macos = FVariant('macos');

  /// The Linux platform variant.
  static const FVariant linux = FVariant('linux');

  /// The web platform variant.
  static const FVariant web = FVariant('web');

  /// Returns the more specific of two constraints.
  ///
  /// Specificity is determined by operand count with the highest count winning.
  ///
  /// ```dart
  /// max(hovered, hovered.and(focused)); // hovered & focused (2 > 1)
  /// ```
  ///
  /// Ties are broken lexicographically by sorted operand names.
  /// ```dart
  /// max(hovered.and(focused), focused.and(pressed)); // focused & hovered ("focused" < "pressed")
  /// ```
  static T max<T extends FVariantConstraint>(T a, T b) {
    switch (a._operands.compareTo(b._operands)) {
      case < 0:
        return b;

      case > 0:
        return a;
    }

    final operandsA = <String>[];
    final operandsB = <String>[];
    a._accept(operandsA);
    b._accept(operandsB);
    operandsA.sort();
    operandsB.sort();

    return operandsA.join().compareTo(operandsB.join()) <= 0 ? a : b;
  }

  /// Returns true if this constraint is satisfied by [variants].
  ///
  /// ```dart
  /// final variants = {.android};
  ///
  /// .android.satisfiedBy(variants); // true
  /// .ios.satisfiedBy(variants);     // false
  /// .touch.satisfiedBy(variants);   // true (android | ios | fuchsia)
  /// .desktop.satisfiedBy(variants); // false
  /// ```
  bool satisfiedBy(Set<FVariant> variants);

  void _accept(List<String> operands);

  int get _operands;
}

/// Represents a condition under which a widget can be styled differently.
///
/// Unlike [WidgetState], it is extended by widget-specific variants, allowing widgets to define their own states.
class FVariant implements FVariantConstraint {
  final String _value;

  /// Creates a variant.
  const FVariant(this._value);

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(this);

  @override
  void _accept(List<String> operands) => operands.add(_value);

  @override
  int get _operands => 1;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FVariant && runtimeType == other.runtimeType && _value == other._value;

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
  void _accept(List<String> operands) {
    _left._accept(operands);
    _right._accept(operands);
  }

  @override
  int get _operands => _left._operands + _right._operands;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is And && runtimeType == other.runtimeType && _left == other._left && _right == other._right;

  @override
  int get hashCode => Object.hash(_left, _right);

  @override
  String toString() => '($_left & $_right)';
}

@internal
class Not implements FVariantConstraint {
  final FVariantConstraint _operand;

  Not(this._operand);

  @override
  bool satisfiedBy(Set<FVariant> variants) => !_operand.satisfiedBy(variants);

  @override
  void _accept(List<String> operands) => _operand._accept(operands);

  @override
  int get _operands => _operand._operands;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Not && runtimeType == other.runtimeType && _operand == other._operand;

  @override
  int get hashCode => _operand.hashCode;

  @override
  String toString() => '!$_operand';
}
