import 'dart:io';

final ansi = () {
  final env = Platform.environment;
  return Ansi(enabled: stdout.hasTerminal && !env.containsKey('NO_COLOR') && env['TERM'] != 'dumb');
}();

final truecolor = () {
  final env = Platform.environment;
  final colorterm = env['COLORTERM'];
  // JediTerm renders 24-bit colour but doesn't advertise it via COLORTERM, so trust it explicitly (as `symbols` does).
  final supported =
      colorterm == 'truecolor' || colorterm == '24bit' || env['TERMINAL_EMULATOR'] == 'JetBrains-JediTerm';
  return Truecolor(enabled: ansi.enabled && supported);
}();

final symbols = () {
  final env = Platform.environment;
  const unicode = Symbols(
    bar: '│',
    barStart: '┌',
    barEnd: '└',
    hLine: '─',
    stepActive: '◆',
    stepSubmit: '◇',
    stepCancel: '■',
    stepError: '▲',
    logInfo: '●',
    logSuccess: '◆',
    logWarn: '▲',
    logError: '■',
    radioActive: '●',
    radioInactive: '○',
    checkboxSelected: '◼',
    checkboxActive: '◻',
    checkboxInactive: '◻',
    swatch: '█',
    scrollThumb: '█',
    scrollTrack: '░',
    boxTopRight: '╮',
    connectLeft: '├',
    boxBottomRight: '╯',
    spinnerFrames: ['◒', '◐', '◓', '◑'],
    spinnerInterval: Duration(milliseconds: 80),
    unicode: true,
  );
  const ascii = Symbols(
    bar: '|',
    barStart: 'T',
    barEnd: '-',
    hLine: '-',
    stepActive: '*',
    stepSubmit: 'o',
    stepCancel: 'x',
    stepError: 'x',
    logInfo: '•',
    logSuccess: '*',
    logWarn: '!',
    logError: 'x',
    radioActive: '>',
    radioInactive: ' ',
    checkboxSelected: '[+]',
    checkboxActive: '[•]',
    checkboxInactive: '[ ]',
    swatch: '#',
    scrollThumb: '#',
    scrollTrack: ':',
    boxTopRight: '+',
    connectLeft: '+',
    boxBottomRight: '+',
    spinnerFrames: ['•', 'o', 'O', '0'],
    spinnerInterval: Duration(milliseconds: 120),
    unicode: false,
  );

  // The geometric glyphs (`│ ◆ ◇ ─ ╮`) are all single-cell, so unlike emoji they render fine in JetBrains JediTerm,
  // which is therefore treated as unicode-capable.
  final unicodeSupported = !Platform.isWindows
      ? env['TERM'] != 'linux'
      : env.containsKey('WT_SESSION') || // Windows Terminal
            env['TERMINAL_EMULATOR'] == 'JetBrains-JediTerm' ||
            env['TERM_PROGRAM'] == 'vscode' ||
            env['TERM'] == 'xterm-256color' ||
            env['TERM'] == 'alacritty';

  return unicodeSupported ? unicode : ascii;
}();

/// Applies ANSI colours, or no-ops when color is disabled.
///
/// Each method wraps the text in a self-contained colour + reset pair. Do not nest calls (the inner reset would clear
/// the outer colour); style separate string segments instead.
class Ansi {
  static final _pattern = RegExp(r'\x1B\[[0-9;]*m');

  final bool enabled;

  const Ansi({required this.enabled});

  /// Removes ANSI SGR (colour/style) escape sequences from [text].
  String strip(String text) => text.replaceAll(_pattern, '');

  String cyan(String text) => _wrap('36', text);

  String blue(String text) => _wrap('34', text);

  String green(String text) => _wrap('32', text);

  String red(String text) => _wrap('31', text);

  String yellow(String text) => _wrap('33', text);

  String magenta(String text) => _wrap('35', text);

  String gray(String text) => _wrap('90', text);

  String dim(String text) => _wrap('2', text);

  String _wrap(String code, String text) => enabled ? '\x1B[${code}m$text\x1B[0m' : text;

  /// An inverse-video single-space "cursor", or `_` when colour is disabled.
  String get cursor => enabled ? '\x1B[7m \x1B[0m' : '_';
}

/// Applies 24-bit truecolor, or no-ops when truecolor is unsupported.
///
/// Unlike [Ansi]'s palette colours, these emit an exact RGB triple and ignore the terminal theme. Use for content whose
/// colour is the point (e.g. theme swatches), not framework chrome. Output is stripped by [Ansi.strip].
class Truecolor {
  final bool enabled;

  const Truecolor({required this.enabled});

  /// Colours [text]'s foreground with [color] (`0xAARRGGBB`; alpha ignored).
  String foreground(int color, String text) => _wrap(38, color, text);

  /// Colours [text]'s background with [color] (`0xAARRGGBB`; alpha ignored).
  String background(int color, String text) => _wrap(48, color, text);

  String _wrap(int layer, int color, String text) =>
      enabled ? '\x1B[$layer;2;${(color >> 16) & 0xFF};${(color >> 8) & 0xFF};${color & 0xFF}m$text\x1B[0m' : text;
}

/// The glyphs used to draw the gutter, step markers, radios, swatch, box and spinner.
class Symbols {
  final String bar;
  final String barStart;
  final String barEnd;
  final String hLine;
  final String stepActive;
  final String stepSubmit;
  final String stepCancel;
  final String stepError;
  final String logInfo;
  final String logSuccess;
  final String logWarn;
  final String logError;
  final String radioActive;
  final String radioInactive;
  final String checkboxSelected;
  final String checkboxActive;
  final String checkboxInactive;
  final String swatch;
  final String scrollThumb;
  final String scrollTrack;
  final String boxTopRight;
  final String connectLeft;
  final String boxBottomRight;
  final List<String> spinnerFrames;
  final Duration spinnerInterval;
  final bool unicode;

  const Symbols({
    required this.bar,
    required this.barStart,
    required this.barEnd,
    required this.hLine,
    required this.stepActive,
    required this.stepSubmit,
    required this.stepCancel,
    required this.stepError,
    required this.logInfo,
    required this.logSuccess,
    required this.logWarn,
    required this.logError,
    required this.radioActive,
    required this.radioInactive,
    required this.checkboxSelected,
    required this.checkboxActive,
    required this.checkboxInactive,
    required this.swatch,
    required this.scrollThumb,
    required this.scrollTrack,
    required this.boxTopRight,
    required this.connectLeft,
    required this.boxBottomRight,
    required this.spinnerFrames,
    required this.spinnerInterval,
    required this.unicode,
  });
}
