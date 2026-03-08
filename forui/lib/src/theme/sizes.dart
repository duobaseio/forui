import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

/// Tokens for the various size categories.
///
/// These are the canonical heights used by Forui widgets:
/// * [field] — field-like widgets (buttons, text fields, selects).
/// * [item] — menu / list items.
/// * [tile] — tiles.
/// * [calendar] — calendar day tile size.
final class FSizes with Diagnosticable {
  /// The field heights at each scale.
  ///
  /// Defaults to:
  /// * Desktop — `xs` = 24, `sm` = 32, `md` = 36, `lg` = 40.
  /// * Touch — `xs` = 32, `sm` = 40, `md` = 44, `lg` = 48.
  final ({double xs, double sm, double md, double lg}) field;

  /// The item height.
  ///
  /// Defaults to:
  /// * Desktop — 30.
  /// * Touch — 44.
  final double item;

  /// The tile height.
  ///
  /// Defaults to 48.
  final double tile;

  /// The calendar day tile size.
  ///
  /// Defaults to:
  /// * Desktop — 32.
  /// * Touch — 44.
  final double calendar;

  /// Creates an [FSizes].
  const FSizes({required this.field, required this.item, required this.tile, required this.calendar});

  /// Creates an [FSizes] that inherits its properties based on [touch].
  factory FSizes.inherit({required bool touch}) => touch
      ? const FSizes(field: (xs: 32, sm: 40, md: 44, lg: 48), item: 44, tile: 48, calendar: 44)
      : const FSizes(field: (xs: 24, sm: 32, md: 36, lg: 40), item: 30, tile: 48, calendar: 32);

  /// Scales all sizes by the given [scalar].
  @useResult
  FSizes scale(double scalar) => FSizes(
    field: (xs: field.xs * scalar, sm: field.sm * scalar, md: field.md * scalar, lg: field.lg * scalar),
    item: item * scalar,
    tile: tile * scalar,
    calendar: calendar * scalar,
  );

  /// Returns a copy of this [FSizes] with the given properties replaced.
  @useResult
  FSizes copyWith({
    ({double xs, double sm, double md, double lg})? field,
    double? item,
    double? tile,
    double? calendar,
  }) => FSizes(
    field: field ?? this.field,
    item: item ?? this.item,
    tile: tile ?? this.tile,
    calendar: calendar ?? this.calendar,
  );

  /// Linearly interpolate between this and [other] using the given factor [t].
  @useResult
  FSizes lerp(FSizes other, double t) => FSizes(
    field: (
      xs: lerpDouble(field.xs, other.field.xs, t) ?? field.xs,
      sm: lerpDouble(field.sm, other.field.sm, t) ?? field.sm,
      md: lerpDouble(field.md, other.field.md, t) ?? field.md,
      lg: lerpDouble(field.lg, other.field.lg, t) ?? field.lg,
    ),
    item: lerpDouble(item, other.item, t) ?? item,
    tile: lerpDouble(tile, other.tile, t) ?? tile,
    calendar: lerpDouble(calendar, other.calendar, t) ?? calendar,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('field.xs', field.xs, level: .debug))
      ..add(DoubleProperty('field.sm', field.sm, level: .debug))
      ..add(DoubleProperty('field.md', field.md, level: .debug))
      ..add(DoubleProperty('field.lg', field.lg, level: .debug))
      ..add(DoubleProperty('item', item, level: .debug))
      ..add(DoubleProperty('tile', tile, level: .debug))
      ..add(DoubleProperty('calendar', calendar, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSizes &&
          runtimeType == other.runtimeType &&
          field == other.field &&
          item == other.item &&
          tile == other.tile &&
          calendar == other.calendar;

  @override
  int get hashCode => field.hashCode ^ item.hashCode ^ tile.hashCode ^ calendar.hashCode;
}
