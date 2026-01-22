// import 'dart:collection';
//
// import 'package:flutter/material.dart';
//
// extension type const FCalendarState(FWidgetState _) implements FWidgetState {
//   static const enclosing = FCalendarState(.new());
//
//   static const today = FCalendarState(.new());
//
//   factory FCalendarState.not(FCalendarState other) => .new(_Not(other));
//
//   FCalendarState and(FCalendarState other) => .new(_And(this, other));
// }
//
//
//
//
//
// /// A map from [FWidgetState] constraints to values.
// ///
// /// Constraints are checked in the order they are provided. The first constraint that is satisfied will have its
// /// associated value returned.
// ///
// /// Implements [Map] so it can be spread directly into map literals:
// /// ```dart
// /// final updated = {
// ///   ...existingVariantMap,
// ///   FTappableVariant.hovered: Colors.red,
// /// };
// /// ```
// class FWidgetStateMap<K extends FWidgetState, V> extends MapBase<K, V> {
//   final Map<K, V> _map;
//
//   /// Creates a [FWidgetStateMap] with the given constraints.
//   FWidgetStateMap(Map<K, V> map) : _map = Map.of(map);
//
//   /// Creates a [FWidgetStateMap] which always resolves to the given value.
//   ///
//   /// Uses a negated impossible constraint (`~FWidgetState('_')`) as a catch-all.
//   FWidgetStateMap.all(V value) : _map = {~const FWidgetState('_') as K: value};
//
//   // --- Map implementation ---
//
//   @override
//   V? operator [](Object? key) => _map[key];
//
//   @override
//   void operator []=(K key, V value) => _map[key] = value;
//
//   @override
//   void clear() => _map.clear();
//
//   @override
//   Iterable<K> get keys => _map.keys;
//
//   @override
//   V? remove(Object? key) => _map.remove(key);
//
//   // --- FWidgetStateMap-specific methods ---
//
//   /// Returns a value that depends on [variants] by checking the constraints.
//   ///
//   /// ## Contract
//   /// Throws an [ArgumentError] if no constraints are satisfied and [V] is non-nullable.
//   V resolve(Set<FWidgetState> variants) {
//     for (final MapEntry(key: constraint, :value) in _map.entries) {
//       if (constraint.satisfiedBy(variants)) {
//         return value;
//       }
//     }
//
//     try {
//       return null as V;
//       // ignore: avoid_catching_errors
//     } on TypeError {
//       throw ArgumentError(
//         'The current set of variants is $variants.\n'
//         'None of the provided map keys matched this set, '
//         'and the type "$V" is non-nullable.\n'
//         'Consider using "FWidgetStateMap<$K, $V?>()", '
//         'or adding a catch-all key to this property.',
//       );
//     }
//   }
//
//   /// Returns a value that depends on [variants], or null if no match is found.
//   V? maybeResolve(Set<FWidgetState> variants) {
//     for (final MapEntry(key: constraint, :value) in _map.entries) {
//       if (constraint.satisfiedBy(variants)) {
//         return value;
//       }
//     }
//     return null;
//   }
//
//   /// Returns a new [FWidgetStateMap] with all values transformed by [transform].
//   ///
//   /// ## Example
//   /// ```dart
//   /// final colors = FWidgetStateMap<FTappableVariant, Color>({
//   ///   FTappableVariant.hovered: Colors.blue,
//   /// });
//   ///
//   /// final faded = colors.mapValues((color) => color.withOpacity(0.5));
//   /// ```
//   FWidgetStateMap<K, R> mapValues<R>(R Function(V) transform) =>
//       FWidgetStateMap<K, R>({for (final MapEntry(key: constraint, :value) in _map.entries) constraint: transform(value)});
//
//   /// Returns a new [FWidgetStateMap] with values transformed by [transform],
//   /// which receives both the constraint and value.
//   ///
//   /// ## Example
//   /// ```dart
//   /// final style = baseStyle.mapEntries((variant, tappableStyle) {
//   ///   if (variant == FCalendarVariant.today) {
//   ///     return tappableStyle.copyWith(...);
//   ///   }
//   ///   return tappableStyle;
//   /// });
//   /// ```
//   FWidgetStateMap<K, R> mapEntries<R>(R Function(K key, V value) transform) => FWidgetStateMap<K, R>({
//     for (final MapEntry(key: constraint, :value) in _map.entries) constraint: transform(constraint, value),
//   });
//
//   @override
//   String toString() => 'FWidgetStateMap{$_map}';
// }
//
// extension type const FTappableVariant(FWidgetState variant) implements FWidgetState {
//   static const focused = FTappableVariant(.new('focused'));
//
//   static const hovered = FTappableVariant(.new('hovered'));
//
//   static const pressed = FTappableVariant(.new('pressed'));
//
//   factory FTappableVariant.not(FTappableVariant other) => .new(_Not(other));
//
//   FTappableVariant and(FTappableVariant other) => .new(_And(this, other));
//
//   FTappableVariant or(FTappableVariant other) => .new(_Or(this, other));
// }
//
// extension type const FCalendarVariant(FWidgetState variant) implements FWidgetState {
//   static const enclosing = FCalendarVariant(.new('enclosing'));
//
//   static const today = FCalendarVariant(.new('today'));
//
//   factory FCalendarVariant.not(FCalendarVariant other) => .new(_Not(other));
//
//   FCalendarVariant and(FCalendarVariant other) => .new(_And(this, other));
//
//   FCalendarVariant or(FCalendarVariant other) => .new(_Or(this, other));
// }
//
// class FTappableStyle {
//   final FWidgetStateMap<FTappableVariant, Color> backgroundColor;
//
//   FTappableStyle({required Map<FTappableVariant, Color> backgroundColor})
//     : backgroundColor = FWidgetStateMap(backgroundColor);
//
//   FTappableStyle copyWith({Map<FTappableVariant, Color>? backgroundColor}) =>
//       FTappableStyle(backgroundColor: backgroundColor ?? this.backgroundColor);
//
//   static FTappableStyle inherit() => FTappableStyle(
//     backgroundColor: {
//       FTappableVariant.not(.pressed).and(.not(.hovered)): Colors.transparent,
//       .hovered: Colors.grey.shade200,
//       .pressed: Colors.grey.shade300,
//     },
//   );
// }
//
// class FCalendarStyle {
//   final FWidgetStateMap<FCalendarVariant, TextStyle> textStyle;
//   final FWidgetStateMap<FCalendarVariant, FTappableStyle> tappableStyle;
//
//   FCalendarStyle({
//     required Map<FCalendarVariant, TextStyle> textStyle,
//     required Map<FCalendarVariant, FTappableStyle> tappableStyle,
//   }) : textStyle = FWidgetStateMap(textStyle),
//        tappableStyle = FWidgetStateMap(tappableStyle);
//
//   factory FCalendarStyle.inherit() {
//     final base = FTappableStyle(
//       backgroundColor: {
//         .not(.pressed).and(.not(.hovered)): Colors.transparent,
//         .hovered: Colors.grey.shade100,
//         .pressed: Colors.grey.shade200,
//       },
//     );
//
//     return FCalendarStyle(
//       textStyle: {
//         .not(.today): const TextStyle(fontWeight: .normal),
//         .today: const TextStyle(fontWeight: .bold, decoration: .underline),
//       },
//       tappableStyle: FVariants(
//         base: style,
//         variants: {
//           .today: base.copyWith(
//             backgroundColor: {
//                   .not(.pressed).and(.not(.hovered)): Colors.blue.shade50,
//                   .hovered: Colors.blue.shade100,
//                   .pressed: Colors.blue.shade200,
//                 },
//               ),
//           .enclosing: base.copyWith(
//           backgroundColor: {
//                 .not(.pressed).and(.not(.hovered)): Colors.transparent,
//                 .hovered: Colors.grey.shade50,
//                 .pressed: Colors.grey.shade100,
//             },
//           ),
//         }
//       ){
//       },
//     );
//   }
// }
//
// // =============================================================================
// // ORIGINAL VERSION for comparison
// // =============================================================================
// /*
// class FTappableStyle {
//   final FWidgetStateMap<FTappableVariant, Color> backgroundColor;
//
//   const FTappableStyle({required this.backgroundColor});
//
//   FTappableStyle copyWith({
//     FWidgetStateMap<FTappableVariant, Color>? backgroundColor,
//   }) => FTappableStyle(
//     backgroundColor: backgroundColor ?? this.backgroundColor,
//   );
//
//   static FTappableStyle inherit() => FTappableStyle(
//     backgroundColor: FWidgetStateMap({
//       ~FTappableVariant.pressed & ~FTappableVariant.hovered: Colors.transparent,
//       FTappableVariant.hovered: Colors.grey.shade200,
//       FTappableVariant.pressed: Colors.grey.shade300,
//     }),
//   );
// }
//
// class FCalendarStyle {
//   final FWidgetStateMap<FCalendarVariant, TextStyle> textStyle;
//   final FWidgetStateMap<FCalendarVariant, FTappableStyle> tappableStyle;
//   final FTappableStyle baseTappableStyle;
//
//   const FCalendarStyle({
//     required this.textStyle,
//     required this.tappableStyle,
//     required this.baseTappableStyle,
//   });
//
//   static FCalendarStyle inherit() {
//     final base = FTappableStyle(
//       backgroundColor: FWidgetStateMap({
//         ~FTappableVariant.pressed & ~FTappableVariant.hovered: Colors.transparent,
//         FTappableVariant.hovered: Colors.grey.shade100,
//         FTappableVariant.pressed: Colors.grey.shade200,
//       }),
//     );
//
//     return FCalendarStyle(
//       textStyle: FWidgetStateMap({
//         ~FCalendarVariant.today: const TextStyle(fontWeight: FontWeight.normal),
//         FCalendarVariant.today: const TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
//       }),
//
//       tappableStyle: FWidgetStateMap({
//         FCalendarVariant.today: base.copyWith(
//           backgroundColor: FWidgetStateMap({
//             ~FTappableVariant.pressed & ~FTappableVariant.hovered: Colors.blue.shade50,
//             FTappableVariant.hovered: Colors.blue.shade100,
//             FTappableVariant.pressed: Colors.blue.shade200,
//           }),
//         ),
//
//         FCalendarVariant.enclosing: base.copyWith(
//           backgroundColor: FWidgetStateMap({
//             ~FTappableVariant.pressed & ~FTappableVariant.hovered: Colors.transparent,
//             FTappableVariant.hovered: Colors.grey.shade50,
//             FTappableVariant.pressed: Colors.grey.shade100,
//           }),
//         ),
//       }),
//
//       baseTappableStyle: base,
//     );
//   }
// }
// */
//
// extension type const _Sentinel(Color color) {}
//
// void a(Color a = _Sentinel())
//
// extension type const Token<T>(T Function(BuildContext) resolve) {
//   Token.raw(T value) : this((_) => value);
// }
//
// Map<Set<FCalendarVariant>, Object> foo() => {
//   {.today, .today.and(.enclosing)}: Object(),
// };
