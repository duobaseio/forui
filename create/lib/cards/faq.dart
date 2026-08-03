import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

/// Frequently-asked questions.
class FaqCard extends StatelessWidget {
  /// Creates a [FaqCard].
  const FaqCard({super.key});

  // The last item's divider is hidden so it doesn't double up with the footer's hairline.
  static const _last = FAccordionStyleDelta.delta(dividerStyle: .delta(color: Color(0x00000000)));

  @override
  Widget build(BuildContext context) => PreviewCard(
    title: 'Frequently Asked Questions',
    footer: FButton(variant: .outline, onPress: () {}, child: const Text('Contact Support')),
    child: FTabs(
      children: [
        .entry(
          label: const Text('General'),
          child: const FAccordion(
            children: [
              FAccordionItem(
                initiallyExpanded: true,
                title: Text('How secure is my financial data with Ledger?'),
                child: Text(
                  'We use bank-level AES-256 encryption, SOC 2 Type II certified infrastructure, and never store '
                  'your credentials. All connections use read-only access tokens. We are a SEC registered '
                  'investment advisor.',
                ),
              ),
              FAccordionItem(
                title: Text('How do I connect my bank or investment accounts?'),
                child: Text(
                  'Search for your institution, sign in through its own secure portal, and Ledger syncs balances '
                  'and transactions within a few minutes. We support over 12,000 banks and brokerages.',
                ),
              ),
              FAccordionItem(
                style: _last,
                title: Text('Can I export my data for tax purposes?'),
                child: Text(
                  'Yes. Export your full transaction history or a realized gains report as CSV or PDF at any time. '
                  'Both formats import cleanly into common tax software.',
                ),
              ),
            ],
          ),
        ),
        .entry(
          label: const Text('Billing'),
          child: const FAccordion(
            children: [
              FAccordionItem(
                title: Text('Which plan is right for me?'),
                child: Text(
                  'Free covers up to three linked accounts. Plus adds unlimited accounts and portfolio insights, '
                  'while Premium layers on tax reporting and a dedicated advisor.',
                ),
              ),
              FAccordionItem(
                title: Text('Where do I find my invoices?'),
                child: Text(
                  'Every invoice lives in your billing settings, and we email a copy to your account address the '
                  'moment a payment clears.',
                ),
              ),
              FAccordionItem(
                style: _last,
                title: Text('Do you offer refunds?'),
                child: Text(
                  'Cancel within 30 days of a charge and we refund it in full. Annual plans are prorated from the '
                  'month you cancel.',
                ),
              ),
            ],
          ),
        ),
        .entry(
          label: const Text('Goals'),
          child: const FAccordion(
            children: [
              FAccordionItem(
                title: Text('How do I create a savings goal?'),
                child: Text(
                  'Pick a target amount and date, then choose which accounts fund it. Ledger works out the monthly '
                  'contribution you need to stay on track.',
                ),
              ),
              FAccordionItem(
                title: Text('How is my progress tracked?'),
                child: Text(
                  'Balances refresh every night, so progress bars and projected completion dates stay current '
                  'without any manual entry.',
                ),
              ),
              FAccordionItem(
                style: _last,
                title: Text('Can I share a goal with my partner?'),
                child: Text(
                  'Invite anyone with a Ledger account to a shared goal. You both see contributions and progress, '
                  'while the rest of your accounts stay private.',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
