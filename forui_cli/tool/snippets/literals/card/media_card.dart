import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

class MediaCard extends StatelessWidget {
  final Widget image;
  final Widget title;
  final Widget subtitle;
  final Widget child;

  const MediaCard({required this.image, required this.title, required this.subtitle, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.theme.cardStyle;
    return FCard(
      style: style,
      child: Padding(
        padding: style.padding,
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedSuperellipseBorder(borderRadius: context.theme.style.borderRadius.lg),
              ),
              child: image,
            ),
            const SizedBox(height: 24),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.titleTextStyle,
              child: title,
            ),
            const SizedBox(height: 2),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.subtitleTextStyle,
              child: subtitle,
            ),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}
