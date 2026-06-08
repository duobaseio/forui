@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:intl/intl.dart' show DateFormat;

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/header.dart';
import '../../test_scaffold.dart';

final _date = DateTime.utc(2024, 6, 15);

Widget _harness({
  required FThemeData theme,
  required Widget Function(FCalendarHeaderStyle style, FLocalizations l10n) header,
  TextDirection? textDirection,
  Locale? locale,
}) => TestScaffold.app(
  theme: theme,
  locale: locale,
  textDirection: textDirection,
  child: Builder(
    builder: (context) => SizedBox(
      width: 320,
      child: header(theme.calendarStyle.headerStyle, FLocalizations.of(context) ?? FDefaultLocalizations()),
    ),
  ),
);

void main() {
  for (final theme in TestScaffold.themes) {
    Future<void> expectGolden(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('calendar/header/${theme.name}/$name.png'));
    }

    Widget split({
      required FCalendarHeaderStyle style,
      required FLocalizations l10n,
      bool month = false,
      bool year = false,
      bool navEnabled = true,
    }) => SplitHeader(
      style: style,
      localizations: l10n,
      date: _date,
      previousSemanticsLabel: l10n.calendarPreviousMonthSemanticsLabel,
      nextSemanticsLabel: l10n.calendarNextMonthSemanticsLabel,
      month: month,
      year: year,
      onMonth: () {},
      onYear: () {},
      onPrevious: navEnabled ? () {} : null,
      onNext: navEnabled ? () {} : null,
    );

    Widget single({
      required FCalendarHeaderStyle style,
      required FLocalizations l10n,
      bool monthYear = false,
      bool navEnabled = true,
    }) => Header(
      style: style,
      label: DateFormat.yMMMM(l10n.localeName).format(_date),
      previousSemanticsLabel: l10n.calendarPreviousMonthSemanticsLabel,
      nextSemanticsLabel: l10n.calendarNextMonthSemanticsLabel,
      shown: monthYear,
      onPress: () {},
      onPrevious: navEnabled ? () {} : null,
      onNext: navEnabled ? () {} : null,
    );

    group('${theme.name} SplitHeader', () {
      testWidgets('split-resting', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => split(style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'split-resting');
      });

      testWidgets('split-month-expanded', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => split(month: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'split-month-expanded');
      });

      testWidgets('split-year-expanded', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => split(year: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'split-year-expanded');
      });

      testWidgets('split-nav-disabled', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => split(navEnabled: false, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'split-nav-disabled');
      });

      testWidgets('split-single', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => SplitHeader.single(
              style: s,
              localizations: l,
              date: _date,
              month: true,
              year: false,
              onMonth: () {},
              onYear: () {},
            ),
          ),
        );
        await expectGolden(tester, 'split-single');
      });

      testWidgets('split-rtl', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            textDirection: .rtl,
            header: (s, l) => split(month: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'split-rtl');
      });

      testWidgets('split-hovered', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => split(style: s, l10n: l),
          ),
        );
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await gesture.moveTo(tester.getCenter(find.text('June')));
        await expectGolden(tester, 'split-hovered');
      });

      // Hungarian orders the year before the month ('y. MMMM'), so the year tappable should render first.
      testWidgets('split-year-first', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            locale: const Locale('hu'),
            header: (s, l) => split(month: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'split-year-first');
      });

      testWidgets('split-year-first-rtl', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            locale: const Locale('hu'),
            textDirection: .rtl,
            header: (s, l) => split(month: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'split-year-first-rtl');
      });
    });

    group('${theme.name} Header', () {
      testWidgets('single-resting', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => single(style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'single-resting');
      });

      testWidgets('single-expanded', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => single(monthYear: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'single-expanded');
      });

      testWidgets('single-nav-disabled', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => single(navEnabled: false, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'single-nav-disabled');
      });

      testWidgets('single-no-nav', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => Header.single(
              style: s,
              label: DateFormat.yMMMM(l.localeName).format(_date),
              shown: false,
              onPress: () {},
            ),
          ),
        );
        await expectGolden(tester, 'single-no-nav');
      });

      testWidgets('single-rtl', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            textDirection: .rtl,
            header: (s, l) => single(monthYear: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'single-rtl');
      });

      testWidgets('single-hovered', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => single(style: s, l10n: l),
          ),
        );
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await gesture.moveTo(tester.getCenter(find.text('June 2024')));
        await expectGolden(tester, 'single-hovered');
      });
    });

    group('${theme.name} Header factories', () {
      testWidgets('factory-day', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => Header.day(
              style: s,
              localizations: l,
              monthYear: _date,
              shown: false,
              onPress: () {},
              onPrevious: () {},
              onNext: () {},
            ),
          ),
        );
        await expectGolden(tester, 'factory-day');
      });

      testWidgets('factory-month', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => Header.month(
              style: s,
              localizations: l,
              year: _date,
              shown: false,
              onPress: () {},
              onPrevious: () {},
              onNext: () {},
            ),
          ),
        );
        await expectGolden(tester, 'factory-month');
      });

      testWidgets('factory-year', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => Header.year(
              style: s,
              localizations: l,
              decade: DateTime.utc(2020),
              shown: false,
              onPress: () {},
              onPrevious: () {},
              onNext: () {},
            ),
          ),
        );
        await expectGolden(tester, 'factory-year');
      });

      testWidgets('factory-single-month', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => Header.singleMonth(style: s, localizations: l, year: _date, shown: false, onPress: () {}),
          ),
        );
        await expectGolden(tester, 'factory-single-month');
      });

      testWidgets('factory-single-day', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) =>
                Header.singleDay(style: s, localizations: l, monthYear: _date, shown: false, onPress: () {}),
          ),
        );
        await expectGolden(tester, 'factory-single-day');
      });

      testWidgets('factory-single-day-expanded', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) =>
                Header.singleDay(style: s, localizations: l, monthYear: _date, shown: true, onPress: () {}),
          ),
        );
        await expectGolden(tester, 'factory-single-day-expanded');
      });
    });
  }
}
