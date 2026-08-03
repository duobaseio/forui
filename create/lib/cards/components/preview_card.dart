import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'preview_icons.dart';

/// The shared shell for every preview card.
class PreviewCard extends StatelessWidget {
  /// The title shown in the header.
  final String? title;

  /// A muted line shown beneath the [title].
  final String? subtitle;

  /// A trailing widget shown in the header row.
  final Widget? action;

  /// How the [action] is aligned vertically.
  ///
  /// Defaults to [CrossAxisAlignment.start].
  final CrossAxisAlignment actionAlignment;

  /// The gap between the header and [child].
  final double headerSpacing;

  /// The child.
  final Widget? child;

  /// The footer.
  final Widget? footer;

  /// Whether the [footer] is tinted with the muted color.
  final bool tintedFooter;

  /// Creates a [PreviewCard].
  const PreviewCard({
    this.title,
    this.subtitle,
    this.action,
    this.actionAlignment = .start,
    this.headerSpacing = 16,
    this.child,
    this.footer,
    this.tintedFooter = false,
    super.key,
  }) : assert(footer != null || !tintedFooter, 'tintedFooter has no effect without a footer.');

  @override
  Widget build(BuildContext context) {
    final style = context.theme.cardStyle;
    final colors = context.theme.colors;

    final body = Padding(
      padding: style.padding,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          if (title != null || subtitle != null || action != null) ...[
            Row(
              crossAxisAlignment: actionAlignment,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .stretch,
                    children: [
                      if (title case final title?) Text(title, style: style.titleTextStyle),
                      if (subtitle case final subtitle?)
                        Padding(
                          padding: EdgeInsetsGeometry.only(top: title == null ? 0 : 2),
                          child: Text(subtitle, style: style.subtitleTextStyle),
                        ),
                    ],
                  ),
                ),
                if (action case final action?) Padding(padding: const .directional(start: 12), child: action),
              ],
            ),
            if (child != null) SizedBox(height: headerSpacing),
          ],
          ?child,
        ],
      ),
    );

    Widget content = body;
    if (footer case final footer?) {
      content = Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          body,
          DecoratedBox(
            decoration: BoxDecoration(
              color: tintedFooter ? colors.muted.withValues(alpha: 0.5) : null,
              border: Border(top: BorderSide(color: colors.border)),
            ),
            child: Padding(padding: style.padding, child: footer),
          ),
        ],
      );
    }

    return FCard(
      clipBehavior: tintedFooter ? .antiAlias : .none,
      style: .delta(decoration: .shapeDelta(shadows: context.theme.style.shadow)),
      child: content,
    );
  }
}

/// The muted chip a card offers as its [PreviewCard.action] to dismiss itself.
class PreviewCardCloseButton extends StatelessWidget {
  /// Creates a [PreviewCardCloseButton].
  const PreviewCardCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return FTappable(
      semanticsLabel: 'Close',
      onPress: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(color: colors.muted, borderRadius: theme.style.borderRadius.md),
        child: SizedBox.square(
          dimension: 32,
          child: Center(child: PreviewIcons.of(context).icon(.x, size: 16, color: colors.mutedForeground)),
        ),
      ),
    );
  }
}
