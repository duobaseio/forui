import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// Repro for accessibility audit finding U3-016: `FPagination`'s previous/next actions stay enabled at the range edges.
///
/// Run on any target (`flutter run -d macos` / `-d chrome`) and follow the on-screen steps.
///
/// [FPaginationController.previous] and [FPaginationController.next] guard internally, so activating them at the
/// first/last page is a silent no-op. The buttons were nonetheless always built with a non-null `onPress`, so
/// `FTappable` reported `enabled: true` and kept a `tap` action.
///
/// The readout below dumps the live semantics node for each action, so the state is visible without a screen reader.
/// Semantics is force-enabled via [SemanticsBinding.ensureSemantics], which is why the readout is populated even with
/// VoiceOver/TalkBack off.
///
/// Before the fix, "Previous" reported this on page 1 of 3, unchanged as you paged:
///   actions: focus, tap
///   flags:   isButton, hasEnabledState, isEnabled, isFocusable
///
/// The actions are now built inside the `ListenableBuilder` and take a null `onPress` at their edge, so they drop the
/// `tap` action and `isEnabled`, leave the focus order, and dim. The second pagination has a single page, so both are
/// inert from the start.
class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  final GlobalKey _multiple = GlobalKey();
  final GlobalKey _single = GlobalKey();

  late SemanticsHandle _semantics;
  late FPaginationController _controller;

  Map<String, String> _multipleNodes = const {};
  Map<String, String> _singleNodes = const {};

  @override
  void initState() {
    super.initState();
    _semantics = SemanticsBinding.instance.ensureSemantics();
    _controller = FPaginationController(pages: 3);
    _controller.addListener(_schedule);
    _schedule();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_schedule)
      ..dispose();
    _semantics.dispose();
    super.dispose();
  }

  void _schedule() => WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) {
      return;
    }

    final multiple = _dump(_multiple);
    final single = _dump(_single);
    if (!mapEquals(multiple, _multipleNodes) || !mapEquals(single, _singleNodes)) {
      setState(() {
        _multipleNodes = multiple;
        _singleNodes = single;
      });
    }
  });

  /// Collects the semantics node of every labelled action inside [key]'s subtree, keyed by label.
  Map<String, String> _dump(GlobalKey key) {
    if (key.currentContext?.findRenderObject() case final root?) {
      final nodes = <String, String>{};

      void visit(RenderObject object) {
        if (object.debugSemantics case final node? when node.label == 'Previous' || node.label == 'Next') {
          nodes[node.label] = _summarize(node);
        }
        object.visitChildren(visit);
      }

      visit(root);
      return nodes;
    }

    return const {};
  }

  String _summarize(SemanticsNode node) {
    final description = node.toString();
    final actions = RegExp(r'actions: \[(.*?)\]').firstMatch(description)?.group(1) ?? 'none';
    final flags = RegExp(r'flags: \[(.*?)\]').firstMatch(description)?.group(1) ?? 'none';
    return 'actions: $actions\nflags:   $flags';
  }

  @override
  Widget build(BuildContext context) {
    final FThemeData(:colors, :typography) = context.theme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text(
                'U3-016: FPagination prev/next stay enabled at the edges',
                textAlign: TextAlign.center,
                style: typography.body.lg.copyWith(color: colors.foreground),
              ),
              _steps(colors, typography),
              Text(
                'Three pages, currently on page ${_controller.value + 1}',
                style: typography.body.sm.copyWith(color: colors.mutedForeground),
              ),
              FPagination(
                key: _multiple,
                control: .managed(controller: _controller),
              ),
              _readout(colors, typography, _multipleNodes),
              Text(
                'One page, so both actions are always inert',
                style: typography.body.sm.copyWith(color: colors.mutedForeground),
              ),
              FPagination(key: _single, control: const .managed(pages: 1)),
              _readout(colors, typography, _singleNodes),
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
        '1. On page 1, the left chevron is dimmed and its row below reports no tap action and no isEnabled.',
        '2. Press Tab. Focus skips the left chevron and lands on page 1.',
        '3. Click the right chevron to reach page 2. The left chevron un-dims and regains its tap action.',
        '4. Click through to page 3. "Next" now reports the same thing "Previous" did on page 1.',
      ])
        Text(step, style: typography.body.sm.copyWith(color: colors.mutedForeground)),
      const SizedBox(height: 6),
      Text(
        'With a screen reader on, an action at its edge is announced as a disabled button.',
        style: typography.body.xs.copyWith(color: colors.mutedForeground),
      ),
    ],
  );

  Widget _readout(FColors colors, FTypography typography, Map<String, String> nodes) => DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(color: colors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          if (nodes.isEmpty)
            Text('(no semantics yet)', style: typography.body.sm.copyWith(color: colors.mutedForeground))
          else
            for (final MapEntry(key: label, value: summary) in nodes.entries)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: typography.body.sm.copyWith(color: colors.foreground)),
                  Text(summary, style: typography.body.xs.copyWith(color: colors.mutedForeground)),
                ],
              ),
        ],
      ),
    ),
  );
}
