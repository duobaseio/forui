import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// A block that streams task output under a header, then collapses on success (clearing the output) or retains it on
/// error.
///
/// Ported from [clack](https://github.com/bombshell-dev/clack). AI-generated; use at your own risk.
class TaskLog {
  final String _title;
  final int _limit;
  final List<String> _lines = [];
  final FrameRenderer _renderer = FrameRenderer(terminal);
  final bool _interactive = terminal.interactive;
  var _started = false;

  TaskLog({required this._title, this._limit = 0});

  /// Appends an output [line] (which may itself contain newlines) and re-renders.
  void message(String line) {
    _lines.addAll(line.split('\n'));
    if (!_interactive) {
      terminal.writeln(gutter(ansi.gray(symbols.bar), ansi.dim(line)));
      return;
    }

    _active();
  }

  /// Collapses the block to a success header, discarding the streamed output.
  void success({String message = '', bool keep = false}) =>
      _finish(ansi.green(symbols.stepSubmit), message, keep: keep);

  /// Finishes the block in an error state, retaining the streamed output when [keep] is true.
  void error({String message = '', bool keep = true}) => _finish(ansi.red(symbols.stepError), message, keep: keep);

  void _finish(String symbol, String message, {required bool keep}) {
    final header = message.isEmpty ? _title : message;
    final frame = [
      barSpacer(),
      gutter(symbol, header),
      if (keep)
        for (final line in _lines) gutter(ansi.gray(symbols.bar), ansi.dim(line)),
    ].join('\n');

    if (_interactive) {
      if (!_started) {
        _active();
      }
      _renderer
        ..render(frame)
        ..commit();
    } else {
      terminal
        ..writeln(barSpacer())
        ..writeln(gutter(symbol, header));
    }
  }

  void _active() {
    _started = true;
    final shown = _limit > 0 && _lines.length > _limit ? _lines.sublist(_lines.length - _limit) : _lines;
    _renderer.render(
      [
        barSpacer(),
        gutter(ansi.cyan(symbols.stepActive), _title),
        for (final line in shown) gutter(ansi.gray(symbols.bar), ansi.dim(line)),
      ].join('\n'),
    );
  }
}
