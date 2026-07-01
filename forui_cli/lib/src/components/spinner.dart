import 'dart:async';

import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// A single-line progress indicator that hangs off the gutter.
///
/// Ported from [clack](https://github.com/bombshell-dev/clack). AI-generated; use at your own risk.
abstract class Spinner {
  factory Spinner() => terminal.interactive ? _InteractiveSpinner() : _NonInteractiveSpinner();

  /// Starts the spinner with [message].
  void start([String message = '']);

  /// Updates the message in place.
  void message(String text);

  /// Stops the spinner with a final symbol determined by [code] (0 = success, 1 = cancel, anything else = error) and
  /// [message] (defaults to the last message), optionally followed by a dim [hint] line suggesting how to resolve it.
  void stop([String message = '', int code = 0, String? hint]);

  /// Stops the spinner in an error state, optionally followed by a dim [hint] line suggesting how to resolve it.
  void error([String message = '', String? hint]);
}

/// An animated spinner. The frame animates via a [Timer] while the caller awaits work, so it only spins between `await`
/// points. Do not write to stdout (e.g. `print`) while it is running.
class _InteractiveSpinner implements Spinner {
  Timer? _timer;
  int _tick = 0;
  String _message = '';
  bool _active = false;

  @override
  void start([String message = '']) {
    _message = message;
    _active = true;
    terminal
      ..hideCursor()
      ..trapCursor()
      ..writeln(barSpacer());
    _render();
    _timer = Timer.periodic(symbols.spinnerInterval, (_) {
      _tick++;
      _render();
    });
  }

  void _render() {
    final frame = symbols.spinnerFrames[_tick % symbols.spinnerFrames.length];
    final dots = '.' * ((_tick ~/ 8) % 4);
    terminal
      ..write('\r\x1B[2K')
      ..write(gutter(ansi.magenta(frame), '$_message$dots'));
  }

  @override
  void message(String text) => _message = text;

  @override
  void stop([String message = '', int code = 0, String? hint]) {
    if (!_active) {
      return;
    }
    _active = false;
    _timer?.cancel();
    _timer = null;

    final symbol = switch (code) {
      0 => ansi.green(symbols.stepSubmit),
      1 => ansi.red(symbols.stepCancel),
      _ => ansi.red(symbols.stepError),
    };
    terminal
      ..write('\r\x1B[2K') // return to column 0 and clear the spinner line
      ..writeln(gutter(symbol, message.isEmpty ? _message : message));
    if (hint != null) {
      for (final line in hint.split('\n')) {
        terminal.writeln(gutter(ansi.gray(symbols.bar), ansi.dim(line)));
      }
    }
    terminal
      ..releaseCursor()
      ..showCursor();
  }

  @override
  void error([String message = '', String? hint]) => stop(message, 2, hint);
}

/// A spinner for non-interactive terminals: [start] and [message] announce as plain lines, a successful [stop] is
/// silent (the work was already announced), and a non-zero [stop] / [error] writes to stderr.
class _NonInteractiveSpinner implements Spinner {
  String _message = '';

  @override
  void start([String message = '']) {
    _message = message;
    if (message.isNotEmpty) {
      terminal.writeln(message);
    }
  }

  @override
  void message(String text) {
    _message = text;
    if (text.isNotEmpty) {
      terminal.writeln(text);
    }
  }

  @override
  void stop([String message = '', int code = 0, String? hint]) {
    if (code != 0) {
      terminal.writeErrorln(message.isEmpty ? _message : message);
      if (hint != null) {
        terminal.writeErrorln(hint);
      }
    }
  }

  @override
  void error([String message = '', String? hint]) => stop(message, 2, hint);
}
