import 'package:forui_cli/src/terminal/primitives.dart';
import 'package:forui_cli/src/terminal/terminal.dart';
import 'package:forui_cli/src/terminal/theme.dart';

/// Creates a [TaskLog] headed by [title]. Stream output via [TaskLog.message], then finish with [TaskLog.success] or
/// [TaskLog.error].
///
/// [limit] caps how many of the most recent streamed lines stay visible (0 = all).
///
/// Ported from [clack](https://github.com/bombshell-dev/clack). AI-generated; use at your own risk.
TaskLog taskLog({required String title, int limit = 0}) => TaskLog._(title, limit);

/// A block that streams task output under a header, then collapses on success (clearing the output) or retains it on
/// error.
class TaskLog {
  final String _title;
  final int _limit;
  final List<String> _lines = [];
  final FrameRenderer _renderer = FrameRenderer(terminal);
  final bool _interactive = terminal.interactive;
  var _started = false;

  TaskLog._(this._title, this._limit);

  /// Appends an output [line] (which may itself contain newlines) and re-renders.
  void message(String line) {
    _lines.addAll(line.split('\n'));
    if (!_interactive) {
      terminal
        ..write(gutter(ansi.gray(symbols.bar), ansi.dim(line)))
        ..write('\n');
      return;
    }

    _active();
  }

  /// Collapses the block to a success header, discarding the streamed output.
  void success({String message = '', bool keep = false}) =>
      _finish(ansi.green(symbols.stepSubmit), message, keep: keep);

  /// Finishes the block in an error state, retaining the streamed output when [keep] is true.
  void error({String message = '', bool keep = true}) => _finish(ansi.yellow(symbols.stepError), message, keep: keep);

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
        ..write(barSpacer())
        ..write('\n')
        ..write(gutter(symbol, header))
        ..write('\n');
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
