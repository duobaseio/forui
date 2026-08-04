import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';
import 'components/preview_icons.dart';

/// A pair of grouped navigation lists.
class NavigationCard extends StatelessWidget {
  /// Creates a [NavigationCard].
  const NavigationCard({super.key});

  @override
  Widget build(BuildContext context) => const Row(
    crossAxisAlignment: .start,
    spacing: 16,
    children: [
      Expanded(child: _Overview()),
      Expanded(child: _Account()),
    ],
  );
}

class _Overview extends StatelessWidget {
  const _Overview();

  @override
  Widget build(BuildContext context) => const PreviewCard(
    child: _Nav(
      groups: [
        _Group(
          label: 'Overview',
          items: [
            _Item(icon: .layoutDashboard, label: 'Dashboard', selected: true),
            _Item(icon: .arrowLeftRight, label: 'Transactions'),
            _Item(icon: .trendingUp, label: 'Investments'),
            _Item(icon: .landmark, label: 'Accounts'),
            _Item(icon: .pieChart, label: 'Spending'),
          ],
        ),
        _Group(
          label: 'Planning',
          items: [
            _Item(icon: .target, label: 'Goals'),
            _Item(icon: .wallet, label: 'Budget'),
            _Item(icon: .barChart, label: 'Reports'),
            _Item(icon: .fileText, label: 'Documents'),
          ],
        ),
      ],
    ),
  );
}

class _Account extends StatelessWidget {
  const _Account();

  @override
  Widget build(BuildContext context) => const PreviewCard(
    child: _Nav(
      groups: [
        _Group(
          label: 'Account',
          items: [
            _Item(icon: .user, label: 'Profile'),
            _Item(icon: .creditCard, label: 'Billing', selected: true),
            _Item(icon: .bell, label: 'Notifications'),
            _Item(icon: .shield, label: 'Security'),
            _Item(icon: .paintbrush, label: 'Appearance'),
          ],
        ),
        _Group(
          label: 'Support',
          items: [
            _Item(icon: .helpCircle, label: 'Help Center'),
            _Item(icon: .messageSquare, label: 'Contact Us'),
            _Item(icon: .bookOpen, label: 'Documentation'),
            _Item(icon: .activity, label: 'Status'),
          ],
        ),
      ],
    ),
  );
}

/// A single navigation destination.
class _Item {
  final PreviewIcon icon;
  final String label;
  final bool selected;

  const _Item({required this.icon, required this.label, this.selected = false});
}

/// A labelled run of [_Item]s.
class _Group {
  final String label;
  final List<_Item> items;

  const _Group({required this.label, required this.items});
}

class _Nav extends StatelessWidget {
  final List<_Group> groups;

  const _Nav({required this.groups});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .stretch,
    children: [
      for (final (index, group) in groups.indexed) ...[
        if (index != 0) FDivider(style: .delta(padding: .value(const .symmetric(vertical: 12)))),
        _GroupSection(group: group),
      ],
    ],
  );
}

class _GroupSection extends StatelessWidget {
  final _Group group;

  const _GroupSection({required this.group});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        Padding(
          padding: const .directional(start: 10, bottom: 6),
          child: Text(
            group.label,
            style: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground),
            maxLines: 1,
            overflow: .ellipsis,
          ),
        ),
        for (final item in group.items) _Row(item: item),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final _Item item;

  const _Row({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final icons = PreviewIcons.of(context);
    final foreground = item.selected ? colors.foreground : colors.mutedForeground;

    return FTappable(
      focusedOutlineStyle: theme.style.focusedOutlineStyle,
      semanticsLabel: item.label,
      selected: item.selected,
      onPress: () {},
      builder: (context, variants, child) => DecoratedBox(
        decoration: BoxDecoration(
          color: switch (variants) {
            _ when item.selected => colors.muted,
            _ when variants.contains(FTappableVariant.hovered) => colors.muted.withValues(alpha: 0.5),
            _ => null,
          },
          borderRadius: theme.style.borderRadius.md,
        ),
        child: child,
      ),
      child: SizedBox(
        height: 36,
        child: Padding(
          padding: const .symmetric(horizontal: 10),
          child: Row(
            children: [
              icons.icon(item.icon, size: 18, color: foreground),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.label,
                  style: theme.typography.body.sm.copyWith(color: foreground),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
