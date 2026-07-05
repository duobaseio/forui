# CLI Autocompletion & Suggestions

Author: Matt (Pante)
Status: Declined (July 2026)

## Summary

**AI Disclaimer: This summary was generated as part of our experiment with Claude Fable.**

This document summarizes our research (July 2026) into providing shell autocompletion and IDE terminal completion
popovers for the Forui CLI, and why we are abandoning the effort. In short: every distribution channel is either
structurally closed to our primary invocation (`dart run forui`), dead upstream, or only reaches a minority audience.
The CLI's interactive clack-style prompts already solve the underlying discoverability problem on the path that
matters.

## Background: how CLI completion actually works

There are two unrelated systems, plus a third often conflated with them:

1. **Shell tab completion.** The shell (not the terminal) executes registered completion code on Tab. Dispatch is
   keyed on the first word of the command line (argv[0]). Modern CLIs ship a thin generated script that calls back
   into the binary at Tab-time so completion logic lives with the command definitions: cobra's hidden `__complete`
   subcommand, click's `_TOOL_COMPLETE` protocol, and Dart's `package:cli_completion` (a hidden `completion` command
   behind `CompletionCommandRunner`, used by very_good_cli, dart_frog, mason, fvm, and shorebird).
2. **Spec-based popovers.** The terminal application parses a declarative completion spec itself and renders an
   as-you-type popup, no Tab or shell involvement. The lingua franca is Fig's TypeScript spec corpus
   ([withfig/autocomplete](https://github.com/withfig/autocomplete)), consumed by JetBrains IDE terminals, VS Code
   terminal IntelliSense, Warp, Microsoft inshellisense, and Amazon Q CLI. Dynamic values come from "generators",
   shell commands the engine runs and post-processes.
3. **Suggestions/predictions** (fish autosuggestions, zsh-autosuggestions, PSReadLine predictors, AI ghost text) are
   history- or AI-driven whole-command predictions. They are not something a CLI author integrates with.

## How the IntelliJ reworked terminal popover works (verified)

We reverse-engineered the pipeline from `plugins/terminal` in intellij-community and JetBrains' shipped artifacts:

- Keystrokes pass through to the shell (the scrapped 2024 terminal intercepted them and broke shells). Injected shell
  integration scripts emit OSC 1341 sequences (`prompt_started`, `command_started`, an alias dump) so the IDE knows
  where the typed command begins. A typing listener waits for the shell to echo each character, then opens the popup
  as an editor overlay.
- Completion data comes from a bundled jar, `org.jetbrains.terminal:completion-db-with-extensions`, of ~1,400 JSON
  specs. We proved it is a mechanical conversion of withfig/autocomplete: 707 of 708 top-level spec names match 1:1
  (the sole exception is JetBrains' own `all_commands.json` index), descriptions are byte-identical, and Fig-only
  oddities (`-.json`, `@fig/publish-spec`) are included. `dart.json` is present; `forui` is not.
- The popover never reads installed bash/zsh completions. The only third-party paths in are a spec merged upstream
  into withfig/autocomplete, or an IntelliJ plugin implementing the experimental
  `org.jetbrains.plugins.terminal.commandSpecsProvider` extension point (requires users to install the plugin).
- PowerShell is the exception: the IDE calls the shell's own `TabExpansion2` via shell integration. VS Code's
  terminal IntelliSense uses the same architecture (bundled Fig-derived specs + `TabExpansion2` for pwsh).

## Why we are declining

1. **Our primary invocation is unreachable.** The CLI ships inside the `forui` package and is documented as
   `dart run forui`. Every completion system dispatches on the first word, `dart`, so a `forui` completion (shell or
   spec) is never consulted. Delegation through a wrapper requires the wrapper's own completion to chain (zsh's
   `_normal`, Fig's `isCommand`/`loadSpec`, as `sudo` and `npx` do); the `dart` tool ships no completions at all, and
   the Fig `dart` spec's `run` subcommand declares options but no positional argument, so there is nothing to chain
   through. Even with delegation, `dart run`'s startup latency (dependency resolution + compile checks, often 1s+)
   makes a Tab-time callback unusable. This is the shared fate of all runner-invoked CLIs (`npx`, `bundle exec`,
   `cargo run`); none have working completion, so users do not expect it.
2. **The zero-install popover channel is dead.** withfig/autocomplete has been frozen since 2025-05-05 (last commit,
   merge, and npm publish all that day; 52 open PRs including new-spec submissions from spring 2026 sitting
   unmerged; no credible successor fork). JetBrains, Warp, and inshellisense all consume snapshots of the frozen
   corpus. A `forui` spec PR would likely never merge, and JetBrains has no other public contribution channel. The
   remaining route, an IntelliJ plugin implementing the experimental `commandSpecsProvider` extension point, requires
   every user to install a plugin; not worth building unless a Forui IDE plugin exists for other reasons.
3. **Shell completion only reaches a minority.** `package:cli_completion` works well but binds to a real `forui`
   executable on PATH (`dart pub global activate`), which is not our documented flow. It is also bash/zsh only,
   mutates the user's rc file on first run, and has not seen a release since Aug 2024.
4. **The problem is already solved where it matters.** Completion exists to make commands and valid arguments
   discoverable. `dart run forui style create` with no arguments falls into the interactive autocomplete multiselect
   with every style name, a richer experience than shell completion could offer. Investing in prompts widens this
   moat; investing in completion duplicates it for a narrower audience.

## Revisit triggers

- **The CLI gains a first-class global install** (pub global activate as the documented flow, or a Homebrew-distributed
  `dart compile exe` binary). Then adopt `cli_completion` by rebasing `ForuiCommandRunner` onto
  `CompletionCommandRunner`: keep the hidden `completion` command fast (skip configuration parsing), and prefer an
  explicit install command over silent rc-file mutation. Homebrew additionally installs completions into vendor
  directories with zero user setup.
- **VS Code terminal-suggest gains a `dart` spec that chains from `run`.** VS Code's terminal IntelliSense
  (GA'd and rolled out v1.106-1.108, Oct-Dec 2025) is the only actively maintained spec corpus accepting
  contributions (in-repo at `microsoft/vscode/extensions/terminal-suggest`; commits as of June 2026). It currently
  vendors no `dart` spec at all. A spec whose `run` argument delegates via `isCommand`/`loadSpec` is the only
  realistic route to completing `dart run forui` anywhere, and could be our own PR someday.
- **The Fig corpus revives** (Amazon hands it to the community, or a maintained fork emerges), or **JetBrains ships
  user-defined local specs** (YouTrack requests exist, nothing shipped).

## References

- [JetBrains terminal architecture post](https://blog.jetbrains.com/idea/2025/04/jetbrains-terminal-a-new-architecture/)
- [intellij-community plugins/terminal](https://github.com/JetBrains/intellij-community/tree/master/plugins/terminal)
  (shell integration scripts, completion engine, `terminal.xml` registrations)
- Spec DB artifact: `org.jetbrains.terminal:completion-db-with-extensions` on JetBrains' intellij-dependencies repo
- [withfig/autocomplete](https://github.com/withfig/autocomplete) (frozen May 2025)
- [package:cli_completion](https://pub.dev/packages/cli_completion)
- [VS Code terminal-suggest extension](https://github.com/microsoft/vscode/tree/main/extensions/terminal-suggest) and
  [v1.106 release notes](https://code.visualstudio.com/updates/v1_106)
