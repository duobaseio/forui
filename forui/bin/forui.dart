import 'dart:io';

/// A shim that forwards to forui_cli.
Future<void> main(List<String> args) async {
  // Is forui_cli already available as a dependency?
  if ((await Process.run('dart', ['run', 'forui_cli', '--help'], runInShell: true)).exitCode != 0) {
    stderr.writeln('Installing forui_cli (one-time setup)...');
    if ((await Process.run('dart', ['pub', 'add', 'forui_cli', '--dev'], runInShell: true)).exitCode != 0) {
      stderr
        ..writeln('Could not install forui_cli automatically.')
        ..writeln('Run: dart pub add forui_cli --dev');
      exit(1);
    }
  }

  // Let forui_cli own Ctrl+C so its prompts can restore the cursor; this launcher just waits for the child's exit code.
  ProcessSignal.sigint.watch().listen((_) {});

  // Hand off to the real CLI, forwarding all args and streaming I/O over the inherited terminal.
  final proc = await Process.start('dart', ['run', 'forui_cli', ...args], mode: .inheritStdio);
  exit(await proc.exitCode);
}
