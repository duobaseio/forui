import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/text.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// Opens an interaction sequence with a top corner: `┌  title`.
void intro([String title = '']) {
  terminal
    ..write(gutter(ansi.gray(symbols.barStart), title))
    ..write('\n');
}

/// A plain message under a gutter bar (`│  message`).
void message(String message) => _write(ansi.gray(symbols.bar), message);

/// An informational message (blue `●`).
void info(String message) => _write(ansi.blue(symbols.logInfo), message);

/// A success message (green `◆`).
void success(String message) => _write(ansi.green(symbols.logSuccess), message);

/// A step message (green `◇`).
void step(String message) => _write(ansi.green(symbols.stepSubmit), message);

/// A warning message (yellow `▲`).
void warn(String message) => _write(ansi.yellow(symbols.logWarn), message);

/// An error message (red `■`).
void error(String message) => _write(ansi.red(symbols.logError), message);

void _write(String symbol, String message) {
  final out = <String>[barSpacer()];
  if (message.isNotEmpty) {
    final lines = message.split('\n');
    out.add(gutter(symbol, lines.first));
    for (final line in lines.skip(1)) {
      out.add(gutter(ansi.gray(symbols.bar), line));
    }
  }
  terminal
    ..write(out.join('\n'))
    ..write('\n');
}

/// Renders [message] in a box hanging off the gutter, optionally headed by [title].
///
/// ```text
/// │
/// ◇  Next steps ──────────────╮
/// │                           │
/// │  Run pub get              │
/// │                           │
/// ├───────────────────────────╯
/// ```
void note(String message, {String title = ''}) {
  final lines = ['', ...message.split('\n'), ''];
  final content = [for (final line in lines) displayWidth(line), displayWidth(title)].reduce((a, b) => a > b ? a : b);
  final width = content + 2; // inner width between the gutter padding and the right border

  final out = <String>[barSpacer()];

  final titleWidth = displayWidth(title);
  final dashes = symbols.hLine * (width - titleWidth - 1 < 1 ? 1 : width - titleWidth - 1);
  out.add('${ansi.green(symbols.stepSubmit)}  $title ${ansi.gray('$dashes${symbols.boxTopRight}')}');

  for (final line in lines) {
    final pad = ' ' * (width - displayWidth(line));
    out.add('${ansi.gray(symbols.bar)}  ${ansi.dim(line)}$pad${ansi.gray(symbols.bar)}');
  }

  out.add(ansi.gray('${symbols.connectLeft}${symbols.hLine * (width + 2)}${symbols.boxBottomRight}'));

  terminal
    ..write(out.join('\n'))
    ..write('\n');
}

/// Closes an interaction sequence with a bottom corner under a connecting bar: `│` then `└  message`.
void outro([String message = '']) {
  terminal
    ..write(barSpacer())
    ..write('\n')
    ..write(gutter(ansi.gray(symbols.barEnd), message))
    ..write('\n');
}

/// Closes an interaction sequence after a cancellation: `└  message` with the message in red.
void cancel([String message = 'Cancelled']) {
  terminal
    ..write(gutter(ansi.gray(symbols.barEnd), ansi.red(message)))
    ..write('\n');
}
