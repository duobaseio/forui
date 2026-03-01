import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/item/render_item_content.dart';

part 'item_content.design.dart';

@internal
class ItemContent extends StatelessWidget {
  final FItemContentStyle style;
  final EdgeInsetsGeometry margin;
  final double top;
  final double bottom;
  final Set<FTappableVariant> variants;
  final FVariants<FItemGroupVariantConstraint, FItemGroupVariant, Color, Delta>? dividerColor;
  final double? dividerWidth;
  final FItemDivider dividerType;
  final Widget? prefix;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffix;

  const ItemContent({
    required this.style,
    required this.margin,
    required this.bottom,
    required this.top,
    required this.variants,
    required this.dividerColor,
    required this.dividerWidth,
    required this.dividerType,
    required this.title,
    required this.prefix,
    required this.subtitle,
    required this.details,
    required this.suffix,
    super.key,
  }) : assert(
         (dividerColor != null && dividerWidth != null) || dividerType == .none,
         'dividerColor and dividerWidth must be provided if dividerType is not FItemDivider.none. This is a bug unless '
         "you're creating your own custom item container.",
       );

  @override
  Widget build(BuildContext context) => ItemContentLayout(
    margin: margin,
    padding: style.padding.resolve({context.platformVariant}),
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
      Padding(
        padding: .directional(end: style.middleSpacing),
        child: Column(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          spacing: style.titleSpacing,
          children: [
            DefaultTextStyle.merge(
              style: style.titleTextStyle.resolve(variants),
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              overflow: .ellipsis,
              child: title,
            ),
            if (subtitle case final subtitle?)
              DefaultTextStyle.merge(
                style: style.subtitleTextStyle.resolve(variants),
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                overflow: .ellipsis,
                child: subtitle,
              ),
          ],
        ),
      ),
      if (details case final details?)
        DefaultTextStyle.merge(
          style: style.detailsTextStyle.resolve(variants),
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
          overflow: .ellipsis,
          child: details,
        )
      else
        const SizedBox(),
      if (suffix case final suffixIcon?)
        Padding(
          padding: .directional(start: style.suffixIconSpacing),
          child: IconTheme(data: style.suffixIconStyle.resolve(variants), child: suffixIcon),
        )
      else
        const SizedBox(),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('margin', margin))
      ..add(DoubleProperty('top', top))
      ..add(DoubleProperty('bottom', bottom))
      ..add(IterableProperty('variants', variants))
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(DiagnosticsProperty('dividerType', dividerType));
  }
}

/// An [FItem] content's style.
class FItemContentStyle with Diagnosticable, _$FItemContentStyleFunctions {
  /// The content's padding.
  ///
  /// Defaults to:
  /// * touch: `EdgeInsetsDirectional.only(start: 10, top: 12.5, bottom: 12.5, end: 6)`
  /// * desktop: `EdgeInsetsDirectional.only(start: 10, top: 6, bottom: 6, end: 6)`
  @override
  final FVariants<FPlatformVariantConstraint, FPlatformVariant, EdgeInsetsGeometry, Delta> padding;

  /// The prefix icon style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> prefixIconStyle;

  /// The horizontal spacing between the prefix icon and title and the subtitle. Defaults to 8.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  @override
  final double prefixIconSpacing;

  /// The title's text style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> titleTextStyle;

  /// The vertical spacing between the title and the subtitle. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [titleSpacing] is negative.
  @override
  final double titleSpacing;

  /// The subtitle's text style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> subtitleTextStyle;

  /// The minimum horizontal spacing between the title, subtitle, combined, and the details. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [middleSpacing] is negative.
  @override
  final double middleSpacing;

  /// The details text style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> detailsTextStyle;

  /// The suffix icon style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> suffixIconStyle;

  /// The horizontal spacing between the details and suffix icon. Defaults to 8.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [suffixIconSpacing] is negative.
  @override
  final double suffixIconSpacing;

  /// Creates a [FItemContentStyle].
  FItemContentStyle({
    required this.prefixIconStyle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.detailsTextStyle,
    required this.suffixIconStyle,
    this.padding = const .raw(.directional(start: 10, top: 12.5, bottom: 12.5, end: 6), {
      .desktop: .directional(start: 10, top: 5.5, bottom: 5.5, end: 6),
    }),
    this.prefixIconSpacing = 8,
    this.titleSpacing = 4,
    this.middleSpacing = 4,
    this.suffixIconSpacing = 8,
  }) : assert(0 <= prefixIconSpacing, 'prefixIconSpacing ($prefixIconSpacing) must be >= 0'),
       assert(0 <= titleSpacing, 'titleSpacing ($titleSpacing) must be >= 0'),
       assert(0 <= middleSpacing, 'middleSpacing ($middleSpacing) must be >= 0'),
       assert(0 <= suffixIconSpacing, 'suffixIconSpacing ($suffixIconSpacing) must be >= 0');

  /// Creates a [FItemContentStyle] that inherits its properties.
  factory FItemContentStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required Color prefix,
    required Color foreground,
    required Color mutedForeground,
  }) {
    final disabledMutedForeground = colors.disable(mutedForeground);
    return FItemContentStyle(
      prefixIconStyle: FVariants.from(
        IconThemeData(color: prefix, size: typography.md.fontSize),
        variants: {
          [.disabled]: .delta(color: colors.disable(prefix)),
        },
      ),
      titleTextStyle: FVariants.from(
        typography.sm.copyWith(color: foreground),
        variants: {
          [.disabled]: .delta(color: colors.disable(foreground)),
        },
      ),
      subtitleTextStyle: FVariants.from(
        typography.xs.copyWith(color: mutedForeground),
        variants: {
          [.disabled]: .delta(color: disabledMutedForeground),
        },
      ),
      detailsTextStyle: FVariants.from(
        typography.xs.copyWith(color: mutedForeground),
        variants: {
          [.disabled]: .delta(color: disabledMutedForeground),
        },
      ),
      suffixIconStyle: FVariants.from(
        IconThemeData(color: mutedForeground, size: typography.md.fontSize),
        variants: {
          [.disabled]: .delta(color: disabledMutedForeground),
        },
      ),
    );
  }
}
