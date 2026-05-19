import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/widgets/date_field/input/date_input_controller.dart';
import '../../../test_scaffold.dart';

final _date = DateTime(2024, 12, 25);

const _wideSpaces = {0x00A0: 'NBSP', 0x202F: 'NNBSP', 0x2007: 'FIGURE SPACE'};

// We use a widget to load the locales since Flutter and default intl might have different mappings.
void main() {
  // Validates assumption that a date format pattern never mixes different kinds of wide whitespace.
  testWidgets('date format patterns use at most one wide-space kind', (tester) async {
    await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

    final violations = <String>[];
    for (final locale in FLocalizations.supportedLocales) {
      final name = locale.toString();
      for (final (skeleton, builder) in [
        ('yMd', () => DateFormat.yMd(name)),
        ('yMMMd', () => DateFormat.yMMMd(name)),
        ('yMMMMd', () => DateFormat.yMMMMd(name)),
      ]) {
        final String pattern;
        try {
          pattern = builder().pattern!;
        } on Exception {
          continue;
        }

        final kinds = pattern.codeUnits.where(_wideSpaces.containsKey).toSet();
        if (kinds.length > 1) {
          final mix = kinds.map((c) => _wideSpaces[c]).join(' + ');
          violations.add('$name/$skeleton: "$pattern" mixes $mix');
        }
      }
    }

    expect(violations, isEmpty);
  });

  for (final locale in FLocalizations.supportedLocales.where((locale) => !scriptNumerals.contains(locale.toString()))) {
    testWidgets('split parts - $locale', (tester) async {
      late List<String> parts;
      late String joined;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: locale,
          child: Builder(
            builder: (context) {
              final selector = DateSelector(.of(context)!);

              parts = selector.split(DateFormat.yMd(locale.toString()).format(_date));
              joined = selector.join(parts);

              return const Text('');
            },
          ),
        ),
      );

      expect(parts, unorderedEquals(['2024', '12', '25']));
      expect(joined, DateFormat.yMd(locale.toString()).format(_date));
    });
  }
}
