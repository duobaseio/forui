import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// Repro for accessibility audit finding U7-004: `FPopover` content sorts last in focus traversal, and focus restore
/// after dismissal lands on the wrong element.
///
/// Run on a desktop target or the web (`flutter run -d macos` / `-d chrome`) and follow the on-screen steps. The readout
/// shows which node currently holds primary focus, plus a log of the last few focus changes, so the traversal order is
/// visible without watching focus outlines.
///
/// Root cause: the content is an element tree descendant of the portal, so it already shares the trigger's focus scope,
/// but nothing pins its traversal order. The default `ReadingOrderTraversalPolicy` therefore sorted it geometrically.
///
/// Before the traversal fix, with the popover open and focus on the trigger:
/// `trigger -> after -> before -> popover A -> popover B -> popover A (loops)`. `FPortal` now pins the order, so Tab
/// moves from the trigger straight into the content. The trailing loop is intended: the content `FocusScope` uses
/// [TraversalEdgeBehavior.closedLoop] by default.
///
/// Still open: Escape from inside the popover restores focus to `before` rather than the trigger.
class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  late FocusNode _before;
  late FocusNode _trigger;
  late FocusNode _popoverA;
  late FocusNode _popoverB;
  late FocusNode _after;
  late Map<FocusNode, String> _names;

  final List<String> _log = [];

  @override
  void initState() {
    super.initState();
    _before = FocusNode(debugLabel: 'before');
    _trigger = FocusNode(debugLabel: 'trigger');
    _popoverA = FocusNode(debugLabel: 'popover A');
    _popoverB = FocusNode(debugLabel: 'popover B');
    _after = FocusNode(debugLabel: 'after');
    _names = {
      _before: 'before',
      _trigger: 'trigger',
      _popoverA: 'popover A',
      _popoverB: 'popover B',
      _after: 'after',
    };

    FocusManager.instance.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_onFocusChange);
    _before.dispose();
    _trigger.dispose();
    _popoverA.dispose();
    _popoverB.dispose();
    _after.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    final focused = _focused;
    if (_log.isNotEmpty && _log.last == focused) {
      return;
    }

    setState(() {
      _log.add(focused);
      if (_log.length > 6) {
        _log.removeAt(0);
      }
    });
  }

  String get _focused {
    final focus = FocusManager.instance.primaryFocus;
    return switch (focus) {
      null => '(none)',
      _ => _names[focus] ?? '(${focus.runtimeType})',
    };
  }

  @override
  Widget build(BuildContext context) {
    final FThemeData(:colors, :typography) = context.theme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text('U7-004: FPopover focus traversal', style: typography.body.lg.copyWith(color: colors.foreground)),
              _steps(colors, typography),
              _readout(colors, typography),
              FButton(variant: .outline, focusNode: _before, onPress: () {}, child: const Text('before')),
              FPopover(
                popoverBuilder: (context, controller) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      FButton(focusNode: _popoverA, onPress: () {}, child: const Text('popover A')),
                      FButton(focusNode: _popoverB, onPress: () {}, child: const Text('popover B')),
                    ],
                  ),
                ),
                builder: (context, controller, _) =>
                    FButton(focusNode: _trigger, onPress: controller.toggle, child: const Text('trigger')),
              ),
              FButton(variant: .outline, focusNode: _after, onPress: () {}, child: const Text('after')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _steps(FColors colors, FTypography typography) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 2,
    children: [
      for (final step in const [
        '1. Press Tab until the readout shows "trigger".',
        '2. Press Enter to open the popover.',
        '3. Press Tab. Now lands on "popover A" (part 1, fixed).',
        '4. Press Escape. Expected "trigger", actual "before" (part 2, open).',
      ])
        Text(step, style: typography.body.sm.copyWith(color: colors.mutedForeground)),
      const SizedBox(height: 6),
      Text(
        'Tab inside the popover loops A -> B -> A by design (traversalEdgeBehavior defaults to closedLoop).',
        style: typography.body.xs.copyWith(color: colors.mutedForeground),
      ),
    ],
  );

  Widget _readout(FColors colors, FTypography typography) => DecoratedBox(
    decoration: BoxDecoration(border: Border.all(color: colors.border), borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          Text('focus: $_focused', style: typography.body.sm.copyWith(color: colors.foreground)),
          Text('log: ${_log.join(' -> ')}', style: typography.body.sm.copyWith(color: colors.mutedForeground)),
        ],
      ),
    ),
  );
}
