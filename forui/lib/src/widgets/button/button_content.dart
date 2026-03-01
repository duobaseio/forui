import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_content.design.dart';

@internal
class Content extends StatelessWidget {
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextBaseline? textBaseline;
  final Widget? prefix;
  final Widget? suffix;
  final Widget child;

  const Content({
    required this.mainAxisSize,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.textBaseline,
    required this.prefix,
    required this.suffix,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FButtonData(style: FButtonStyle(:contentStyle), :variants) = .of(context);
    return Padding(
      padding: contentStyle.padding,
      child: DefaultTextStyle.merge(
        style: contentStyle.textStyle.resolve(variants),
        child: IconTheme(
          data: contentStyle.iconStyle.resolve(variants),
          child: FInheritedCircularProgressStyle(
            style: contentStyle.circularProgressStyle.resolve(variants),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              textBaseline: textBaseline,
              spacing: contentStyle.spacing,
              children: [?prefix, child, ?suffix],
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
      ..add(EnumProperty('textBaseline', textBaseline));
  }
}

@internal
class IconContent extends StatelessWidget {
  final Widget child;

  const IconContent({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final FButtonData(:style, :variants) = .of(context);

    return Padding(
      padding: style.iconContentStyle.padding,
      child: IconTheme(data: style.iconContentStyle.iconStyle.resolve(variants), child: child),
    );
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

  /// The padding.
  @override
  final EdgeInsetsGeometry padding;

  /// The spacing between prefix, child, and suffix..
  @override
  final double spacing;

  /// Creates a [FButtonContentStyle].
  const FButtonContentStyle({
    required this.textStyle,
    required this.iconStyle,
    required this.circularProgressStyle,
    this.padding = const .symmetric(horizontal: 10, vertical: 11),
    this.spacing = 6,
  });
}

/// [FButton] icon content's style.
class FButtonIconContentStyle with Diagnosticable, _$FButtonIconContentStyleFunctions {
  /// The icon's style.
  @override
  final FVariants<FTappableVariantConstraint, FTappableVariant, IconThemeData, IconThemeDataDelta> iconStyle;

  /// The padding. Defaults to `EdgeInsets.all(10)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FButtonIconContentStyle].
  const FButtonIconContentStyle({required this.iconStyle, this.padding = const .all(10)});
}
