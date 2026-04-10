import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_content.design.dart';

/// Builds a [FButton] slot with the resolved styles.
typedef FButtonContentBuilder =
    Widget Function(
      BuildContext context,
      FButtonStyle style,
      TextStyle textStyle,
      IconThemeData iconStyle,
      FCircularProgressStyle progressStyle,
      Widget? child,
    );

/// Builds a [FButton.icon] content with the resolved icon style.
typedef FButtonIconContentBuilder =
    Widget Function(BuildContext context, FButtonStyle style, IconThemeData iconStyle, Widget? child);

@internal
class Content extends StatelessWidget {
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextBaseline? textBaseline;
  final FButtonContentBuilder? prefixBuilder;
  final Widget? prefix;
  final FButtonContentBuilder? suffixBuilder;
  final Widget? suffix;
  final FButtonContentBuilder builder;
  final Widget? child;

  const Content({
    required this.mainAxisSize,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.textBaseline,
    required this.prefixBuilder,
    required this.prefix,
    required this.suffixBuilder,
    required this.suffix,
    required this.builder,
    required this.child,
    super.key,
  });

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
class IconContent extends StatelessWidget {
  final FButtonIconContentBuilder builder;
  final Widget? child;

  const IconContent({required this.builder, required this.child, super.key});

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
class FButtonContentStyle with Diagnosticable, _$FButtonContentStyleFunctions {
  /// The [TextStyle].
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, TextStyle, TextStyleDelta> textStyle;

  /// The icon's style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> iconStyle;

  /// The circular progress's style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, FCircularProgressStyle, FCircularProgressStyleDelta>
  circularProgressStyle;

  /// The constraints applied to the content.
  @override
  final BoxConstraints constraints;

  /// The padding.
  @override
  final EdgeInsetsGeometry padding;

  /// The spacing between prefix, child, and suffix.
  @override
  final double spacing;

  /// Creates a [FButtonContentStyle].
  const FButtonContentStyle({
    required this.textStyle,
    required this.iconStyle,
    required this.circularProgressStyle,
    this.constraints = const BoxConstraints(),
    this.padding = const .symmetric(horizontal: 10, vertical: 11),
    this.spacing = 6,
  });
}

/// [FButton] icon content's style.
class FButtonIconContentStyle with Diagnosticable, _$FButtonIconContentStyleFunctions {
  /// The icon's style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> iconStyle;

  /// The constraints applied to the icon content.
  @override
  final BoxConstraints constraints;

  /// The padding. Defaults to `EdgeInsets.all(10)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FButtonIconContentStyle].
  const FButtonIconContentStyle({
    required this.iconStyle,
    this.constraints = const BoxConstraints(),
    this.padding = const .all(10),
  });
}
