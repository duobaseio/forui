import 'dart:async';

import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// Creates a [Spinner]. Call [Spinner.start], do async work, then [Spinner.stop].
Spinner spinner() => Spinner._();

/// An animated single-line progress indicator that hangs off the gutter.
///
/// The frame animates via a [Timer] while the caller awaits work, so it only spins between `await` points. Do not write
/// to stdout (e.g. `print`) while it is running.
class Spinner {
  Timer? _timer;
  int _tick = 0;
  String _message = '';
  bool _active = false;

  Spinner._();

  /// Starts spinning with [message].
  void start([String message = '']) {
    _message = message;
    _active = true;
    if (!terminal.interactive) {
      return;
    }
    terminal
      ..hideCursor()
      ..trapCursor()
      ..write(barSpacer())
      ..write('\n');
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

  /// Updates the spinner's message in place.
  // ignore: use_setters_to_change_properties
  void message(String text) => _message = text;

  /// Stops the spinner, replacing the frame with a final symbol determined by [code] (0 = success, 1 = cancel,
  /// anything else = error) and [message] (defaults to the last message).
  void stop([String message = '', int code = 0]) {
    if (!_active) {
      return;
    }
    _active = false;
    _timer?.cancel();
    _timer = null;

    final text = message.isEmpty ? _message : message;
    final symbol = switch (code) {
      0 => ansi.green(symbols.stepSubmit),
      1 => ansi.red(symbols.stepCancel),
      _ => ansi.yellow(symbols.stepError),
    };

    if (terminal.interactive) {
      terminal
        ..write('\r\x1B[2K') // return to column 0 and clear the spinner line
        ..write(gutter(symbol, text))
        ..write('\n')
        ..releaseCursor()
        ..showCursor();
    } else {
      terminal
        ..write(barSpacer())
        ..write('\n')
        ..write(gutter(symbol, text))
        ..write('\n');
    }
  }

  /// Stops the spinner in an error state.
  void error([String message = '']) => stop(message, 2);
}
