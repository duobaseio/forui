// The FFI bindings below mirror the C `termios` struct and `tcsetattr`/`tcgetattr` signatures, so their type and
// field names intentionally follow the C naming (e.g. tcflag_t, c_iflag, optional_actions).
// ignore_for_file: camel_case_types, constant_identifier_names, non_constant_identifier_names

import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

/// A key press: either a [Control] key or a printable [Character].
sealed class KeyEvent {}

/// The non-printable keys the prompts care about.
enum Control implements KeyEvent { up, down, left, right, enter, escape, backspace, tab, ctrlC, unknown }

/// A printable character (one grapheme).
class Character implements KeyEvent {
  final String character;

  const Character(this.character);
}

final terminal = Platform.isWindows ? WindowsTerminal() : UnixTerminal();

/// The single place stdin/stdout is touched.
///
/// Terminal width comes from Dart's [Stdout.terminalColumns], not dart_console's `Console.windowWidth`: the latter
/// forwards to `ioctl(TIOCGWINSZ)` bound with a fixed-arity FFI signature even though the syscall is variadic, an ABI
/// mismatch that corrupts memory and crashes on arm64 macOS.
abstract class Terminal {
  StreamSubscription<ProcessSignal>? _sigint;

  /// Switches the terminal into raw mode.
  void raw();

  /// Restores the terminal to cooked mode.
  void cooked();

  /// Blocks until a key is pressed and returns it.
  ///
  /// Adapted from Console.readKey: https://github.com/onepub-dev/dart_console/blob/5.1.0/lib/src/console.dart#L383
  KeyEvent readKey() {
    var codeUnit = 0;

    raw();
    try {
      while (codeUnit <= 0) {
        codeUnit = stdin.readByteSync();
      }

      return switch (codeUnit) {
        // Ctrl+A thru Ctrl+Z; only a few are keys the prompts care about.
        >= 0x01 && <= 0x1a => switch (codeUnit) {
          0x03 => Control.ctrlC,
          0x08 => Control.backspace,
          0x09 => Control.tab,
          0x0a || 0x0d => Control.enter,
          _ => Control.unknown,
        },
        // escape sequence (e.g. \x1b[A for up arrow)
        0x1b => switch (stdin.readByteSync()) {
          -1 => Control.escape,
          127 => Control.backspace,
          final code => switch (String.fromCharCode(code)) {
            '[' => switch (stdin.readByteSync()) {
              -1 => Control.escape,
              0x41 => Control.up, // 'A'
              0x42 => Control.down, // 'B'
              0x43 => Control.right, // 'C'
              0x44 => Control.left, // 'D'
              // ESC[<digit>~ (home/end/delete/page): consume the trailing '~'
              final escaped when escaped > '0'.codeUnits[0] && escaped < '9'.codeUnits[0] =>
                stdin.readByteSync() == -1 ? Control.escape : Control.unknown,
              _ => Control.unknown,
            },
            // SS3 function keys: unused
            'O' => stdin.readByteSync() == -1 ? Control.escape : Control.unknown,
            _ => Control.unknown,
          },
        },
        0x7f => Control.backspace,
        0x00 || >= 0x1c && <= 0x1f => Control.unknown,
        // Assume other characters are printable
        _ => Character(.fromCharCode(codeUnit)),
      };
    } finally {
      cooked();
    }
  }

  void write(String text) => stdout.write(text);

  void showCursor() => stdout.write('\x1B[?25h');

  void hideCursor() => stdout.write('\x1B[?25l');

  /// Restores the cursor and exits if interrupted (Ctrl+C) while the event loop is running, e.g. during a spinner.
  /// Prompts see Ctrl+C as a byte instead; this is the backstop for the cooked-mode windows.
  ///
  /// Should always be paired with [releaseCursor].
  void trapCursor() {
    _sigint ??= ProcessSignal.sigint.watch().listen((_) {
      showCursor();
      exit(130);
    });
  }

  /// Cancels the cursor trapped by [trapCursor].
  void releaseCursor() {
    unawaited(_sigint?.cancel());
    _sigint = null;
  }

  bool get interactive => stdin.hasTerminal && stdout.hasTerminal;

  int get columns => stdout.hasTerminal ? stdout.terminalColumns : 80;
}

/// Adapted from https://github.com/felangel/mason/blob/master/packages/mason_logger/lib/src/ffi/unix_terminal.dart
class UnixTerminal extends Terminal {
  late final DynamicLibrary _lib;
  late final Pointer<TermIOS> _origTermIOSPointer;
  late final TCGetAttrDart _tcgetattr;
  late final TCSetAttrDart _tcsetattr;

  UnixTerminal() {
    _lib = Platform.isMacOS ? DynamicLibrary.open('/usr/lib/libSystem.dylib') : DynamicLibrary.open('libc.so.6');
    _tcgetattr = _lib.lookupFunction<TCGetAttrNative, TCGetAttrDart>('tcgetattr');
    _tcsetattr = _lib.lookupFunction<TCSetAttrNative, TCSetAttrDart>('tcsetattr');
    _origTermIOSPointer = calloc<TermIOS>();
    _tcgetattr(_STDIN_FILENO, _origTermIOSPointer);
  }

  @override
  void raw() {
    final origTermIOS = _origTermIOSPointer.ref;
    final newTermIOSPointer = calloc<TermIOS>()
      ..ref.c_iflag = origTermIOS.c_iflag & ~(_BRKINT | _ICRNL | _INPCK | _ISTRIP | _IXON)
      ..ref.c_oflag = origTermIOS.c_oflag & ~_OPOST
      ..ref.c_cflag = (origTermIOS.c_cflag & ~_CSIZE) | _CS8
      ..ref.c_lflag = origTermIOS.c_lflag & ~(_ECHO | _ICANON | _IEXTEN | _ISIG)
      ..ref.c_cc = origTermIOS.c_cc
      ..ref.c_cc[_VMIN] = 0
      ..ref.c_cc[_VTIME] = 1
      ..ref.c_ispeed = origTermIOS.c_ispeed
      ..ref.c_oflag = origTermIOS.c_ospeed;

    _tcsetattr(_STDIN_FILENO, _TCSANOW, newTermIOSPointer);
    calloc.free(newTermIOSPointer);
  }

  @override
  void cooked() {
    if (nullptr == _origTermIOSPointer.cast()) {
      return;
    }
    _tcsetattr(_STDIN_FILENO, _TCSANOW, _origTermIOSPointer);
  }
}

// Input Modes
// https://ftp.gnu.org/old-gnu/Manuals/glibc-2.2.3/html_node/libc_352.html
const int _BRKINT = 0x00000002;
const int _INPCK = 0x00000010;
const int _ISTRIP = 0x00000020;
const int _ICRNL = 0x00000100;
const int _IXON = 0x00000200;

// Output Modes
// https://ftp.gnu.org/old-gnu/Manuals/glibc-2.2.3/html_node/libc_353.html#SEC362
const int _OPOST = 0x00000001;

// Control Modes
// https://ftp.gnu.org/old-gnu/Manuals/glibc-2.2.3/html_node/libc_354.html#SEC363
const int _CSIZE = 0x00000300;
const int _CS8 = 0x00000300;

// Local Modes
// https://ftp.gnu.org/old-gnu/Manuals/glibc-2.2.3/html_node/libc_355.html#SEC364
const int _ECHO = 0x00000008;
const int _ISIG = 0x00000080;
const int _ICANON = 0x00000100;
const int _IEXTEN = 0x00000400;
const int _TCSANOW = 0;
const int _VMIN = 16;
const int _VTIME = 17;

typedef tcflag_t = UnsignedLong;
typedef cc_t = UnsignedChar;
typedef speed_t = UnsignedLong;

// The default standard input file descriptor number which is 0.
const _STDIN_FILENO = 0;

// The number of elements in the control chars array.
const _NCSS = 20;

final class TermIOS extends Struct {
  @tcflag_t()
  external int c_iflag; // input flags
  @tcflag_t()
  external int c_oflag; // output flags
  @tcflag_t()
  external int c_cflag; // control flags
  @tcflag_t()
  external int c_lflag; // local flags
  @Array(_NCSS)
  external Array<cc_t> c_cc; // control chars
  @speed_t()
  external int c_ispeed; // input speed
  @speed_t()
  external int c_ospeed; // output speed
}

// int tcgetattr(int, struct termios *);
typedef TCGetAttrNative = Int32 Function(Int32 fildes, Pointer<TermIOS> termios);
typedef TCGetAttrDart = int Function(int fildes, Pointer<TermIOS> termios);

// int tcsetattr(int, int, const struct termios *);
typedef TCSetAttrNative = Int32 Function(Int32 fildes, Int32 optional_actions, Pointer<TermIOS> termios);
typedef TCSetAttrDart = int Function(int fildes, int optional_actions, Pointer<TermIOS> termios);

/// Adapted from https://github.com/felangel/mason/blob/master/packages/mason_logger/lib/src/ffi/windows_terminal.dart
///
/// We inline the win32 FFI bindings so we don't have to depend on win32.
class WindowsTerminal extends Terminal {
  late final SetConsoleModeDart _setConsoleMode;
  late final int _inputHandle;

  WindowsTerminal() {
    final kernel32 = DynamicLibrary.open('kernel32.dll');
    final getStdHandle = kernel32.lookupFunction<GetStdHandleNative, GetStdHandleDart>('GetStdHandle');
    _setConsoleMode = kernel32.lookupFunction<SetConsoleModeNative, SetConsoleModeDart>('SetConsoleMode');
    _inputHandle = getStdHandle(_STD_INPUT_HANDLE);
  }

  @override
  void raw() {
    const mode = (~_ENABLE_ECHO_INPUT) & (~_ENABLE_PROCESSED_INPUT) & (~_ENABLE_LINE_INPUT) & (~_ENABLE_WINDOW_INPUT);
    _setConsoleMode(_inputHandle, mode);
  }

  @override
  void cooked() {
    const mode =
        _ENABLE_ECHO_INPUT |
        _ENABLE_EXTENDED_FLAGS |
        _ENABLE_INSERT_MODE |
        _ENABLE_LINE_INPUT |
        _ENABLE_MOUSE_INPUT |
        _ENABLE_PROCESSED_INPUT |
        _ENABLE_QUICK_EDIT_MODE |
        _ENABLE_VIRTUAL_TERMINAL_INPUT;
    _setConsoleMode(_inputHandle, mode);
  }
}

// Standard input device handle for GetStdHandle, as a DWORD: STD_INPUT_HANDLE == (DWORD)-10.
const _STD_INPUT_HANDLE = 0xFFFFFFF6;

// Console input mode flags. https://learn.microsoft.com/windows/console/setconsolemode
const _ENABLE_PROCESSED_INPUT = 0x0001;
const _ENABLE_LINE_INPUT = 0x0002;
const _ENABLE_ECHO_INPUT = 0x0004;
const _ENABLE_WINDOW_INPUT = 0x0008;
const _ENABLE_MOUSE_INPUT = 0x0010;
const _ENABLE_INSERT_MODE = 0x0020;
const _ENABLE_QUICK_EDIT_MODE = 0x0040;
const _ENABLE_EXTENDED_FLAGS = 0x0080;
const _ENABLE_VIRTUAL_TERMINAL_INPUT = 0x0200;

// HANDLE GetStdHandle(DWORD nStdHandle);
typedef GetStdHandleNative = IntPtr Function(Uint32 nStdHandle);
typedef GetStdHandleDart = int Function(int nStdHandle);

// BOOL SetConsoleMode(HANDLE hConsoleHandle, DWORD dwMode);
typedef SetConsoleModeNative = Int32 Function(IntPtr hConsoleHandle, Uint32 dwMode);
typedef SetConsoleModeDart = int Function(int hConsoleHandle, int dwMode);
