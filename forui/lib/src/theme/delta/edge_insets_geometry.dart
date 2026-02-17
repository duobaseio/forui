import 'package:flutter/widgets.dart';

import 'package:forui/src/theme/delta/delta.dart';

/// A delta that applies modifications to an [EdgeInsetsGeometry].
abstract class EdgeInsetsGeometryDelta with Delta {
  /// Scales all edges by [factor]. Preserves the concrete type (i.e. [EdgeInsets] stays [EdgeInsets],
  /// [EdgeInsetsDirectional] stays [EdgeInsetsDirectional]).
  ///
  /// ```dart
  /// .scale(0.5)(.all(10)); // .all(5)
  /// ```
  const factory EdgeInsetsGeometryDelta.scale(double factor) = _GeometryScale;

  /// Creates a complete replacement for an [EdgeInsetsGeometry].
  ///
  /// ```dart
  /// .value(.all(8))(.all(10)); // .all(8)
  /// ```
  const factory EdgeInsetsGeometryDelta.value(EdgeInsetsGeometry insets) = _GeometryValue;

  @override
  EdgeInsetsGeometry call(EdgeInsetsGeometry? insets);
}

class _GeometryScale implements EdgeInsetsGeometryDelta {
  final double _factor;

  const _GeometryScale(this._factor);

  @override
  EdgeInsetsGeometry call(EdgeInsetsGeometry? insets) => (insets ?? .zero) * _factor;
}

class _GeometryValue implements EdgeInsetsGeometryDelta {
  final EdgeInsetsGeometry _insets;

  const _GeometryValue(this._insets);

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
  const factory EdgeInsetsDelta.delta({double? left, double? top, double? right, double? bottom}) = _Delta;

  /// Creates an additive modification, adding the specified values to the current edges.
  ///
  /// ```dart
  /// .add(left: 5)(.fromLTRB(10, 20, 30, 40)); // .fromLTRB(15, 20, 30, 40)
  /// ```
  const factory EdgeInsetsDelta.add({double? left, double? top, double? right, double? bottom}) = _Add;

  /// Scales all edges by [factor].
  ///
  /// ```dart
  /// .scale(0.5)(.all(10)); // .all(5)
  /// ```
  const factory EdgeInsetsDelta.scale(double factor) = _Scale;

  /// Creates a complete replacement for an [EdgeInsets].
  ///
  /// ```dart
  /// .value(.all(8))(.all(10)); // .all(8)
  /// ```
  const factory EdgeInsetsDelta.value(EdgeInsets insets) = _Value;

  @override
  EdgeInsets call(EdgeInsets? insets);
}

class _Delta implements EdgeInsetsDelta {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  const _Delta({this.left = .infinity, this.top = .infinity, this.right = .infinity, this.bottom = .infinity});

  @override
  EdgeInsets call(EdgeInsets? insets) => (insets ?? .zero).copyWith(
    left: identical(left, double.infinity) ? null : left,
    top: identical(top, double.infinity) ? null : top,
    right: identical(right, double.infinity) ? null : right,
    bottom: identical(bottom, double.infinity) ? null : bottom,
  );
}

class _Add implements EdgeInsetsDelta {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  const _Add({this.left, this.top, this.bottom, this.right});

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

class _Scale implements EdgeInsetsDelta {
  final double _factor;

  const _Scale(this._factor);

  @override
  EdgeInsets call(EdgeInsets? insets) => (insets ?? .zero) * _factor;
}

class _Value implements EdgeInsetsDelta {
  final EdgeInsets _insets;

  const _Value(this._insets);

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
  const factory EdgeInsetsDirectionalDelta.delta({double? start, double? top, double? end, double? bottom}) =
      _DirectionalDelta;

  /// Creates an additive modification, adding the specified values to the current edges.
  ///
  /// ```dart
  /// .add(start: 5)(.fromSTEB(10, 20, 30, 40)); // .fromSTEB(15, 20, 30, 40)
  /// ```
  const factory EdgeInsetsDirectionalDelta.add({double? start, double? top, double? end, double? bottom}) =
      _DirectionalAdd;

  /// Scales all edges by [factor].
  ///
  /// ```dart
  /// .scale(0.5)(.all(10)); // .all(5)
  /// ```
  const factory EdgeInsetsDirectionalDelta.scale(double factor) = _DirectionalScale;

  /// Creates a complete replacement for an [EdgeInsetsDirectional].
  ///
  /// ```dart
  /// .value(.all(8))(.all(10)); // .all(8)
  /// ```
  const factory EdgeInsetsDirectionalDelta.value(EdgeInsetsDirectional insets) = _DirectionalValue;

  @override
  EdgeInsetsDirectional call(EdgeInsetsDirectional? insets);
}

class _DirectionalDelta implements EdgeInsetsDirectionalDelta {
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;

  const _DirectionalDelta({
    this.start = .infinity,
    this.top = .infinity,
    this.end = .infinity,
    this.bottom = .infinity,
  });

  @override
  EdgeInsetsDirectional call(EdgeInsetsDirectional? insets) => (insets ?? .zero).copyWith(
    start: identical(start, double.infinity) ? null : start,
    top: identical(top, double.infinity) ? null : top,
    end: identical(end, double.infinity) ? null : end,
    bottom: identical(bottom, double.infinity) ? null : bottom,
  );
}

class _DirectionalAdd implements EdgeInsetsDirectionalDelta {
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;

  const _DirectionalAdd({this.start, this.top, this.end, this.bottom});

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

class _DirectionalScale implements EdgeInsetsDirectionalDelta {
  final double _factor;

  const _DirectionalScale(this._factor);

  @override
  EdgeInsetsDirectional call(EdgeInsetsDirectional? insets) => (insets ?? .zero) * _factor;
}

class _DirectionalValue implements EdgeInsetsDirectionalDelta {
  final EdgeInsetsDirectional _insets;

  const _DirectionalValue(this._insets);

  @override
  EdgeInsetsDirectional call(EdgeInsetsDirectional? insets) => _insets;
}
