import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/header.dart';
import '../../test_scaffold.dart';

void main() {
  Future<void> pump(WidgetTester tester, Header Function(FCalendarHeaderStyle style) build) async {
    await tester.pumpWidget(
      TestScaffold(
        child: Builder(
          builder: (context) {
            final theme = context.theme;
            final style = FCalendarHeaderStyle.inherit(
              colors: theme.colors,
              typography: theme.typography,
              icons: theme.icons,
              style: theme.style,
              touch: context.platformVariant.touch,
            );
            return SizedBox(width: 320, child: build(style));
          },
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
            shown: false,
            onPress: () {},
            onNext: () {},
            onPrevious: () {},
          ),
          'Jun 2024',
          'Previous month',
          'Next month',
        ),
        (
          'month',
          (style) => Header.month(
            style: style,
            localizations: FDefaultLocalizations(),
            year: DateTime.utc(2024),
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

      semantics.dispose();
    });
  }
}
