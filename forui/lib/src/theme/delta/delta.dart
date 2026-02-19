import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/src/foundation/focused_outline.dart';

@internal
const nonNegativeIntSentinel = -1;

@internal
const stringSentinel = 'stringSentinel';

@internal
const colorSentinel = _ColorSentinel();

@internal
const focusedOutlineStyleSentinel = _FocusedOutlineStyleSentinel();

@internal
const imageFilterSentinel = _ImageFilterSentinel();

@internal
ImageFilter imageFilterFunctionSentinel(double animation) => throw UnimplementedError();

final class _ColorSentinel extends Color {
  const _ColorSentinel() : super(0);
}

final class _ImageFilterSentinel implements ImageFilter {
  const _ImageFilterSentinel();

  @override
  String get debugShortDescription => throw UnimplementedError();
}

// ignore: avoid_implementing_value_types
final class _FocusedOutlineStyleSentinel implements FFocusedOutlineStyle {
  const _FocusedOutlineStyleSentinel();

  @override
  BorderRadiusGeometry get borderRadius => throw UnimplementedError();

  @override
  Color get color => throw UnimplementedError();

  @override
  double get spacing => throw UnimplementedError();

  @override
  double get width => throw UnimplementedError();

  @override
  FFocusedOutlineStyle call(Object _) => throw UnimplementedError();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => throw UnimplementedError();

  @override
  DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style}) => throw UnimplementedError();

  @override
  String toStringShort() => throw UnimplementedError();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => throw UnimplementedError();
}

/// A mixin for types that can be applied to a base value to produce a new value.
mixin Delta {
  /// Applies this delta to the given value.
  ///
  /// This method is covariant because of limitations with Dart's type system. Passing an [Object] to a [Delta] subclass
  /// will almost always result in a runtime error.
  ///
  /// ## Contract
  /// Subclasses must accept and return the same type. For example, a delta that accepts a [TextStyle] must return a
  /// [TextStyle]. The [value] may be nullable or non-null depending on the subclass.
  ///
  /// In general, deltas for in-built Flutter types accept nullable values, while style deltas do not.
  Object call(covariant Object? value);
}
