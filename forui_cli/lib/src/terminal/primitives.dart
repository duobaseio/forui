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
