import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';
import 'components/preview_icons.dart';

/// A payments settings hub that links to various pages.
class PaymentsCard extends StatelessWidget {
  /// Creates a [PaymentsCard].
  const PaymentsCard({super.key});

  @override
  Widget build(BuildContext context) => const PreviewCard(
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        _Breadcrumb(),
        SizedBox(height: 10),
        _Link(
          icon: .gauge,
          title: 'Change transfer limit',
          description: 'Adjust how much you can send from your balance.',
        ),
        SizedBox(height: 12),
        _Link(icon: .calendar, title: 'Scheduled transfers', description: 'Set up a transfer to send at a later date.'),
        SizedBox(height: 12),
        _Link(icon: .repeat, title: 'Direct Debits', description: 'Set up and manage regular payments.'),
        SizedBox(height: 12),
        _Link(
          icon: .refreshCw,
          title: 'Recurring card payments',
          description: 'Manage your repeated card transactions.',
        ),
      ],
    ),
  );
}

/// The trail leading to the current page, with the intermediate crumbs tucked behind an ellipsis.
class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb();

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final icons = PreviewIcons.of(context);

    return FBreadcrumb(
      divider: icons.icon(.chevronRight, size: 14, color: colors.mutedForeground),
      children: [
        FBreadcrumbItem(onPress: () {}, child: const Text('Home')),
        FBreadcrumbItem.collapsed(
          icon: icons.icon(.ellipsis, size: 16, color: colors.mutedForeground),
          menu: [
            .group(
              children: [
                .item(title: const Text('Accounts'), onPress: () {}),
                .item(title: const Text('Move Money'), onPress: () {}),
              ],
            ),
          ],
        ),
        const FBreadcrumbItem(current: true, child: Text('Payments')),
      ],
    );
  }
}

/// A tappable tile.
class _Link extends StatelessWidget {
  final PreviewIcon icon;
  final String title;
  final String description;

  const _Link({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    final icons = PreviewIcons.of(context);
    final titleStyle = typography.body.sm.copyWith(color: colors.foreground, fontWeight: .w500);

    return FTappable(
      focusedOutlineStyle: theme.style.focusedOutlineStyle,
      semanticsLabel: '$title. $description',
      onPress: () {},
      builder: (context, variants, child) => DecoratedBox(
        decoration: BoxDecoration(
          color: variants.contains(FTappableVariant.hovered) ? colors.muted : colors.muted.withValues(alpha: 0.5),
          borderRadius: theme.style.borderRadius.lg,
        ),
        child: child,
      ),
      child: Padding(
        padding: const .symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(
                    height: (titleStyle.fontSize ?? 14) * (titleStyle.height ?? 1),
                    child: Center(child: icons.icon(icon, size: 14, color: colors.foreground)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .stretch,
                      children: [
                        Text(title, style: titleStyle),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          style: typography.body.xs.copyWith(color: colors.mutedForeground, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            icons.icon(.chevronRight, size: 16, color: colors.mutedForeground),
          ],
        ),
      ),
    );
  }
}
