import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'package:meta/meta.dart';

/// Tokens for the various border radius sizes.
final class FBorderRadius with Diagnosticable {
  /// The extra-extra-small border radius. Defaults to 4px.
  final BorderRadius xs2;

  /// The extra-small border radius. Defaults to 6px.
  final BorderRadius xs;

  /// The small border radius. Defaults to 8px.
  final BorderRadius sm;

  /// The medium border radius. Defaults to 10px.
  final BorderRadius md;

  /// The large border radius. Defaults to 14px.
  final BorderRadius lg;

  /// The extra-large border radius. Defaults to 18px.
  final BorderRadius xl;

  /// The extra-large border radius. Defaults to 22px.
  final BorderRadius xl2;

  /// The extra-large border radius. Defaults to 26px.
  final BorderRadius xl3;

  /// The pill border radius. Defaults to 100px.
  final BorderRadius pill;

  /// Creates an [FBorderRadius].
  const FBorderRadius({
    this.xs2 = const .all(.circular(4)),
    this.xs = const .all(.circular(6)),
    this.sm = const .all(.circular(8)),
    this.md = const .all(.circular(10)),
    this.lg = const .all(.circular(14)),
    this.xl = const .all(.circular(18)),
    this.xl2 = const .all(.circular(22)),
    this.xl3 = const .all(.circular(26)),
    this.pill = const .all(.circular(100)),
  });

  /// Scales all border radii by the given [scalar].
  ///
  /// ```dart
  /// final borderRadius = FBorderRadius();
  ///
  /// final scaled = borderRadius.scale(1.5);
  ///
  /// print(scaled.md); // .circular(15)
  /// ```
  @useResult
  FBorderRadius scale(double scalar) => FBorderRadius(
    xs2: xs2 * scalar,
    xs: xs * scalar,
    sm: sm * scalar,
    md: md * scalar,
    lg: lg * scalar,
    xl: xl * scalar,
    xl2: xl2 * scalar,
    xl3: xl3 * scalar,
    pill: pill * scalar,
  );

  /// Returns a copy of this [FBorderRadius] with the given properties replaced.
  @useResult
  FBorderRadius copyWith({
    BorderRadius? xs2,
    BorderRadius? xs,
    BorderRadius? sm,
    BorderRadius? md,
    BorderRadius? lg,
    BorderRadius? xl,
    BorderRadius? xl2,
    BorderRadius? xl3,
    BorderRadius? pill,
  }) => FBorderRadius(
    xs2: xs2 ?? this.xs2,
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    xl2: xl2 ?? this.xl2,
    xl3: xl3 ?? this.xl3,
    pill: pill ?? this.pill,
  );

  /// Linearly interpolate between this and [other] using the given factor [t].
  @useResult
  FBorderRadius lerp(FBorderRadius other, double t) => FBorderRadius(
    xs2: BorderRadius.lerp(xs2, other.xs2, t) ?? xs2,
    xs: BorderRadius.lerp(xs, other.xs, t) ?? xs,
    sm: BorderRadius.lerp(sm, other.sm, t) ?? sm,
    md: BorderRadius.lerp(md, other.md, t) ?? md,
    lg: BorderRadius.lerp(lg, other.lg, t) ?? lg,
    xl: BorderRadius.lerp(xl, other.xl, t) ?? xl,
    xl2: BorderRadius.lerp(xl2, other.xl2, t) ?? xl2,
    xl3: BorderRadius.lerp(xl3, other.xl3, t) ?? xl3,
    pill: BorderRadius.lerp(pill, other.pill, t) ?? pill,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('xs2', xs2, level: .debug))
      ..add(DiagnosticsProperty('xs', xs, level: .debug))
      ..add(DiagnosticsProperty('sm', sm, level: .debug))
      ..add(DiagnosticsProperty('md', md, level: .debug))
      ..add(DiagnosticsProperty('lg', lg, level: .debug))
      ..add(DiagnosticsProperty('xl', xl, level: .debug))
      ..add(DiagnosticsProperty('xl2', xl2, level: .debug))
      ..add(DiagnosticsProperty('xl3', xl3, level: .debug))
      ..add(DiagnosticsProperty('pill', pill, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBorderRadius &&
          runtimeType == other.runtimeType &&
          xs2 == other.xs2 &&
          xs == other.xs &&
          sm == other.sm &&
          md == other.md &&
          lg == other.lg &&
          xl == other.xl &&
          xl2 == other.xl2 &&
          xl3 == other.xl3 &&
          pill == other.pill;

  @override
  int get hashCode =>
      xs2.hashCode ^
      xs.hashCode ^
      sm.hashCode ^
      md.hashCode ^
      lg.hashCode ^
      xl.hashCode ^
      xl2.hashCode ^
      xl3.hashCode ^
      pill.hashCode;
}
