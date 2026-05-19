// This script is mostly vib-coded. Use at your own risk.
//
// Regenerates the date- and time-field separator/suffix keys in every
// `lib/l10n/f_*.arb` from Flutter's CLDR overlay:
//
//   shortDateSeparator       shortDateSuffix
//   timeFieldTimeSeparator   timeFieldPeriodSeparator   timeFieldSuffix
//
// Run from `forui/forui`:
//
//   dart run tool/i10n/date_time.dart
//
// Then run `flutter gen-l10n` (or `make l10n`) to refresh the generated
// localization classes. Re-run this script whenever Flutter is upgraded so
// the snapshot stays in sync with Flutter's bundled CLDR data.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_localizations/src/utils/date_localizations.dart' as flutter_l10n;
import 'package:intl/intl.dart';

// Locales whose date formatting uses non-Western digit scripts. The runtime
// selectors do not split these locales, so we leave their ARB values alone.
const _scriptNumerals = {'ar', 'as', 'bn', 'fa', 'mr', 'my', 'ne', 'ps', 'ta'};

final _arbName = RegExp(r'f_([\w_]+)\.arb$');
// LRM (U+200E), RLM (U+200F), ALM (U+061C). intl injects these around digit
// runs in bidi locales; strip them before splitting.
final _bidiMarks = RegExp('[‎‏؜]');
final _digits = RegExp(r'\d+');

final _warnings = <String>[];

void main() {
  // Mirrors what MaterialApp does on first locale load. Without this,
  // `DateFormat.*(locale)` falls back to intl's bundled CLDR data instead of
  // Flutter's overlay, producing values that drift from runtime.
  flutter_l10n.loadDateIntlDataIfNotLoaded();

  final files = Directory('lib/l10n').listSync().whereType<File>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  for (final file in files) {
    final locale = _arbName.firstMatch(file.path)?.group(1);
    if (locale == null) {
      // f_en.arb is the canonical source ARB with @key metadata; hand-maintained.
      continue;
    }
    if (_scriptNumerals.contains(locale.split('_').first)) {
      continue;
    }

    final arb = json.decode(file.readAsStringSync()) as Map<String, dynamic>;
    _shortDate(locale, arb);
    _time(locale, arb);
    file.writeAsStringSync('${const JsonEncoder.withIndent('  ').convert(arb)}\n');
  }

  if (_warnings.isNotEmpty) {
    stderr.writeln('Warnings:');
    for (final w in _warnings) {
      stderr.writeln('  $w');
    }
    exitCode = 1;
  }
}

void _shortDate(String locale, Map<String, dynamic> arb) {
  // Day/month/year all distinct so splitting on \d+ yields 3 digit runs.
  final probe = DateTime(2024, 12, 25);
  final String formatted;
  try {
    formatted = DateFormat.yMd(locale).format(probe).replaceAll(_bidiMarks, '');
  } on Exception catch (e) {
    _warnings.add('$locale shortDate: DateFormat.yMd failed ($e)');
    return;
  }

  // Expected shape: <prefix><digits><sep1><digits><sep2><digits><suffix>.
  final parts = formatted.split(_digits);
  if (parts.length != 4 || parts.first.isNotEmpty) {
    _warnings.add('$locale shortDate: unexpected yMd shape "$formatted"');
    return;
  }
  if (parts[1] != parts[2]) {
    _warnings.add('$locale shortDate: asymmetric separators in "$formatted" '
        '("${parts[1]}" vs "${parts[2]}") - using first');
  }

  arb['shortDateSeparator'] = parts[1];
  arb['shortDateSuffix'] = parts[3];
}

void _time(String locale, Map<String, dynamic> arb) {
  // 14:30 gives distinct hour/minute digits in both 12h ("2:30") and 24h ("14:30").
  final probe = DateTime(1970, 1, 1, 14, 30);
  final String pattern;
  final String formatted;
  try {
    final fmt = DateFormat.jm(locale);
    pattern = fmt.pattern!;
    formatted = fmt.format(probe).replaceAll(_bidiMarks, '');
  } on Exception catch (e) {
    _warnings.add('$locale timeField: DateFormat.jm failed ($e)');
    return;
  }

  // Mirror Forui's runtime dispatch in `TimeInputController` factory.
  final is12h = pattern.contains('a');

  if (!is12h) {
    // Expected shape: <H><timeSep><M><suffix>.
    final parts = formatted.split(_digits);
    if (parts.length != 3 || parts.first.isNotEmpty) {
      _warnings.add('$locale timeField (24h): unexpected shape "$formatted"');
      return;
    }
    arb['timeFieldTimeSeparator'] = parts[1];
    arb['timeFieldPeriodSeparator'] = '';
    arb['timeFieldSuffix'] = parts[2];
    return;
  }

  final period = DateFormat('a', locale).format(probe);
  if (period.isEmpty) {
    _warnings.add('$locale timeField (12h): empty period text');
    return;
  }

  if (formatted.startsWith(period)) {
    // Shape: <period><periodSep><H><timeSep><M><suffix>. (zh_HK / zh_TW)
    final rest = formatted.substring(period.length);
    final parts = rest.split(_digits);
    if (parts.length != 3) {
      _warnings.add('$locale timeField (12h leading-period): unexpected shape "$formatted"');
      return;
    }
    arb['timeFieldPeriodSeparator'] = parts[0];
    arb['timeFieldTimeSeparator'] = parts[1];
    arb['timeFieldSuffix'] = parts[2];
    return;
  }

  // Shape: <H><timeSep><M><periodSep><period><suffix>.
  final i = formatted.indexOf(period);
  if (i < 0) {
    _warnings.add('$locale timeField (12h): period "$period" not found in "$formatted"');
    return;
  }
  final pre = formatted.substring(0, i);
  final post = formatted.substring(i + period.length);
  final preParts = pre.split(_digits);
  if (preParts.length != 3 || preParts.first.isNotEmpty) {
    _warnings.add('$locale timeField (12h trailing-period): unexpected pre "$pre"');
    return;
  }
  arb['timeFieldTimeSeparator'] = preParts[1];
  arb['timeFieldPeriodSeparator'] = preParts[2];
  arb['timeFieldSuffix'] = post;
}
