import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/delta/delta.dart';

/// A delta that applies modifications to an [EdgeInsetsGeometry].
abstract class EdgeInsetsGeometryDelta with Delta {
  /// Creates an additive modification, adding the specified [insets] to the current edges.
  ///
  /// ```dart
  /// .add(.only(left: 5))(.fromLTRB(10, 20, 30, 40)); // .fromLTRB(15, 20, 30, 40)
  /// ```
  const factory add(EdgeInsetsGeometry insets) = _GeometryAdd;

  /// Scales all edges by [factor]. Preserves the concrete type (i.e. [EdgeInsets] stays [EdgeInsets],
  /// [EdgeInsetsDirectional] stays [EdgeInsetsDirectional]).
  ///
  /// ```dart
  /// .scale(0.5)(.all(10)); // .all(5)
  /// ```
  const factory scale(double factor) = _GeometryScale;

  /// Creates a complete replacement for an [EdgeInsetsGeometry].
  ///
  /// ```dart
  /// .value(.all(8))(.all(10)); // .all(8)
  /// ```
  const factory value(EdgeInsetsGeometry insets) = _GeometryValue;

  @override
  EdgeInsetsGeometry call(EdgeInsetsGeometry? insets);
}

class const _GeometryAdd(final EdgeInsetsGeometry _insets) implements EdgeInsetsGeometryDelta {
  @override
  EdgeInsetsGeometry call(EdgeInsetsGeometry? insets) => (insets ?? .zero).add(_insets);
}

class const _GeometryScale(final double _factor) implements EdgeInsetsGeometryDelta {
  @override
  EdgeInsetsGeometry call(EdgeInsetsGeometry? insets) => (insets ?? .zero) * _factor;
}

class const _GeometryValue(final EdgeInsetsGeometry _insets) implements EdgeInsetsGeometryDelta {
  @override
  EdgeInsetsGeometry call(EdgeInsetsGeometry? insets) => _insets;
}

/// A delta that applies modifications to an [EdgeInsets].
abstract class EdgeInsetsDelta with Delta {
  /// Creates a partial modification of LTRB edges, replacing only the specified edges.
  ///
  /// ```dart
  /// .delta(left: 0)(.fromLTRB(10, 20, 30, 40)); // .fromLTRB(0, 20, 30, 40)
  /// ```
  const factory delta({double? left, double? top, double? right, double? bottom}) = _Delta;

  /// Creates an additive modification, adding the specified values to the current edges.
  ///
  /// ```dart
  /// .add(left: 5)(.fromLTRB(10, 20, 30, 40)); // .fromLTRB(15, 20, 30, 40)
  /// ```
  const factory add({double? left, double? top, double? right, double? bottom}) = _Add;

  /// Scales all edges by [factor].
  ///
  /// ```dart
  /// .scale(0.5)(.all(10)); // .all(5)
  /// ```
  const factory scale(double factor) = _Scale;

  /// Creates a complete replacement for an [EdgeInsets].
  ///
  /// ```dart
  /// .value(.all(8))(.all(10)); // .all(8)
  /// ```
  const factory value(EdgeInsets insets) = _Value;

  @override
  EdgeInsets call(EdgeInsets? insets);
}

class const _Delta({
  final double? left = .infinity,
  final double? top = .infinity,
  final double? right = .infinity,
  final double? bottom = .infinity,
}) implements EdgeInsetsDelta {
  @override
  EdgeInsets call(EdgeInsets? insets) => (insets ?? .zero).copyWith(
    left: identical(left, double.infinity) ? null : left,
    top: identical(top, double.infinity) ? null : top,
    right: identical(right, double.infinity) ? null : right,
    bottom: identical(bottom, double.infinity) ? null : bottom,
  );
}

class const _Add({final double? left, final double? top, final double? bottom, final double? right})
    implements EdgeInsetsDelta {
  @override
  EdgeInsets call(EdgeInsets? insets) {
    final resolved = insets ?? .zero;
    return .only(
      left: resolved.left + (left ?? 0),
      top: resolved.top + (top ?? 0),
      right: resolved.right + (right ?? 0),
      bottom: resolved.bottom + (bottom ?? 0),
    );
  }
}

class const _Scale(final double _factor) implements EdgeInsetsDelta {
  @override
  EdgeInsets call(EdgeInsets? insets) => (insets ?? .zero) * _factor;
}

class const _Value(final EdgeInsets _insets) implements EdgeInsetsDelta {
  @override
  EdgeInsets call(EdgeInsets? insets) => _insets;
}

/// A delta that applies modifications to an [EdgeInsetsDirectional].
abstract class EdgeInsetsDirectionalDelta with Delta {
  /// Creates a partial modification of directional edges, replacing only the specified edges.
  ///
  /// ```dart
  /// .delta(start: 0)(.fromSTEB(10, 20, 30, 40)); // .fromSTEB(0, 20, 30, 40)
  /// ```
  const factory delta({double? start, double? top, double? end, double? bottom}) = _DirectionalDelta;

  /// Creates an additive modification, adding the specified values to the current edges.
  ///
  /// ```dart
  /// .add(start: 5)(.fromSTEB(10, 20, 30, 40)); // .fromSTEB(15, 20, 30, 40)
  /// ```
  const factory add({double? start, double? top, double? end, double? bottom}) = _DirectionalAdd;

  /// Scales all edges by [factor].
  ///
  /// ```dart
  /// .scale(0.5)(.all(10)); // .all(5)
  /// ```
  const factory scale(double factor) = _DirectionalScale;

  /// Creates a complete replacement for an [EdgeInsetsDirectional].
  ///
  /// ```dart
  /// .value(.all(8))(.all(10)); // .all(8)
  /// ```
  const factory value(EdgeInsetsDirectional insets) = _DirectionalValue;

  @override
  EdgeInsetsDirectional call(EdgeInsetsDirectional? insets);
}

class const _DirectionalDelta({
  final double? start = .infinity,
  final double? top = .infinity,
  final double? end = .infinity,
  final double? bottom = .infinity,
}) implements EdgeInsetsDirectionalDelta {
  @override
  EdgeInsetsDirectional call(EdgeInsetsDirectional? insets) => (insets ?? .zero).copyWith(
    start: identical(start, double.infinity) ? null : start,
    top: identical(top, double.infinity) ? null : top,
    end: identical(end, double.infinity) ? null : end,
    bottom: identical(bottom, double.infinity) ? null : bottom,
  );
}

class const _DirectionalAdd({final double? start, final double? top, final double? end, final double? bottom})
    implements EdgeInsetsDirectionalDelta {
  @override
  EdgeInsetsDirectional call(EdgeInsetsDirectional? insets) {
    final resolved = insets ?? .zero;
    return EdgeInsetsDirectional.only(
      start: resolved.start + (start ?? 0),
      top: resolved.top + (top ?? 0),
      end: resolved.end + (end ?? 0),
      bottom: resolved.bottom + (bottom ?? 0),
    );
  }
}

class const _DirectionalScale(final double _factor) implements EdgeInsetsDirectionalDelta {
  @override
  EdgeInsetsDirectional call(EdgeInsetsDirectional? insets) => (insets ?? .zero) * _factor;
}

class const _DirectionalValue(final EdgeInsetsDirectional _insets) implements EdgeInsetsDirectionalDelta {
  @override
  EdgeInsetsDirectional call(EdgeInsetsDirectional? insets) => _insets;
}
