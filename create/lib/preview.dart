import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'cards/buy_investment.dart';
import 'cards/claimable_balance.dart';
import 'cards/components/preview_icons.dart';
import 'cards/connect_bank.dart';
import 'cards/distribute_track.dart';
import 'cards/faq.dart';
import 'cards/navigation.dart';
import 'cards/notifications.dart';
import 'cards/payments.dart';
import 'cards/payout_preferences.dart';
import 'cards/savings_targets.dart';
import 'cards/sign_in.dart';
import 'cards/smart_home.dart';
import 'cards/social_links.dart';
import 'cards/syncing_accounts.dart';
import 'cards/transfer_funds.dart';
import 'selection.dart';

/// The width of a single-width track.
const _width = 380.0;

/// The gap between tracks and between cards within a track.
const _gap = 32.0;

/// The padding around the whole canvas.
const _padding = 32.0;

/// The compact gap used in place of [_gap].
const _compactGap = 24.0;

/// The compact padding used in place of [_padding].
const _compactPadding = 16.0;

/// The sliver of the next track left visible when in compact mode.
const _peek = 16.0;

/// The main content of the create page.
class Preview extends StatelessWidget {
  final Selection selection;

  const Preview({required this.selection, super.key});

  @override
  Widget build(BuildContext context) {
    final shell = context.theme;
    final radius = shell.style.borderRadius.xl;
    final theme = _theme(selection, shell.colors.brightness);

    return Padding(
      padding: const .fromLTRB(12, 0, 12, 12),
      child: DecoratedBox(
        position: .foreground,
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: shell.colors.border),
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: FTheme(
            data: theme,
            child: FToaster(
              child: PreviewIcons(
                library: selection.icon,
                color: theme.colors.foreground,
                child: ColoredBox(color: theme.colors.muted, child: const _Canvas()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Canvas extends StatelessWidget {
  const _Canvas();

  @override
  Widget build(BuildContext context) {
    final behavior = ScrollConfiguration.of(
      context,
    ).copyWith(scrollbars: false, dragDevices: {.touch, .mouse, .trackpad, .stylus});

    return ScrollConfiguration(
      behavior: behavior,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // When a single-width track no longer fits, tracks stretch to the viewport instead, with tighter padding
          // and a sliver of the next track peeking in to hint that the canvas still scrolls sideways.
          final compact = constraints.maxWidth < _width + 2 * _padding;
          final padding = compact ? _compactPadding : _padding;
          final gap = compact ? _compactGap : _gap;
          final width = compact ? constraints.maxWidth - 2 * padding - _peek : _width;

          return SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: .horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: _Cards(width: width, gap: gap),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Cards extends StatelessWidget {
  final double width;
  final double gap;

  const _Cards({required this.width, required this.gap});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: .min,
    crossAxisAlignment: .start,
    spacing: gap,
    children: [
      _Track(
        width: width,
        gap: gap,
        children: const [SignInCard(), DistributeTrackCard(), FaqCard(), SocialLinksCard()],
      ),
      _Track(width: width, gap: gap, children: const [TransferFundsCard(), NavigationCard(), BuyInvestmentCard()]),
      _Track(
        width: width,
        gap: gap,
        children: const [PayoutPreferencesCard(), SmartHomeCard(), SyncingAccountsCard(), PaymentsCard()],
      ),
      _Track(
        width: width,
        gap: gap,
        children: const [ConnectBankCard(), SavingsTargetsCard(), NotificationsCard(), ClaimableBalanceCard()],
      ),
    ],
  );
}

class _Track extends StatelessWidget {
  final double width;
  final double gap;
  final List<Widget> children;

  const _Track({required this.width, required this.gap, required this.children});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    child: Column(mainAxisSize: .min, crossAxisAlignment: .stretch, spacing: gap, children: children),
  );
}

FThemeData _theme(Selection selection, Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final base = dark ? selection.base.dark : selection.base.light;
  final primary = dark ? selection.primary?.dark : selection.primary?.light;

  final colors = FColors(
    brightness: brightness,
    systemOverlayStyle: dark ? .light : .dark,
    barrier: Color(base.barrier),
    background: Color(base.background),
    foreground: Color(base.foreground),
    primary: Color(primary?.primary ?? base.primary),
    primaryForeground: Color(primary?.primaryForeground ?? base.primaryForeground),
    secondary: Color(base.secondary),
    secondaryForeground: Color(base.secondaryForeground),
    muted: Color(base.muted),
    mutedForeground: Color(base.mutedForeground),
    destructive: Color(base.destructive),
    destructiveForeground: Color(base.destructiveForeground),
    error: Color(base.error),
    errorForeground: Color(base.errorForeground),
    card: Color(base.card),
    border: Color(base.border),
  );

  final typography = FTypography(
    display: FTypeface.inherit(colors: colors, touch: false, fontFamily: selection.display.name),
    body: FTypeface.inherit(colors: colors, touch: false, fontFamily: selection.body.name),
  );

  final r = selection.radius.radius;
  final style = FStyle.inherit(colors: colors, typography: typography, touch: false).copyWith(
    borderRadius: FBorderRadius(
      xs2: .circular(r.xs2),
      xs: .circular(r.xs),
      sm: .circular(r.sm),
      md: .circular(r.md),
      lg: .circular(r.lg),
      xl: .circular(r.xl),
      xl2: .circular(r.xl2),
      xl3: .circular(r.xl3),
      pill: .circular(r.pill),
    ),
  );

  return FThemeData(touch: false, colors: colors, typography: typography, style: style);
}
