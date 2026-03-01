import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'card_content.design.dart';

@internal
class Content extends StatelessWidget {
  final Widget? image;
  final Widget? title;
  final Widget? subtitle;
  final Widget? child;
  final MainAxisSize mainAxisSize;
  final FCardStyleDelta style;

  const Content({
    required this.mainAxisSize,
    required this.style,
    this.image,
    this.title,
    this.subtitle,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style(context.theme.cardStyle).contentStyle;
    return Padding(
      padding: style.padding,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: mainAxisSize,
        children: [
          if (image case final image?)
            ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedSuperellipseBorder(borderRadius: context.theme.style.borderRadius.lg),
              ),
              child: image,
            ),
          if ((title != null || subtitle != null || child != null) && image != null)
            SizedBox(height: style.imageSpacing),
          if (title case final title?)
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.titleTextStyle,
              child: title,
            ),

          if (title != null && subtitle != null) SizedBox(height: style.titleSpacing),
          if (subtitle case final subtitle?)
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.subtitleTextStyle,
              child: subtitle,
            ),
          if (title != null && subtitle != null && child != null) SizedBox(height: style.subtitleSpacing),
          ?child,
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('mainAxisSize', mainAxisSize))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('image', image));
  }
}

/// [FCard] content's style.
class FCardContentStyle with Diagnosticable, _$FCardContentStyleFunctions {
  /// The spacing between the image and the title, subtitle, and child if any of them is provided. Defaults to 24.
  @override
  final double imageSpacing;

  /// The spacing between the title and the subtitle. Defaults to 2.
  @override
  final double titleSpacing;

  /// The spacing between the title/subtitle and the child. Defaults to 6.
  @override
  final double subtitleSpacing;

  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The subtitle's [TextStyle].
  @override
  final TextStyle subtitleTextStyle;

  /// The padding. Defaults to `EdgeInsets.all(16)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FCardContentStyle].
  const FCardContentStyle({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.imageSpacing = 24,
    this.titleSpacing = 2,
    this.subtitleSpacing = 6,
    this.padding = const .all(16),
  });
}
