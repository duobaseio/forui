import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/src/foundation/focused_outline.dart';

/// Special values that indicate the absence of a value of a particular type.
extension Sentinels on Never {
  /// A sentinel value for non-negative int fields.
  static const nonNegativeInt = -1;

  /// A sentinel value for string fields.
  static const string = 'stringSentinel';

  /// A sentinel value for color fields.
  static const color = _ColorSentinel();

  /// A sentinel value for focused outline style fields.
  static const focusedOutlineStyle = _FocusedOutlineStyleSentinel();

  /// A sentinel value for shape border fields.
  static const shapeBorder = _ShapeBorderSentinel();

  /// A sentinel value for image filter fields.
  static const imageFilter = _ImageFilterSentinel();

  /// A sentinel value for image filter function fields.
  static ImageFilter imageFilterFunction(double animation) => throw UnimplementedError();

  /// A sentinel value for border radius fields.
  static const borderRadius = _BorderRadiusSentinel();

  /// A sentinel value for box border fields.
  static const boxBorder = _BoxBorderSentinel();

  /// A sentinel value for decoration image fields.
  static const decorationImage = _DecorationImageSentinel();

  /// A sentinel value for gradient fields.
  static const gradient = _GradientSentinel();

  /// A sentinel value for font weight fields.
  static const fontWeight = _FontWeightSentinel();

  /// A sentinel value for locale fields.
  static const locale = Locale('sentinel');
}

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

final class _BorderRadiusSentinel extends BorderRadiusGeometry {
  const _BorderRadiusSentinel();

  @override
  BorderRadiusGeometry add(BorderRadiusGeometry other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry subtract(BorderRadiusGeometry other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator -() => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator *(double other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator /(double other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator ~/(double other) => throw UnimplementedError();

  @override
  BorderRadiusGeometry operator %(double other) => throw UnimplementedError();

  @override
  BorderRadius resolve(TextDirection? direction) => throw UnimplementedError();
}

final class _BoxBorderSentinel extends BoxBorder {
  const _BoxBorderSentinel();

  @override
  BorderSide get bottom => throw UnimplementedError();

  @override
  BorderSide get top => throw UnimplementedError();

  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  bool get isUniform => throw UnimplementedError();

  @override
  ShapeBorder scale(double t) => throw UnimplementedError();

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) => throw UnimplementedError();
}

final class _DecorationImageSentinel extends DecorationImage {
  const _DecorationImageSentinel() : super(image: const _ImageProvider());
}

final class _ImageProvider extends ImageProvider {
  const _ImageProvider();

  @override
  Future<Object> obtainKey(ImageConfiguration configuration) => throw UnimplementedError();
}

final class _GradientSentinel extends Gradient {
  const _GradientSentinel() : super(colors: const []);

  @override
  Gradient scale(double factor) => throw UnimplementedError();

  @override
  Shader createShader(Rect rect, {TextDirection? textDirection}) => throw UnimplementedError();

  @override
  Gradient withOpacity(double opacity) => throw UnimplementedError();
}

// ignore: avoid_implementing_value_types
final class _FontWeightSentinel implements FontWeight {
  const _FontWeightSentinel();

  @override
  int get index => throw UnimplementedError();

  @override
  int get value => throw UnimplementedError();
}

final class _ShapeBorderSentinel extends ShapeBorder {
  const _ShapeBorderSentinel();

  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => throw UnimplementedError();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => throw UnimplementedError();

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) => throw UnimplementedError();

  @override
  ShapeBorder scale(double t) => throw UnimplementedError();
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
