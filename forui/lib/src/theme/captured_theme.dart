import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// Similar to [InheritedTheme.capture], [FCapturedTheme] captures [FTheme]'s fields from one [BuildContext] to
/// another. This is typically used when a navigator pushes a new route.
///
/// See:
/// * [FTheme.capture].
class FCapturedTheme {
  /// The captured theme data, or null if no theme was captured.
  final ValueListenable<FThemeData>? theme;

  /// The captured accessibility features, or null if no accessibility scope was captured.
  final ValueListenable<FAccessibility>? accessibility;

  /// The captured platform variant, or null if no adaptive scope was captured.
  final ValueListenable<FPlatformVariant>? platform;

  /// Creates a [FCapturedTheme].
  const FCapturedTheme({this.theme, this.accessibility, this.platform});

  /// Wraps the given [child] in widgets that re-establish and observe the captured scopes.
  Widget wrap(Widget child) =>
      theme == null && accessibility == null && platform == null ? child : _CapturedTheme(captured: this, child: child);
}

class _CapturedTheme extends StatefulWidget {
  final FCapturedTheme captured;
  final Widget child;

  const _CapturedTheme({required this.captured, required this.child});

  @override
  State<_CapturedTheme> createState() => _CapturedThemeState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('captured', captured));
  }
}

class _CapturedThemeState extends State<_CapturedTheme> {
  bool _deferred = false;

  @override
  void initState() {
    super.initState();
    widget.captured.theme?.addListener(_onChange);
    widget.captured.accessibility?.addListener(_onChange);
    widget.captured.platform?.addListener(_onChange);
  }

  @override
  void didUpdateWidget(covariant _CapturedTheme old) {
    super.didUpdateWidget(old);
    if (!identical(old.captured.theme, widget.captured.theme)) {
      old.captured.theme?.removeListener(_onChange);
      widget.captured.theme?.addListener(_onChange);
    }

    if (!identical(old.captured.accessibility, widget.captured.accessibility)) {
      old.captured.accessibility?.removeListener(_onChange);
      widget.captured.accessibility?.addListener(_onChange);
    }

    if (!identical(old.captured.platform, widget.captured.platform)) {
      old.captured.platform?.removeListener(_onChange);
      widget.captured.platform?.addListener(_onChange);
    }
  }

  @override
  void dispose() {
    widget.captured.theme?.removeListener(_onChange);
    widget.captured.accessibility?.removeListener(_onChange);
    widget.captured.platform?.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    if (!mounted) {
      return;
    }

    // A captured scope usually rebuilds during the framework's build phase while this widget is in an unrelated
    // subtree, which cannot be marked dirty mid-build. Defer the rebuild to the end of the frame instead, same as
    // [OverlayEntry.remove] and [LocalHistoryRoute.changedInternalState].
    if (WidgetsBinding.instance.schedulerPhase == .persistentCallbacks) {
      if (!_deferred) {
        _deferred = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _deferred = false;
          if (mounted) {
            setState(() {});
          }
        });
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.captured.theme case final theme?) {
      return FBasicTheme(
        data: theme.value,
        accessibility: widget.captured.accessibility?.value,
        platform: widget.captured.platform?.value,
        child: widget.child,
      );
    }

    var child = widget.child;
    if (widget.captured.platform case final platform?) {
      child = FAdaptiveScope(platform: platform.value, child: child);
    }

    if (widget.captured.accessibility case final accessibility?) {
      child = FAccessibilityScope(data: accessibility.value, child: child);
    }

    return child;
  }
}
