import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/header.dart';
import '../../test_scaffold.dart';

void main() {
  Future<void> pump(WidgetTester tester, Widget Function(FCalendarHeaderStyle style) build) async {
    await tester.pumpWidget(
      TestScaffold(
        child: Builder(
          builder: (context) => SizedBox(width: 320, child: build(context.theme.calendarStyle.headerStyle)),
        ),
      ),
    );
  }

  for (final (name, build, label, previous, next)
      in <(String, Header Function(FCalendarHeaderStyle), String, String, String)>[
        (
          'day',
          (style) => Header.day(
            style: style,
            localizations: FDefaultLocalizations(),
            monthYear: DateTime.utc(2024, 6, 15),
            semanticsHint: FDefaultLocalizations().calendarShowMonthPickerSemanticsHint,
            shown: false,
            onPress: () {},
            onNext: () {},
            onPrevious: () {},
          ),
          'June 2024',
          'Previous month',
          'Next month',
        ),
        (
          'month',
          (style) => Header.month(
            style: style,
            localizations: FDefaultLocalizations(),
            year: DateTime.utc(2024),
            semanticsHint: FDefaultLocalizations().calendarShowYearPickerSemanticsHint,
            shown: false,
            onPress: () {},
            onNext: () {},
            onPrevious: () {},
          ),
          '2024',
          'Previous year',
          'Next year',
        ),
        (
          'year',
          (style) => Header.year(
            style: style,
            localizations: FDefaultLocalizations(),
            decade: DateTime.utc(2020),
            semanticsHint: FDefaultLocalizations().calendarShowDaysSemanticsHint,
            shown: false,
            onPress: () {},
            onNext: () {},
            onPrevious: () {},
          ),
          '2020 — 2029',
          'Previous years',
          'Next years',
        ),
      ]) {
    testWidgets('Header.$name renders label and navigation semantics', (tester) async {
      final semantics = tester.ensureSemantics();
      await pump(tester, build);

      expect(find.text(label), findsOneWidget);
      expect(find.bySemanticsLabel(previous), findsOneWidget);
      expect(find.bySemanticsLabel(next), findsOneWidget);
      expect(find.byType(FButton), findsNWidgets(2));

      semantics.dispose();
    });
  }

  testWidgets('Header.singleMonth renders label without navigation', (tester) async {
    await pump(
      tester,
      (style) => Header.singleMonth(
        style: style,
        localizations: FDefaultLocalizations(),
        year: DateTime.utc(2024),
        semanticsHint: FDefaultLocalizations().calendarShowYearPickerSemanticsHint,
        shown: false,
        onPress: () {},
      ),
    );

    expect(find.text('2024'), findsOneWidget);
    expect(find.byType(FButton), findsNothing);
  });

  testWidgets('Header.singleDay renders label without navigation', (tester) async {
    await pump(
      tester,
      (style) => Header.singleDay(
        style: style,
        localizations: FDefaultLocalizations(),
        monthYear: DateTime.utc(2024, 6, 15),
        semanticsHint: FDefaultLocalizations().calendarShowMonthYearPickerSemanticsHint,
        shown: false,
        onPress: () {},
      ),
    );

    expect(find.text('June 2024'), findsOneWidget);
    expect(find.byType(FButton), findsNothing);
  });

  testWidgets('SplitHeader renders labels and navigation semantics', (tester) async {
    final semantics = tester.ensureSemantics();
    await pump(
      tester,
      (style) => SplitHeader(
        style: style,
        localizations: FDefaultLocalizations(),
        date: DateTime.utc(2024, 6, 15),
        previousSemanticsLabel: 'Previous year',
        nextSemanticsLabel: 'Next year',
        month: false,
        year: false,
        onMonth: () {},
        onYear: () {},
        onPrevious: () {},
        onNext: () {},
      ),
    );

    expect(find.text('2024'), findsOneWidget);
    expect(find.bySemanticsLabel('Previous year'), findsOneWidget);
    expect(find.bySemanticsLabel('Next year'), findsOneWidget);
    expect(find.byType(FButton), findsNWidgets(2));

    semantics.dispose();
  });

  testWidgets('SplitHeader.single renders labels without navigation', (tester) async {
    await pump(
      tester,
      (style) => SplitHeader.single(
        style: style,
        localizations: FDefaultLocalizations(),
        date: DateTime.utc(2024, 6, 15),
        month: false,
        year: false,
        onMonth: () {},
        onYear: () {},
      ),
    );

    expect(find.text('2024'), findsOneWidget);
    expect(find.byType(FButton), findsNothing);
  });

  group('accessibility', () {
    for (final shown in [true, false]) {
      testWidgets('Header.day toggle exposes expanded state and hint - $shown', (tester) async {
        final semantics = tester.ensureSemantics();
        await pump(
          tester,
          (style) => Header.day(
            style: style,
            localizations: FDefaultLocalizations(),
            monthYear: DateTime.utc(2024, 6, 15),
            semanticsHint: FDefaultLocalizations().calendarShowMonthPickerSemanticsHint,
            shown: shown,
            onPress: () {},
            onNext: () {},
            onPrevious: () {},
          ),
        );

        expect(
          tester.getSemantics(find.text('June 2024')),
          isSemantics(hasExpandedState: true, isExpanded: shown, hint: 'Show month picker'),
        );

        semantics.dispose();
      });
    }

    testWidgets('SplitHeader toggles expose distinct month and year hints', (tester) async {
      final semantics = tester.ensureSemantics();
      await pump(
        tester,
        (style) => SplitHeader(
          style: style,
          localizations: FDefaultLocalizations(),
          date: DateTime.utc(2024, 6, 15),
          previousSemanticsLabel: 'Previous year',
          nextSemanticsLabel: 'Next year',
          month: false,
          year: false,
          onMonth: () {},
          onYear: () {},
          onPrevious: () {},
          onNext: () {},
        ),
      );

      expect(tester.getSemantics(find.text('June')), isSemantics(hint: 'Show month picker'));
      expect(tester.getSemantics(find.text('2024')), isSemantics(hint: 'Show year picker'));

      semantics.dispose();
    });
  });
}
