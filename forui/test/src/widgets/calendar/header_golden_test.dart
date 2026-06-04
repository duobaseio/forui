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
}) => TestScaffold(
  theme: theme,
  textDirection: textDirection,
  child: Builder(
    builder: (context) {
      final t = context.theme;
      final style = FCalendarHeaderStyle.inherit(
        colors: t.colors,
        typography: t.typography,
        icons: t.icons,
        style: t.style,
        touch: context.platformVariant.touch,
      );
      return SizedBox(width: 320, child: header(style, FLocalizations.of(context) ?? FDefaultLocalizations()));
    },
  ),
);

void main() {
  for (final theme in TestScaffold.themes) {
    Future<void> expectGolden(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('calendar-header/${theme.name}/$name.png'));
    }

    Widget dual({
      required FCalendarHeaderStyle style,
      required FLocalizations l10n,
      bool month = false,
      bool year = false,
      bool navEnabled = true,
    }) => DualHeader(
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

    group('${theme.name} DualHeader', () {
      testWidgets('dual-resting', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => dual(style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'dual-resting');
      });

      testWidgets('dual-month-expanded', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => dual(month: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'dual-month-expanded');
      });

      testWidgets('dual-year-expanded', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => dual(year: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'dual-year-expanded');
      });

      testWidgets('dual-nav-disabled', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => dual(navEnabled: false, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'dual-nav-disabled');
      });

      testWidgets('dual-rtl', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            textDirection: .rtl,
            header: (s, l) => dual(month: true, style: s, l10n: l),
          ),
        );
        await expectGolden(tester, 'dual-rtl');
      });

      testWidgets('dual-hovered', (tester) async {
        await tester.pumpWidget(
          _harness(
            theme: theme.data,
            header: (s, l) => dual(style: s, l10n: l),
          ),
        );
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await gesture.moveTo(tester.getCenter(find.text('Jun')));
        await expectGolden(tester, 'dual-hovered');
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
    });
  }
}
