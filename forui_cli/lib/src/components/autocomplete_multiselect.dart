import 'package:forui_cli/src/components/select.dart';
import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/text.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// Prompts the user to pick several options by typing to filter, navigating the matches with the arrow keys, and
/// toggling each with Tab.
///
/// [options] maps a group header to its options, preserving insertion order; a `''` key renders its options without a
/// header. [initialValues] are selected when the prompt opens. [filter] decides whether an option matches the current
/// query; it defaults to a case-insensitive label substring match. [placeholder] is shown dimmed while the query is
/// empty. At least [min] options must be selected before Enter confirms. Returns the chosen values in their original
/// order, or [Cancelled] on Esc / Ctrl+C.
///
/// Ported from [clack](https://github.com/bombshell-dev/clack). AI-generated; use at your own risk.
Result<List<T>> autocompleteMultiselect<T>({
  required String message,
  required Map<String, List<SelectOption<T>>> options,
  List<T> initialValues = const [],
  String placeholder = '',
  int maxItems = 8,
  int min = 0,
  bool Function(SelectOption<T> option, String query)? filter,
}) {
  final entries = [
    for (final entry in options.entries)
      for (final option in entry.value) (group: entry.key, option: option),
  ];
  if (entries.isEmpty) {
    return Cancelled<List<T>>();
  }
  if (!terminal.interactive) {
    return Value(initialValues.toList());
  }

  final match = filter ?? (o, q) => o.label.toLowerCase().contains(q.toLowerCase());
  // Selection is tracked by index into the stable [entries] list so it survives filtering.
  final selected = <int>{
    for (var i = 0; i < entries.length; i++)
      if (initialValues.contains(entries[i].option.value)) i,
  };
  var query = '';
  var cursor = 0;
  var error = false;
  var filtered = [for (var i = 0; i < entries.length; i++) i];

  void recompute() {
    filtered = query.isEmpty
        ? [for (var i = 0; i < entries.length; i++) i]
        : [
            for (var i = 0; i < entries.length; i++)
              if (match(entries[i].option, query)) i,
          ];
    cursor = 0;
  }

  List<T> chosen() => [
    for (var i = 0; i < entries.length; i++)
      if (selected.contains(i)) entries[i].option.value,
  ];

  final renderer = FrameRenderer(terminal);
  terminal.hideCursor();
  try {
    renderer.render(_frame(message, query, placeholder, entries, filtered, selected, cursor, maxItems, min, error));
    while (true) {
      final key = terminal.readKey();
      switch (key) {
        case Control.tab:
          if (filtered.isNotEmpty) {
            final index = filtered[cursor];
            if (!selected.remove(index)) {
              selected.add(index);
            }
            error = false;
          }
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
          final values = chosen();
          if (values.length < min) {
            error = true;
          } else {
            final labels = [
              for (var i = 0; i < entries.length; i++)
                if (selected.contains(i)) entries[i].option.label,
            ];
            renderer
              ..render(submitFrame(message, labels.isEmpty ? 'none' : labels.join(', ')))
              ..commit();
            return Value(values);
          }
        case Control.escape:
        case Control.ctrlC:
          renderer
            ..render(cancelFrame(message))
            ..commit();
          return Cancelled<List<T>>();
        default:
          continue;
      }
      renderer.render(_frame(message, query, placeholder, entries, filtered, selected, cursor, maxItems, min, error));
    }
  } finally {
    terminal.showCursor();
  }
}

String _frame<T>(
  String message,
  String query,
  String placeholder,
  List<({String group, SelectOption<T> option})> entries,
  List<int> filtered,
  Set<int> selected,
  int cursor,
  int maxItems,
  int min,
  bool error,
) {
  final input = query.isEmpty ? ansi.dim(placeholder) : query;
  final matches = ansi.dim(filtered.length == 1 ? '(1 match)' : '(${filtered.length} matches)');
  final count = ansi.dim('${selected.length} selected');
  final search = gutter(ansi.gray(symbols.bar), 'Search: $input${ansi.cursor} $matches  $count');

  // The visible window of matches, centred on [cursor] when they overflow [maxItems].
  final total = filtered.length;
  final overflow = total > maxItems;
  final start = overflow ? (cursor - maxItems ~/ 2).clamp(0, total - maxItems) : 0;
  final end = overflow ? start + maxItems : total;

  // Interleave a dim header whenever the group changes; starting [shown] at null shows the window's first header even
  // when scrolled into the middle of a group.
  final rows = <String>[];
  final positions = <int?>[]; // each option's window position (for the scrollbar); null for non-option rows
  var optionsWidth = 0;
  String? shown;
  for (var i = start; i < end; i++) {
    final index = filtered[i];
    final entry = entries[index];
    if (entry.group.isNotEmpty && entry.group != shown) {
      rows.add(gutter(ansi.gray(symbols.bar), ansi.dim(entry.group)));
      positions.add(null);
    }
    shown = entry.group;
    rows.add(
      checkboxLine(entry.option.label, entry.option.hint, active: i == cursor, selected: selected.contains(index)),
    );
    positions.add(i - start);
    // Size against the label + hint of every visible option so the divider stays put as the selection moves.
    final w = checkboxWidth(entry.option.label, entry.option.hint);
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
    error
        ? ansi.yellow(min == 1 ? 'Select at least 1 option.' : 'Select at least $min options.')
        : symbols.unicode
        ? 'type ${ansi.dim('filter')} · ↑/↓ ${ansi.dim('navigate')} · tab ${ansi.dim('toggle')} · enter ${ansi.dim('confirm')}'
        : 'type ${ansi.dim('filter')} - up/down ${ansi.dim('navigate')} - tab ${ansi.dim('toggle')} - enter ${ansi.dim('confirm')}',
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
    optionWidths: filtered.map((i) => checkboxWidth(entries[i].option.label, entries[i].option.hint)),
  );

  return [barSpacer(), activeHeader(message), search, ...rows, divider(width), hint].join('\n');
}
