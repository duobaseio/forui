import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// Prompts the user for a yes/no answer.
///
/// [initial] is the initially highlighted choice. Arrow keys / Tab toggle; `y`/`n` answer immediately; Enter
/// confirms the current choice. Returns [Cancelled] on Esc / Ctrl+C.
///
/// Ported from [clack](https://github.com/bombshell-dev/clack). AI-generated; use at your own risk.
bool confirm({required String message, bool initial = true, String active = 'Yes', String inactive = 'No'}) {
  if (!terminal.interactive) {
    return initial;
  }

  var value = initial;

  bool submit(FrameRenderer renderer) {
    renderer
      ..render(submitFrame(message, value ? active : inactive))
      ..commit();
    return value;
  }

  final renderer = FrameRenderer(terminal);
  terminal.hideCursor();
  try {
    renderer.render(_frame(message, value, active, inactive));
    while (true) {
      switch (terminal.readKey()) {
        case Control.left:
        case Control.right:
        case Control.up:
        case Control.down:
        case Control.tab:
          value = !value;
        case Character(:final character):
          final c = character.toLowerCase();
          if (c == 'y') {
            value = true;
            return submit(renderer);
          }
          if (c == 'n') {
            value = false;
            return submit(renderer);
          }
          continue;
        case Control.enter:
          return submit(renderer);
        case Control.escape:
        case Control.ctrlC:
          renderer
            ..render(cancelFrame(message))
            ..commit();
          return false;
        default:
          continue;
      }
      renderer.render(_frame(message, value, active, inactive));
    }
  } finally {
    terminal.showCursor();
  }
}

String _frame(String message, bool value, String active, String inactive) {
  String choice(String label, {required bool on}) {
    final radio = on ? ansi.green(symbols.radioActive) : ansi.dim(symbols.radioInactive);
    final text = on ? ansi.cyan(label) : ansi.dim(label);
    return '$radio $text';
  }

  return [
    barSpacer(),
    activeHeader(message),
    gutter(ansi.gray(symbols.bar), '${choice(active, on: value)} / ${choice(inactive, on: !value)}'),
  ].join('\n');
}
