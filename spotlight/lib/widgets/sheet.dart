import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Sheet extends StatelessWidget {
  const Sheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: FCard(
        child: SizedBox(
          width: 320,
          height: 220,
          child: Stack(
            children: [
              Center(
                child: Text(
                  'FSheet Demo',
                  style: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground),
                ),
              ),
              Align(
                alignment: .topCenter,
                child: Padding(
                  padding: const .all(10),
                  child: _trigger(
                    context,
                    key: 'top',
                    side: .ttb,
                    icon: FLucideIcons.panelTop,
                    builder: (_) => const _Notifications(),
                  ),
                ),
              ),
              Align(
                alignment: .centerLeft,
                child: Padding(
                  padding: const .all(10),
                  child: _trigger(
                    context,
                    key: 'left',
                    side: .ltr,
                    icon: FLucideIcons.panelLeft,
                    builder: (_) => const _Menu(),
                  ),
                ),
              ),
              Align(
                alignment: .centerRight,
                child: Padding(
                  padding: const .all(10),
                  child: _trigger(
                    context,
                    key: 'right',
                    side: .rtl,
                    icon: FLucideIcons.panelRight,
                    builder: (_) => const _Account(),
                  ),
                ),
              ),
              Align(
                alignment: .bottomCenter,
                child: Padding(
                  padding: const .all(10),
                  child: _trigger(
                    context,
                    key: 'bottom',
                    side: .btt,
                    icon: FLucideIcons.panelBottom,
                    builder: (_) => const _Share(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trigger(
    BuildContext context, {
    required String key,
    required FLayout side,
    required IconData icon,
    required WidgetBuilder builder,
  }) => FButton.icon(
    key: ValueKey(key),
    variant: .outline,
    onPress: () => showFSheet(context: context, side: side, builder: builder),
    child: Icon(icon),
  );
}

class _Notifications extends StatelessWidget {
  const _Notifications();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return _Sheet(
      side: .ttb,
      child: Column(
        mainAxisSize: .min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const .all(16),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Padding(
                    padding: const .fromLTRB(12, 4, 12, 4),
                    child: Text(
                      'Notifications',
                      style: theme.typography.body.lg.copyWith(fontWeight: .w600, color: theme.colors.foreground),
                    ),
                  ),
                  FItemGroup(
                    children: [
                      FItem(
                        prefix: const Icon(FLucideIcons.messageSquare),
                        title: const Text('Mira commented on your design'),
                        details: const Text('2m'),
                        onPress: () => Navigator.of(context).pop(),
                      ),
                      FItem(
                        prefix: const Icon(FLucideIcons.userRound),
                        title: const Text('Alex accepted your invite'),
                        details: const Text('1h'),
                        onPress: () => Navigator.of(context).pop(),
                      ),
                      FItem(
                        prefix: const Icon(FLucideIcons.creditCard),
                        title: const Text('Your July invoice is ready'),
                        details: const Text('3h'),
                        onPress: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return _Sheet(
      side: .ltr,
      child: SizedBox(
        width: 300,
        child: FSidebar(
          style: .delta(decoration: .value(BoxDecoration(color: theme.colors.background))),
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
                const FDivider(style: .delta(padding: .value(.only(bottom: 12)))),
              ],
            ),
          ),
          children: [
            FSidebarGroup(
              label: const Text('Overview'),
              children: [
                FSidebarItem(
                  icon: const Icon(FLucideIcons.house),
                  label: const Text('Home'),
                  selected: true,
                  onPress: () => Navigator.of(context).pop(),
                ),
                FSidebarItem(
                  icon: const Icon(FLucideIcons.compass),
                  label: const Text('Explore'),
                  onPress: () => Navigator.of(context).pop(),
                ),
                FSidebarItem(
                  icon: const Icon(FLucideIcons.libraryBig),
                  label: const Text('Library'),
                  onPress: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            FSidebarGroup(
              label: const Text('Settings'),
              children: [
                FSidebarItem(
                  icon: const Icon(FLucideIcons.userRound),
                  label: const Text('Account'),
                  onPress: () => Navigator.of(context).pop(),
                ),
                FSidebarItem(
                  icon: const Icon(FLucideIcons.bell),
                  label: const Text('Notifications'),
                  onPress: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Account extends StatelessWidget {
  const _Account();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return _Sheet(
      side: .rtl,
      child: SizedBox(
        width: 360,
        child: Padding(
          padding: const .all(24),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Account',
                style: theme.typography.display.xl.copyWith(
                  fontWeight: .w600,
                  color: theme.colors.foreground,
                  height: 1.5,
                ),
              ),
              Text(
                'Make changes to your account here. Click save when you are done.',
                style: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground),
              ),
              const SizedBox(height: 16),
              const FTextField(label: Text('Name'), hint: 'Dash'),
              const SizedBox(height: 12),
              const FTextField(label: Text('Email'), hint: 'dash@forui.dev'),
              const SizedBox(height: 20),
              Align(
                alignment: .centerRight,
                child: FButton(
                  size: .sm,
                  mainAxisSize: .min,
                  onPress: () => Navigator.of(context).pop(),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Share extends StatelessWidget {
  const _Share();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return _Sheet(
      side: .btt,
      child: Column(
        mainAxisSize: .min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const .all(16),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Padding(
                    padding: const .fromLTRB(12, 4, 12, 4),
                    child: Text(
                      'Share this page',
                      style: theme.typography.body.lg.copyWith(fontWeight: .w600, color: theme.colors.foreground),
                    ),
                  ),
                  FItemGroup(
                    children: [
                      FItem(
                        prefix: const Icon(FLucideIcons.link),
                        title: const Text('Copy link'),
                        details: const Text('⌘C'),
                        onPress: () => Navigator.of(context).pop(),
                      ),
                      FItem(
                        prefix: const Icon(FLucideIcons.mail),
                        title: const Text('Email'),
                        details: const Text('⌘E'),
                        onPress: () => Navigator.of(context).pop(),
                      ),
                      FItem(
                        prefix: const Icon(FLucideIcons.download),
                        title: const Text('Download PDF'),
                        details: const Text('⌘D'),
                        onPress: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  final FLayout side;
  final Widget child;

  const _Sheet({required this.side, required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Container(
      width: side.vertical ? double.infinity : null,
      height: side.vertical ? null : double.infinity,
      decoration: BoxDecoration(
        color: colors.background,
        border: side.vertical
            ? .symmetric(horizontal: BorderSide(color: colors.border))
            : .symmetric(vertical: BorderSide(color: colors.border)),
      ),
      child: child,
    );
  }
}
