import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/text.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// Prompts the user to pick one of [options] using arrow-key navigation; a flat, ungrouped [groupedSelect].
///
/// See [groupedSelect] for [initial], [maxItems], and the return value.
///
/// Ported from [clack](https://github.com/bombshell-dev/clack). AI-generated; use at your own risk.
Result<T> select<T>({
  required String message,
  required List<SelectOption<T>> options,
  T? initial,
  int maxItems = 8,
}) => groupedSelect(message: message, options: {'': options}, initial: initial, maxItems: maxItems);

/// Prompts the user to pick one option from grouped [options], using arrow-key navigation.
///
/// [options] maps a group header to its options, preserving insertion order; a `''` key renders its options without a
/// header. Use [select] for a flat, ungrouped list. [initial] selects the initially highlighted option. When more
/// than [maxItems] options are visible, a scrolling window keeps the selection visible. Returns [Cancelled] on Esc /
/// Ctrl+C, or when not interactive and no [initial] matches.
Result<T> groupedSelect<T>({
  required String message,
  required Map<String, List<SelectOption<T>>> options,
  T? initial,
  int maxItems = 8,
}) {
  final entries = [
    for (final entry in options.entries)
      for (final option in entry.value) (group: entry.key, option: option),
  ];
  if (entries.isEmpty) {
    return Cancelled<T>();
  }

  var selected = initial == null ? 0 : entries.indexWhere((e) => e.option.value == initial);
  if (selected < 0) {
    selected = 0;
  }

  if (!terminal.interactive) {
    return Value(entries[selected].option.value);
  }

  final renderer = FrameRenderer(terminal);
  terminal.hideCursor();
  try {
    renderer.render(_frame(message, entries, selected, maxItems));
    while (true) {
      final key = terminal.readKey();
      switch (key) {
        case Control.up:
          selected = (selected - 1 + entries.length) % entries.length;
        case Control.down:
          selected = (selected + 1) % entries.length;
        case Control.enter:
          renderer.render(submitFrame(message, entries[selected].option.label));
          renderer.commit();
          return Value(entries[selected].option.value);
        case Control.escape:
        case Control.ctrlC:
          renderer.render(cancelFrame(message));
          renderer.commit();
          return Cancelled<T>();
        default:
          continue;
      }
      renderer.render(_frame(message, entries, selected, maxItems));
    }
  } finally {
    terminal.showCursor();
  }
}

String _frame<T>(String message, List<({String group, SelectOption<T> option})> entries, int selected, int maxItems) {
  // The visible window of options, centred on [selected] when they overflow [maxItems].
  final total = entries.length;
  final start = total <= maxItems ? 0 : (selected - maxItems ~/ 2).clamp(0, total - maxItems);
  final end = total <= maxItems ? total : start + maxItems;

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
    rows.add(optionLine(entry.option.label, entry.option.hint, active: i == selected, swatch: entry.option.swatch));
    positions.add(i - start);
    // Size against the label + hint of every visible option so the divider stays put as the selection moves.
    final w = optionWidth(entry.option.label, entry.option.hint);
    if (w > optionsWidth) {
      optionsWidth = w;
    }
  }

  final hint = gutter(
    ansi.gray(symbols.bar),
    symbols.unicode
        ? '↑/↓ ${ansi.dim('navigate')} · enter ${ansi.dim('select')}'
        : 'up/down ${ansi.dim('navigate')} - enter ${ansi.dim('select')}',
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
    optionWidths: entries.map((e) => optionWidth(e.option.label, e.option.hint)),
  );

  return [barSpacer(), activeHeader(message), ...rows, divider(width), hint].join('\n');
}

/// A single selectable option, used by `select` and `autocomplete`.
final class SelectOption<T> {
  /// The value returned when this option is chosen.
  final T value;

  /// The text shown for this option. Defaults to `'$value'`.
  final String label;

  /// An optional dim hint shown after the label while the option is active.
  final String? hint;

  /// An optional ARGB colour (`0xAARRGGBB`) shown as a swatch before the label. Only renders when truecolor is enabled.
  final int? swatch;

  SelectOption(this.value, {String? label, this.hint, this.swatch}) : label = label ?? '$value';
}
