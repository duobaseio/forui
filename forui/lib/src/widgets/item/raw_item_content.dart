import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/item/render_item_content.dart';

part 'raw_item_content.design.dart';

@internal
class RawItemContent extends StatelessWidget {
  final FRawItemContentStyle style;
  final EdgeInsetsGeometry margin;

  final double top;
  final double bottom;
  final Set<FTappableVariant> variants;
  final FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor;
  final double? dividerWidth;
  final FItemDivider dividerType;
  final Widget? prefix;
  final Widget child;

  const RawItemContent({
    required this.style,
    required this.margin,
    required this.bottom,
    required this.top,
    required this.variants,
    required this.dividerColor,
    required this.dividerWidth,
    required this.dividerType,
    required this.prefix,
    required this.child,
    super.key,
  }) : assert(
         (dividerColor != null && dividerWidth != null) || dividerType == FItemDivider.none,
         'dividerColor and dividerWidth must be provided if dividerType is not FItemDivider.none. This is a bug unless '
         "you're creating your own custom item container.",
       );

  @override
  Widget build(BuildContext context) => ItemContentLayout(
    margin: margin,
    padding: style.padding,
    top: top,
    bottom: bottom,
    dividerColor: dividerColor?.resolve(variants),
    dividerWidth: dividerWidth,
    dividerType: dividerType,
    children: [
      if (prefix case final prefix?)
        Padding(
          padding: .directional(end: style.prefixIconSpacing),
          child: IconTheme(data: style.prefixIconStyle.resolve(variants), child: prefix),
        )
      else
        const SizedBox(),
      DefaultTextStyle.merge(
        style: style.childTextStyle.resolve(variants),
        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
        overflow: .ellipsis,
        child: child,
      ),
      const SizedBox(),
      const SizedBox(),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('margin', margin))
      ..add(IterableProperty('variants', variants))
      ..add(DoubleProperty('top', top))
      ..add(DoubleProperty('bottom', bottom))
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(DiagnosticsProperty('dividerType', dividerType));
  }
}

/// An [FItem] raw content's style.
class FRawItemContentStyle with Diagnosticable, _$FRawItemContentStyleFunctions {
  /// The content's padding. Defaults to `EdgeInsetsDirectional.only(start: 10, top: 6, bottom: 6, end: 6)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The prefix icon style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> prefixIconStyle;

  /// The horizontal spacing between the prefix icon and child. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  @override
  final double prefixIconSpacing;

  /// The child's text style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> childTextStyle;

  /// Creates a [FRawItemContentStyle].
  FRawItemContentStyle({
    required this.prefixIconStyle,
    required this.childTextStyle,
    this.padding = const .directional(start: 10, top: 6, bottom: 6, end: 6),
    this.prefixIconSpacing = 8,
  }) : assert(0 <= prefixIconSpacing, 'prefixIconSpacing ($prefixIconSpacing) must be >= 0');

  /// Creates a [FRawItemContentStyle] that inherits its properties.
  FRawItemContentStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required Color prefix,
    required Color color,
  }) : this(
         prefixIconStyle: FVariants.from(
           IconThemeData(color: prefix, size: typography.md.fontSize),
           variants: {
             [.disabled]: .delta(color: colors.disable(prefix)),
           },
         ),
         childTextStyle: FVariants(
           typography.sm.copyWith(color: color),
           variants: {
             [.disabled]: typography.sm.copyWith(color: colors.disable(color)),
           },
         ),
       );
}
