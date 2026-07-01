import 'package:forui_cli/src/components/select.dart';
import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/text.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// Prompts the user to pick one option by typing to filter, then navigating the matches with the arrow keys.
///
/// [options] maps a group header to its options, preserving insertion order; a `''` key renders its options without a
/// header. [initial] selects the initially highlighted option. [filter] decides whether an option matches the current
/// query; it defaults to a case-insensitive label substring match. [placeholder] is shown dimmed while the query is
/// empty. Returns [Cancelled] on Esc / Ctrl+C.
///
/// Ported from [clack](https://github.com/bombshell-dev/clack). AI-generated; use at your own risk.
Result<T> autocomplete<T>({
  required String message,
  required Map<String, List<SelectOption<T>>> options,
  T? initial,
  String placeholder = '',
  int maxItems = 8,
  bool Function(SelectOption<T> option, String query)? filter,
}) {
  final entries = [
    for (final entry in options.entries)
      for (final option in entry.value) (group: entry.key, option: option),
  ];
  if (entries.isEmpty) {
    return Cancelled<T>();
  }

  var cursor = initial == null ? 0 : entries.indexWhere((e) => e.option.value == initial);
  if (cursor < 0) {
    cursor = 0;
  }

  if (!terminal.interactive) {
    return Value(entries[cursor].option.value);
  }

  final match = filter ?? (o, q) => o.label.toLowerCase().contains(q.toLowerCase());
  var query = '';
  var filtered = List<({String group, SelectOption<T> option})>.of(entries);

  void recompute() {
    filtered = query.isEmpty ? List.of(entries) : entries.where((e) => match(e.option, query)).toList();
    cursor = 0;
  }

  final renderer = FrameRenderer(terminal);
  terminal.hideCursor();
  try {
    renderer.render(_frame(message, query, placeholder, filtered, cursor, maxItems));
    while (true) {
      final key = terminal.readKey();
      switch (key) {
        case Character(:final character):
          query += character;
          recompute();
        case Control.backspace:
          if (query.isNotEmpty) {
            query = query.substring(0, query.length - 1);
            recompute();
          }
        case Control.up:
          if (filtered.isNotEmpty) {
            cursor = (cursor - 1 + filtered.length) % filtered.length;
          }
        case Control.down:
          if (filtered.isNotEmpty) {
            cursor = (cursor + 1) % filtered.length;
          }
        case Control.enter:
          if (filtered.isEmpty) {
            continue;
          }
          renderer.render(submitFrame(message, filtered[cursor].option.label));
          renderer.commit();
          return Value(filtered[cursor].option.value);
        case Control.escape:
        case Control.ctrlC:
          renderer.render(cancelFrame(message));
          renderer.commit();
          return Cancelled<T>();
        default:
          continue;
      }
      renderer.render(_frame(message, query, placeholder, filtered, cursor, maxItems));
    }
  } finally {
    terminal.showCursor();
  }
}

String _frame<T>(
  String message,
  String query,
  String placeholder,
  List<({String group, SelectOption<T> option})> filtered,
  int cursor,
  int maxItems,
) {
  final input = query.isEmpty ? ansi.dim(placeholder) : query;
  final count = ansi.dim(filtered.length == 1 ? '(1 match)' : '(${filtered.length} matches)');
  final search = gutter(ansi.gray(symbols.bar), 'Search: $input${ansi.cursor} $count');

  // The visible window of matches, centred on [cursor] when they overflow [maxItems].
  final total = filtered.length;
  final start = total <= maxItems ? 0 : (cursor - maxItems ~/ 2).clamp(0, total - maxItems);
  final end = total <= maxItems ? total : start + maxItems;

  // Interleave a dim header whenever the group changes; starting [shown] at null shows the window's first header even
  // when scrolled into the middle of a group.
  final rows = <String>[];
  final positions = <int?>[]; // each option's window position (for the scrollbar); null for non-option rows
  var optionsWidth = 0;
  String? shown;
  for (var i = start; i < end; i++) {
    final entry = filtered[i];
    if (entry.group.isNotEmpty && entry.group != shown) {
      rows.add(gutter(ansi.gray(symbols.bar), ansi.dim(entry.group)));
      positions.add(null);
    }
    shown = entry.group;
    rows.add(optionLine(entry.option.label, entry.option.hint, active: i == cursor));
    positions.add(i - start);
    // Size against the label + hint of every visible option so the divider stays put as the selection moves.
    final w = optionWidth(entry.option.label, entry.option.hint);
    if (w > optionsWidth) {
      optionsWidth = w;
    }
  }
  if (rows.isEmpty) {
    rows.add(gutter(ansi.gray(symbols.bar), ansi.dim('No matches')));
    positions.add(null);
  }

  final hint = gutter(
    ansi.gray(symbols.bar),
    symbols.unicode
        ? 'type ${ansi.dim('filter')} · ↑/↓ ${ansi.dim('navigate')} · enter ${ansi.dim('select')}'
        : 'type ${ansi.dim('filter')} - up/down ${ansi.dim('navigate')} - enter ${ansi.dim('select')}',
  );
  final content = [
    search,
    ...rows,
    hint,
  ].map((line) => displayWidth(ansi.strip(line))).fold(optionsWidth, (a, b) => a > b ? a : b);
  final width = scrollbar(
    rows,
    positions,
    start: start,
    total: total,
    maxItems: maxItems,
    content: content,
    optionWidths: filtered.map((e) => optionWidth(e.option.label, e.option.hint)),
  );

  return [barSpacer(), activeHeader(message), search, ...rows, divider(width), hint].join('\n');
}
