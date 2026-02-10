const source = r'''
import 'dart:ui';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/annotations.dart';
import 'package:forui/src/theme/delta.dart';
import 'package:forui/src/theme/variant.dart';
import 'package:meta/meta.dart';

@Variants('FGolden', {'hovered': (1, 'The hovered state'), 'pressed': (1, 'The pressed state')})
@Sentinels(FGoldenStyle, {'someDouble': 'double.infinity', 'color': 'colorSentinel'})

part 'example.design.dart';

class FGoldenStyle with Diagnosticable, _$FGoldenStyleFunctions {
  /// This is a field's summary.
  ///
  /// This is more information about a field.
  final double someDouble;
  final Alignment alignment;
  final AlignmentGeometry alignmentGeometry;
  final BorderRadius borderRadius;
  final BorderRadiusGeometry borderRadiusGeometry;
  final BoxConstraints boxConstraints;
  final BoxDecoration boxDecoration;
  final Decoration decoration;
  final Color color;
  final EdgeInsets edgeInsets;
  final EdgeInsetsDirectional edgeInsetsDirectional;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final IconThemeData iconThemeData;
  final TextStyle textStyle;
  final List<BoxShadow> boxShadows;
  final List<Shadow> shadows;
  final FVariants<FGoldenVariantConstraint, BoxDecoration, BoxDecorationDelta> boxDecorationVariants;
  final FVariants<FGoldenVariantConstraint, BoxDecoration?, BoxDecorationDelta> nullableBoxDecorationVariants;
  final FVariants<FGoldenVariantConstraint, Decoration, Delta> decorationVariants;
  final FVariants<FGoldenVariantConstraint, Decoration?, Delta> nullableDecorationVariants;
  final FVariants<FGoldenVariantConstraint, Color, Delta> colorVariants;
  final FVariants<FGoldenVariantConstraint, Color?, Delta> nullableColorVariants;
  final FVariants<FGoldenVariantConstraint, IconThemeData, IconThemeDataDelta> iconThemeDataVariants;
  final FVariants<FGoldenVariantConstraint, IconThemeData?, IconThemeDataDelta> nullableIconThemeDataVariants;
  final FVariants<FGoldenVariantConstraint, TextStyle, TextStyleDelta> textStyleVariants;
  final FVariants<FGoldenVariantConstraint, TextStyle?, TextStyleDelta> nullableTextStyleVariants;
  final FVariants<FGoldenVariantConstraint, FGoldenNestedMotion, FGoldenNestedMotionDelta> nestedMotionVariants;
  final FGoldenNestedMotion nestedMotion;
  final FGoldenNestedStyle nestedStyle;
  final List<String> list;
  final Set<String> set;
  final Map<String, int> map;
  FGoldenStyle({
    required this.someDouble,
    required this.alignment,
    required this.alignmentGeometry,
    required this.borderRadius,
    required this.borderRadiusGeometry,
    required this.boxConstraints,
    required this.boxDecoration,
    required this.decoration,
    required this.color,
    required this.edgeInsets,
    required this.edgeInsetsDirectional,
    required this.edgeInsetsGeometry,
    required this.iconThemeData,
    required this.textStyle,
    required this.boxShadows,
    required this.shadows,
    required this.boxDecorationVariants,
    required this.nullableBoxDecorationVariants,
    required this.decorationVariants,
    required this.nullableDecorationVariants,
    required this.colorVariants,
    required this.nullableColorVariants,
    required this.iconThemeDataVariants,
    required this.nullableIconThemeDataVariants,
    required this.textStyleVariants,
    required this.nullableTextStyleVariants,
    required this.nestedMotionVariants,
    required this.nestedMotion,
    required this.nestedStyle,
    required this.list,
    required this.set,
    required this.map,
  });
}

class FGoldenNestedMotion with Diagnosticable, _$FGoldenNestedMotionFunctions {
  /// This is a field's summary.
  ///
  /// This is more information about a field.
  final double someDouble;
  final Duration duration;
  final Curve curve;

  FGoldenNestedMotion({required this.someDouble, required this.duration, required this.curve});
}

class FGoldenNestedStyle with Diagnosticable, _$FGoldenNestedStyleFunctions {}
''';
