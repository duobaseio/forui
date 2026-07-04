import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:forui/forui.dart';

/// Repro for https://github.com/duobaseio/forui/issues/1079.
///
/// Run on the web (`flutter run -d chrome`) for the true repro. With semantics enabled, a mouse click routes through the
/// accessibility tree as a `SemanticsAction.focus`, which Flutter treats as a touch interaction ([FocusHighlightMode] ->
/// `touch`). Focus decorations should therefore NOT appear on a pointer click, only after keyboard (Tab) focus flips the
/// mode back to `traditional`.
///
/// Watch the live highlight mode readout as you click vs. Tab. The Material button is there as a reference; it already
/// gates its focus highlight on the mode.
class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  SemanticsHandle? _semantics;
  FocusHighlightMode _mode = FocusManager.instance.highlightMode;

  @override
  void initState() {
    super.initState();
    _semantics = SemanticsBinding.instance.ensureSemantics();
    FocusManager.instance.addHighlightModeListener(_onModeChange);
  }

  @override
  void dispose() {
    FocusManager.instance.removeHighlightModeListener(_onModeChange);
    _semantics?.dispose();
    super.dispose();
  }

  void _onModeChange(FocusHighlightMode mode) => setState(() => _mode = mode);

  void _toggleSemantics() => setState(() {
    if (_semantics case final handle?) {
      handle.dispose();
      _semantics = null;
    } else {
      _semantics = SemanticsBinding.instance.ensureSemantics();
    }
  });

  @override
  Widget build(BuildContext context) {
    final FThemeData(:colors, :typography) = context.theme;
    final enabled = _semantics != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text('Issue #1079', style: typography.body.lg.copyWith(color: colors.foreground)),
              Text(
                'Click a button with the mouse, then press Tab. With semantics on (web), the click should NOT leave a '
                'focus outline; Tab should.',
                textAlign: TextAlign.center,
                style: typography.body.sm.copyWith(color: colors.mutedForeground),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: colors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 2,
                    children: [
                      Text('semantics: ${enabled ? 'on' : 'off'}', style: typography.body.sm),
                      Text('highlight mode: ${_mode.name}', style: typography.body.sm),
                    ],
                  ),
                ),
              ),
              FButton(
                variant: .outline,
                onPress: _toggleSemantics,
                child: Text(enabled ? 'Disable semantics' : 'Enable semantics'),
              ),
              const FDivider(),
              FButton(onPress: () {}, child: const Text('FButton primary')),
              FButton(variant: .outline, onPress: () {}, child: const Text('FButton outline')),
              FButton(variant: .secondary, onPress: () {}, child: const Text('FButton secondary')),
              FButton(variant: .destructive, onPress: () {}, child: const Text('FButton destructive')),
              const FTextField(hint: 'FTextField (keeps its focus border)'),
              const SizedBox(height: 4),
              ElevatedButton(onPressed: () {}, child: const Text('Material ElevatedButton')),
            ],
          ),
        ),
      ),
    );
  }
}
