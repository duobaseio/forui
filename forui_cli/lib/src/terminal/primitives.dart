import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/text.dart';
import 'package:forui_cli/src/terminal/theme.dart';

// Ported from clack/prompts TypeScript package.

sealed class Result<T> {}

final class Value<T> implements Result<T> {
  final T value;

  const Value(this.value);
}

final class Cancelled<T> implements Result<T> {
  const Cancelled();
}

/// The active step header: a cyan diamond followed by [message].
String activeHeader(String message) => gutter(ansi.cyan(symbols.stepActive), message);

/// Builds one gutter line: a (pre-coloured) [symbol], two spaces, then [content].
String gutter(String symbol, String content) => '$symbol  $content';

String divider(int width) => ansi.gray('${symbols.connectLeft}${symbols.hLine * (width - 1)}');

/// The gray vertical bar that connects interactions, used as a spacer line.
String barSpacer() => ansi.gray(symbols.bar);

/// The collapsed frame shown after a prompt is submitted: a green diamond, the [message], and the [value] dimmed under
/// a continuing gutter bar.
String submitFrame(String message, String value) => [
  barSpacer(),
  gutter(ansi.green(symbols.stepSubmit), message),
  gutter(ansi.gray(symbols.bar), ansi.dim(value)),
].join('\n');

/// The collapsed frame shown after a prompt is cancelled: a red square and the [message].
String cancelFrame(String message) => [barSpacer(), gutter(ansi.red(symbols.stepCancel), message)].join('\n');

/// Renders one option row (radio + optional colour swatch + label + optional hint) for `select` and `autocomplete`.
///
/// [swatch] is an ARGB colour (`0xAARRGGBB`) drawn as a coloured block before the label; only shown when truecolor is
/// enabled.
String optionLine(String label, String? hint, {required bool active, int? swatch}) {
  final radio = active ? ansi.green(symbols.radioActive) : ansi.dim(symbols.radioInactive);
  // A standalone coloured block; kept out of the label so its reset can't clear the label's colour.
  final block = (swatch != null && truecolor.enabled) ? '${truecolor.foreground(swatch, symbols.swatch)} ' : '';
  final text = active ? ansi.cyan(label) : ansi.dim(label);
  final h = (hint != null && active) ? ' ${ansi.dim(hint)}' : '';
  return gutter(ansi.gray(symbols.bar), '$radio $block$text$h');
}

/// The display width of [optionLine] with its [hint] always shown (i.e. as if active). Used to size the divider against
/// the widest label-plus-hint so it doesn't shift as the active option changes.
int optionWidth(String label, String? hint) => displayWidth(ansi.strip(optionLine(label, hint, active: true)));

/// Renders one option row (checkbox + label + optional hint) for `autocompleteMultiselect`.
///
/// [active] is the highlighted (cursor) row; [selected] is whether the option is currently chosen. The checkbox is cyan
/// while active, green when selected but inactive, and dim otherwise.
String checkboxLine(String label, String? hint, {required bool active, required bool selected}) {
  final box = active
      ? ansi.cyan(selected ? symbols.checkboxSelected : symbols.checkboxActive)
      : selected
      ? ansi.green(symbols.checkboxSelected)
      : ansi.dim(symbols.checkboxInactive);
  final text = active ? ansi.cyan(label) : ansi.dim(label);
  final h = (hint != null && active) ? ' ${ansi.dim(hint)}' : '';
  return gutter(ansi.gray(symbols.bar), '$box $text$h');
}

/// The display width of [checkboxLine] as if active, selected, and with its [hint] shown. Used to size the divider
/// against the widest row so it doesn't shift as the active option changes.
int checkboxWidth(String label, String? hint) =>
    displayWidth(ansi.strip(checkboxLine(label, hint, active: true, selected: true)));

/// Appends a vertical scrollbar to the right edge of [rows] and returns the frame width to pass to [divider].
///
/// [positions] holds each row's option index within the visible window (`null` for non-option rows such as group
/// headers, which get no glyph). The thumb is sized to the visible fraction ([maxItems] of [total]) and positioned by
/// the window [start]. [content] is the frame width without a scrollbar; [optionWidths] are the widths of every match
/// (visible or not), used to anchor the bar so it and the divider don't shift while scrolling. When the list fits
/// ([total] `<=` [maxItems]) this is a no-op that returns [content] unchanged.
int scrollbar(
  List<String> rows,
  List<int?> positions, {
  required int start,
  required int total,
  required int maxItems,
  required int content,
  required Iterable<int> optionWidths,
}) {
  if (total <= maxItems) {
    return content;
  }

  // Anchor to the widest match (even off-screen ones) so the column stays put as the window scrolls.
  var anchor = content;
  for (final w in optionWidths) {
    if (w > anchor) {
      anchor = w;
    }
  }
  final width = anchor + 2;

  final thumb = (maxItems * maxItems / total).round().clamp(1, maxItems);
  final span = maxItems - thumb;
  final at = span == 0 ? 0 : (start / (total - maxItems) * span).round().clamp(0, span);
  for (var r = 0; r < rows.length; r++) {
    final p = positions[r];
    if (p == null) {
      continue;
    }
    final glyph = ansi.gray(p >= at && p < at + thumb ? symbols.scrollThumb : symbols.scrollTrack);
    final pad = width - 1 - displayWidth(ansi.strip(rows[r]));
    rows[r] = '${rows[r]}${' ' * (pad < 0 ? 0 : pad)}$glyph';
  }

  return width;
}

/// Draws a multi-line frame in place, erasing the previously drawn frame on each [render] so a prompt updates without
/// scrolling the terminal.
class FrameRenderer {
  final Terminal _terminal;
  int _physicalLines = 0;

  FrameRenderer(this._terminal);

  /// Erases the previous frame and draws [frame] (lines joined by `\n`, no trailing newline).
  void render(String frame) {
    _erasePrevious();
    _terminal.write(frame);
    _physicalLines = _countPhysical(frame);
  }

  void _erasePrevious() {
    if (_physicalLines == 0) {
      return;
    }
    final up = _physicalLines - 1;
    final buffer = StringBuffer('\r');
    if (up > 0) {
      buffer.write('\x1B[${up}A');
    }
    buffer.write('\x1B[0J'); // erase from cursor to end of screen
    _terminal.write(buffer.toString());
  }

  int _countPhysical(String frame) {
    final columns = _terminal.columns;
    var count = 0;
    for (final line in frame.split('\n')) {
      final width = displayWidth(ansi.strip(line));
      count += width == 0 ? 1 : ((width - 1) ~/ columns) + 1;
    }
    return count;
  }

  /// Finalises the current frame, leaving the cursor on the line below it so the next interaction continues the gutter.
  void commit() {
    _terminal.write('\n');
    _physicalLines = 0;
  }
}
