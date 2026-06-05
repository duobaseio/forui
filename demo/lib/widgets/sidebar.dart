import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Center(
      child: Padding(
        padding: const .symmetric(vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 640),
          child: FSidebar(
            style: .delta(
              decoration: .value(BoxDecoration(color: theme.colors.background)),
            ),
            header: Padding(
              padding: const .symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Padding(
                    padding: const .fromLTRB(16, 8, 16, 16),
                    child: Image.network(
                      theme.colors.brightness == .light
                          ? 'https://forui.dev/logos/light_logo.png'
                          : 'https://forui.dev/logos/dark_logo.png',
                      height: 24,
                      webHtmlElementStrategy: .fallback,
                    ),
                  ),
                  const FDivider(style: .delta(padding: .value(.zero))),
                ],
              ),
            ),
            footer: Padding(
              padding: const .symmetric(horizontal: 16),
              child: FCard.raw(
                child: Padding(
                  padding: const .symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    spacing: 10,
                    children: [
                      FAvatar.raw(
                        child: Icon(
                          FLucideIcons.userRound,
                          size: 18,
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          spacing: 2,
                          children: [
                            Text(
                              'Dash',
                              style: theme.typography.sm.copyWith(
                                fontWeight: .bold,
                                color: theme.colors.foreground,
                              ),
                              overflow: .ellipsis,
                            ),
                            Text(
                              'dash@forui.dev',
                              style: theme.typography.xs.copyWith(
                                color: theme.colors.mutedForeground,
                              ),
                              overflow: .ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            children: [
              FSidebarGroup(
                label: const Text('Overview'),
                children: [
                  FSidebarItem(
                    icon: const Icon(FLucideIcons.school),
                    label: const Text('Getting Started'),
                    initiallyExpanded: true,
                    onPress: () {},
                    children: [
                      FSidebarItem(
                        label: const Text('Installation'),
                        selected: true,
                        onPress: () {},
                      ),
                      FSidebarItem(label: const Text('Themes'), onPress: () {}),
                      FSidebarItem(
                        label: const Text('Typography'),
                        onPress: () {},
                      ),
                    ],
                  ),
                  FSidebarItem(
                    icon: const Icon(FLucideIcons.code),
                    label: const Text('API Reference'),
                    onPress: () {},
                  ),
                  FSidebarItem(
                    icon: const Icon(FLucideIcons.box),
                    label: const Text('Pub Dev'),
                    onPress: () {},
                  ),
                ],
              ),
              FSidebarGroup(
                label: const Text('Widgets'),
                action: const Icon(FLucideIcons.plus),
                onActionPress: () {},
                children: [
                  FSidebarItem(
                    icon: const Icon(FLucideIcons.circleSlash),
                    label: const Text('Divider'),
                    onPress: () {},
                  ),
                  FSidebarItem(
                    icon: const Icon(FLucideIcons.scaling),
                    label: const Text('Resizable'),
                    onPress: () {},
                  ),
                  FSidebarItem(
                    icon: const Icon(FLucideIcons.layoutDashboard),
                    label: const Text('Scaffold'),
                    onPress: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
