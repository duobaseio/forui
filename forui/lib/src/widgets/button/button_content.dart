import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_content.design.dart';

/// Builds a [FButton] slot with the resolved styles.
typedef FButtonContentBuilder = Widget Function(
  BuildContext context,
  FButtonStyle style,
  TextStyle textStyle,
  IconThemeData iconStyle,
  FCircularProgressStyle progressStyle,
  Widget? child,
);

/// Builds a [FButton.icon] content with the resolved icon style.
typedef FButtonIconContentBuilder = Widget Function(
  BuildContext context,
  FButtonStyle style,
  IconThemeData iconStyle,
  Widget? child,
);

@internal
class const Content({
  required final MainAxisSize mainAxisSize,
  required final MainAxisAlignment mainAxisAlignment,
  required final CrossAxisAlignment crossAxisAlignment,
  required final TextBaseline? textBaseline,
  required final FButtonContentBuilder? prefixBuilder,
  required final Widget? prefix,
  required final FButtonContentBuilder? suffixBuilder,
  required final Widget? suffix,
  required final FButtonContentBuilder builder,
  required final Widget? child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FButtonData(:style, :variants) = .of(context);
    final contentStyle = style.contentStyle;
    final textStyle = contentStyle.textStyle.resolve(variants);
    final iconStyle = contentStyle.iconStyle.resolve(variants);
    final progressStyle = contentStyle.circularProgressStyle.resolve(variants);

    return ConstrainedBox(
      constraints: contentStyle.constraints,
      child: Padding(
        padding: contentStyle.padding,
        child: DefaultTextStyle.merge(
          style: textStyle,
          child: IconTheme(
            data: iconStyle,
            child: FInheritedCircularProgressStyle(
              style: progressStyle,
              child: Row(
                mainAxisAlignment: mainAxisAlignment,
                mainAxisSize: mainAxisSize,
                crossAxisAlignment: crossAxisAlignment,
                textBaseline: textBaseline,
                spacing: contentStyle.spacing,
                children: [
                  if (prefixBuilder case final prefixBuilder?)
                    prefixBuilder(context, style, textStyle, iconStyle, progressStyle, prefix)
                  else
                    ?prefix,
                  builder(context, style, textStyle, iconStyle, progressStyle, child),
                  if (suffixBuilder case final suffixBuilder?)
                    suffixBuilder(context, style, textStyle, iconStyle, progressStyle, suffix)
                  else
                    ?suffix,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('mainAxisSize', mainAxisSize, defaultValue: MainAxisSize.max))
      ..add(EnumProperty('mainAxisAlignment', mainAxisAlignment))
      ..add(EnumProperty('crossAxisAlignment', crossAxisAlignment))
      ..add(EnumProperty('textBaseline', textBaseline))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(DiagnosticsProperty('builder', builder));
  }
}

@internal
class const IconContent({required final FButtonIconContentBuilder builder, required final Widget? child, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FButtonData(:style, :variants) = .of(context);
    final iconStyle = style.iconContentStyle.iconStyle.resolve(variants);

    return ConstrainedBox(
      constraints: style.iconContentStyle.constraints,
      child: Padding(
        padding: style.iconContentStyle.padding,
        child: Center(
          widthFactor: 1,
          heightFactor: 1,
          child: IconTheme(data: iconStyle, child: builder(context, style, iconStyle, child)),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('builder', builder));
  }
}

/// [FButton] content's style.
class const FButtonContentStyle({
  /// The [TextStyle].
  @override required final FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> textStyle,

  /// The icon's style.
  @override
  required final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> iconStyle,

  /// The circular progress's style.
  @override
  required final FVariants<
    FTappableVariantConstraint,
    FTappableVariant,
    FCircularProgressStyle,
    FCircularProgressStyleDelta
  >
  circularProgressStyle,

  /// The constraints applied to the content. Defaults to `BoxConstraints()`.
  @override final BoxConstraints constraints = const BoxConstraints(),

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 10, vertical: 11)`.
  @override final EdgeInsetsGeometry padding = const .symmetric(horizontal: 10, vertical: 11),

  /// The spacing between prefix, child, and suffix. Defaults to 6.
  @override final double spacing = 6,
}) with Diagnosticable, _$FButtonContentStyleFunctions {
  /// Creates a [FButtonContentStyle].
  this;
}

/// [FButton] icon content's style.
class const FButtonIconContentStyle({
  /// The icon's style.
  @override
  required final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> iconStyle,

  /// The constraints applied to the icon content. Defaults to `BoxConstraints()`.
  @override final BoxConstraints constraints = const BoxConstraints(),

  /// The padding. Defaults to `EdgeInsets.all(10)`.
  @override final EdgeInsetsGeometry padding = const .all(10),
}) with Diagnosticable, _$FButtonIconContentStyleFunctions {
  /// Creates a [FButtonIconContentStyle].
  this;
}
