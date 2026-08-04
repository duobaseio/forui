import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_cli/forui_cli.dart';

import 'package:create/cards/buy_investment.dart';
import 'package:create/cards/claimable_balance.dart';
import 'package:create/cards/components/preview_icons.dart';
import 'package:create/cards/connect_bank.dart';
import 'package:create/cards/distribute_track.dart';
import 'package:create/cards/faq.dart';
import 'package:create/cards/navigation.dart';
import 'package:create/cards/notifications.dart';
import 'package:create/cards/payments.dart';
import 'package:create/cards/payout_preferences.dart';
import 'package:create/cards/savings_targets.dart';
import 'package:create/cards/sign_in.dart';
import 'package:create/cards/smart_home.dart';
import 'package:create/cards/social_links.dart';
import 'package:create/cards/syncing_accounts.dart';
import 'package:create/cards/transfer_funds.dart';

import 'utils/fonts.dart';
import 'utils/shell.dart';

const _cards = <String, Widget>{
  'sign_in': SignInCard(),
  'distribute_track': DistributeTrackCard(),
  'faq': FaqCard(),
  'social_links': SocialLinksCard(),
  'transfer_funds': TransferFundsCard(),
  'navigation': NavigationCard(),
  'buy_investment': BuyInvestmentCard(),
  'payout_preferences': PayoutPreferencesCard(),
  'smart_home': SmartHomeCard(),
  'syncing_accounts': SyncingAccountsCard(),
  'payments': PaymentsCard(),
  'connect_bank': ConnectBankCard(),
  'savings_targets': SavingsTargetsCard(),
  'notifications': NotificationsCard(),
  'claimable_balance': ClaimableBalanceCard(),
};

/// Wraps [card] in the preview environment.
Widget _preview(Widget card, double width, FontFamily font) {
  final base = FTheme.neutral.light.desktop;
  final typography = FTypography(
    display: FTypeface.inherit(colors: base.colors, touch: false, fontFamily: font.name),
    body: FTypeface.inherit(colors: base.colors, touch: false, fontFamily: font.name),
  );
  final theme = FThemeData(
    touch: false,
    colors: base.colors,
    typography: typography,
    style: FStyle.inherit(colors: base.colors, typography: typography, touch: false),
  );

  return shell(
    child: FTheme(
      data: theme,
      child: FToaster(
        child: PreviewIcons(
          library: .lucide,
          color: theme.colors.foreground,
          child: SingleChildScrollView(
            child: Align(
              alignment: .topLeft,
              child: SizedBox(width: width, child: card),
            ),
          ),
        ),
      ),
    ),
  );
}

/// The widest of the bundled fonts.
FontFamily _widestFont() {
  const sample = 'Sphinx of black quartz, judge my vow. 0123456789';
  var widest = (family: FontFamily.values.first, width: 0.0);

  for (final family in FontFamily.values) {
    final painter = TextPainter(
      text: TextSpan(
        text: sample,
        style: TextStyle(fontFamily: family.name, fontSize: 14),
      ),
      textDirection: .ltr,
    )..layout();

    if (painter.width > widest.width) {
      widest = (family: family, width: painter.width);
    }

    painter.dispose();
  }

  // A family that fails to resolve falls back to Ahem (every glyph a full em) and would win the measurement; real
  // fonts average well under 1em per glyph.
  assert(widest.width < sample.length * 14 * 0.8, '${widest.family.name} did not resolve; did loadAppFonts() run?');
  return widest.family;
}

void main() {
  late FontFamily widest;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await loadAppFonts();
    widest = _widestFont();
  });

  for (final MapEntry(key: name, value: card) in _cards.entries) {
    // 380: default width, 300: lowest bound and with margins for mobile devices.
    for (final width in const [380.0, 300.0]) {
      testWidgets('card $name at $width in the widest font', (tester) async {
        await tester.pumpWidget(_preview(card, width, widest));
        await tester.pump();
      });
    }
  }
}
