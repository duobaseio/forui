import 'package:forui_cli/src/components/select.dart';
import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/text.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// Prompts the user to pick several options with arrow-key navigation, toggling each with Tab; a flat, ungrouped
/// [groupedMultiselect].
///
/// See [groupedMultiselect] for [initialValues], [maxItems], [min], and the return value.
///
/// Ported from [clack](https://github.com/bombshell-dev/clack). AI-generated; use at your own risk.
Result<List<T>> multiselect<T>({
  required String message,
  required List<SelectOption<T>> options,
  List<T> initialValues = const [],
  int maxItems = 8,
  int min = 0,
}) => groupedMultiselect(
  message: message,
  options: {'': options},
  initialValues: initialValues,
  maxItems: maxItems,
  min: min,
);

/// Prompts the user to pick several options from grouped [options], navigating with the arrow keys and toggling each
/// with Tab. The non-filtering counterpart of `autocompleteMultiselect`.
///
/// [options] maps a group header to its options, preserving insertion order; a `''` key renders its options without a
/// header. [initialValues] are selected when the prompt opens. When more than [maxItems] options are visible, a
/// scrolling window keeps the cursor visible. At least [min] options must be selected before Enter confirms. Returns the
/// chosen values in their original order, or [Cancelled] on Esc / Ctrl+C.
Result<List<T>> groupedMultiselect<T>({
  required String message,
  required Map<String, List<SelectOption<T>>> options,
  List<T> initialValues = const [],
  int maxItems = 8,
  int min = 0,
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

  // Selection is tracked by index into [entries].
  final selected = <int>{
    for (var i = 0; i < entries.length; i++)
      if (initialValues.contains(entries[i].option.value)) i,
  };
  var cursor = 0;
  var error = false;

  List<T> chosen() => [
    for (var i = 0; i < entries.length; i++)
      if (selected.contains(i)) entries[i].option.value,
  ];

  final renderer = FrameRenderer(terminal);
  terminal.hideCursor();
  try {
    renderer.render(_frame(message, entries, selected, cursor, maxItems, min, error));
    while (true) {
      switch (terminal.readKey()) {
        case Control.tab:
          if (!selected.remove(cursor)) {
            selected.add(cursor);
          }
          error = false;
        case Control.up:
          cursor = (cursor - 1 + entries.length) % entries.length;
        case Control.down:
          cursor = (cursor + 1) % entries.length;
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
      renderer.render(_frame(message, entries, selected, cursor, maxItems, min, error));
    }
  } finally {
    terminal.showCursor();
  }
}

String _frame<T>(
  String message,
  List<({String group, SelectOption<T> option})> entries,
  Set<int> selected,
  int cursor,
  int maxItems,
  int min,
  bool error,
) {
  // The visible window of options, centred on [cursor] when they overflow [maxItems].
  final total = entries.length;
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
    final entry = entries[i];
    if (entry.group.isNotEmpty && entry.group != shown) {
      rows.add(gutter(ansi.gray(symbols.bar), ansi.dim(entry.group)));
      positions.add(null);
    }
    shown = entry.group;
    rows.add(checkboxLine(entry.option.label, entry.option.hint, active: i == cursor, selected: selected.contains(i)));
    positions.add(i - start);
    // Size against the label + hint of every visible option so the divider stays put as the selection moves.
    final w = checkboxWidth(entry.option.label, entry.option.hint);
    if (w > optionsWidth) {
      optionsWidth = w;
    }
  }

  final hint = gutter(
    ansi.gray(symbols.bar),
    error
        ? ansi.yellow(min == 1 ? 'Select at least 1 option.' : 'Select at least $min options.')
        : symbols.unicode
        ? '↑/↓ ${ansi.dim('navigate')} · tab ${ansi.dim('toggle')} · enter ${ansi.dim('confirm')}'
        : 'up/down ${ansi.dim('navigate')} - tab ${ansi.dim('toggle')} - enter ${ansi.dim('confirm')}',
  );
  final content = [
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
    optionWidths: entries.map((e) => checkboxWidth(e.option.label, e.option.hint)),
  );

  return [barSpacer(), activeHeader(message), ...rows, divider(width), hint].join('\n');
}
