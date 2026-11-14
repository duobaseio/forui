import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/item/item_content_layout.dart';

part 'raw_item_content.design.dart';

@internal
class RawItemContent extends StatelessWidget {
  final FRawItemContentStyle style;
  final EdgeInsetsGeometry margin;
  final double top;
  final double bottom;
  final Set<FTappableVariant> variants;
  final FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerForeground;
  final Color? dividerBackground;
  final double? dividerWidth;
  final FItemDivider dividerType;
  final Widget? prefix;
  final Widget child;

  const new({
    required this.style,
    required this.margin,
    required this.bottom,
    required this.top,
    required this.variants,
    required this.dividerForeground,
    required this.dividerBackground,
    required this.dividerWidth,
    required this.dividerType,
    required this.prefix,
    required this.child,
    super.key,
  }) : assert(
         (dividerForeground != null && dividerWidth != null) || dividerType == FItemDivider.none,
         'dividerForeground and dividerWidth must be provided if dividerType is not FItemDivider.none. This is a bug '
         "unless you're creating your own custom item container.",
       );

  @override
  Widget build(BuildContext context) => ItemContentLayout(
    margin: margin,
    padding: style.padding,
    top: top,
    bottom: bottom,
    dividerForeground: dividerForeground?.resolve(variants),
    dividerBackground: dividerBackground,
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
        softWrap: style.childSoftWrap,
        overflow: style.childOverflow,
        maxLines: style.childMaxLines,
        textHeightBehavior: style.childTextHeightBehavior,
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
      ..add(DiagnosticsProperty('dividerForeground', dividerForeground))
      ..add(ColorProperty('dividerBackground', dividerBackground))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(DiagnosticsProperty('dividerType', dividerType));
  }
}

/// An [FItem] raw content's style.
class FRawItemContentStyle({
  /// The prefix icon style.
  @override
  required final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta>
  prefixIconStyle,

  /// The child's text style.
  @override
  required final FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> childTextStyle,

  /// The content's padding.
  @override required final EdgeInsetsGeometry padding,

  /// Whether the child wraps at soft line breaks. Defaults to true.
  @override final bool childSoftWrap = true,

  /// The child's overflow. Defaults to [TextOverflow.ellipsis].
  @override final TextOverflow childOverflow = .ellipsis,

  /// The child's max lines. Defaults to null.
  @override final int? childMaxLines,

  /// The child's text height behavior. Defaults to not applying height to the first ascent and last descent.
  @override
  final TextHeightBehavior childTextHeightBehavior = const TextHeightBehavior(
    applyHeightToFirstAscent: false,
    applyHeightToLastDescent: false,
  ),

  /// The horizontal spacing between the prefix icon and child. Defaults to 8.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  @override final double prefixIconSpacing = 8,
}) with Diagnosticable, _$FRawItemContentStyleFunctions {
  /// Creates a [FRawItemContentStyle].
  this : assert(0 <= prefixIconSpacing, 'prefixIconSpacing ($prefixIconSpacing) must be >= 0');

  /// Creates a [FRawItemContentStyle] that inherits its properties.
  new inherit({
    required FColors colors,
    required FTypography typography,
    required Color prefix,
    required Color color,
    required bool touch,
  }) : this(
         prefixIconStyle: .from(
           IconThemeData(color: prefix, size: typography.body.md.fontSize),
           variants: {
             [.disabled]: .delta(color: colors.disable(prefix)),
           },
         ),
         childTextStyle: FVariants(
           typography.body.sm.copyWith(color: color),
           variants: {
             [.disabled]: typography.body.sm.copyWith(color: colors.disable(color)),
           },
         ),
         padding: touch
             ? const .symmetric(horizontal: 10, vertical: 12.5)
             : const .symmetric(horizontal: 10, vertical: 6.5),
       );
}
