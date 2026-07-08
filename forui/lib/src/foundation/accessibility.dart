import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

/// The platform's motion accessibility preference.
enum FAccessibilityMotion {
  /// Motion is unrestricted.
  full,

  /// Large or spatial motions are reduced and/or replaced with simpler animations such as cross-fades.
  ///
  /// Only set by iOS.
  reduced,

  /// All animations are disabled.
  ///
  /// Only set by Android and web.
  disabled,
}

/// The accessibility features which Forui widgets adhere to.
final class FAccessibility with Diagnosticable {
  /// {@template forui.foundation.FAccessibility.accessibleNavigation}
  /// True if a screen reader or similar service is changing the interaction model.
  /// {@endtemplate}
  final bool accessibleNavigation;

  /// {@template forui.foundation.FAccessibility.deterministicCursor}
  /// True if the platform requests a non-blinking, deterministic text cursor.
  ///
  /// [FAccessibilityMotion.disabled] also requests a non-blinking, deterministic text cursor.
  /// {@endtemplate}
  final bool deterministicCursor;

  /// {@template forui.foundation.FAccessibility.motion}
  /// The motion preference.
  /// {@endtemplate}
  final FAccessibilityMotion motion;

  /// {@template forui.foundation.FAccessibility.focusHighlight}
  /// True if focused widgets should show a focus highlight, such as a focus ring.
  /// {@endtemplate}
  final bool focusHighlight;

  /// Creates a [FAccessibility].
  const FAccessibility({
    required this.accessibleNavigation,
    required this.deterministicCursor,
    required this.motion,
    required this.focusHighlight,
  });

  /// Returns a copy of this [FAccessibility] with the given fields replaced.
  FAccessibility copyWith({
    bool? accessibleNavigation,
    bool? deterministicCursor,
    FAccessibilityMotion? motion,
    bool? focusHighlight,
  }) => FAccessibility(
    accessibleNavigation: accessibleNavigation ?? this.accessibleNavigation,
    deterministicCursor: deterministicCursor ?? this.deterministicCursor,
    motion: motion ?? this.motion,
    focusHighlight: focusHighlight ?? this.focusHighlight,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('accessibleNavigation', value: accessibleNavigation, ifTrue: 'accessibleNavigation'))
      ..add(FlagProperty('deterministicCursor', value: deterministicCursor, ifTrue: 'deterministicCursor'))
      ..add(EnumProperty('motion', motion))
      ..add(FlagProperty('focusHighlight', value: focusHighlight, ifTrue: 'focusHighlight'));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAccessibility &&
          runtimeType == other.runtimeType &&
          accessibleNavigation == other.accessibleNavigation &&
          deterministicCursor == other.deterministicCursor &&
          motion == other.motion &&
          focusHighlight == other.focusHighlight;

  @override
  int get hashCode => Object.hash(accessibleNavigation, deterministicCursor, motion, focusHighlight);
}

enum _Aspect { accessibleNavigation, deterministicCursor, motion, focusHighlight }

/// Provides the [FAccessibility] features to descendants and updates them when the platform settings change.
class FAccessibilityScope extends StatefulWidget {
  /// Returns [FAccessibility.accessibleNavigation] of the nearest [FAccessibilityScope] in the given [context].
  ///
  /// It is recommended to use the terser [FAccessibilityContext.accessibleNavigation] getter instead.
  @useResult
  static bool accessibleNavigationOf(BuildContext context) => InheritedModel.inheritFrom<_Accessibility>(
    context,
    aspect: _Aspect.accessibleNavigation,
  )!.data.accessibleNavigation;

  /// Returns [FAccessibility.deterministicCursor] of the nearest [FAccessibilityScope] in the given [context].
  ///
  /// It is recommended to use the terser [FAccessibilityContext.deterministicCursor] getter instead.
  @useResult
  static bool deterministicCursorOf(BuildContext context) => InheritedModel.inheritFrom<_Accessibility>(
    context,
    aspect: _Aspect.deterministicCursor,
  )!.data.deterministicCursor;

  /// Returns [FAccessibility.motion] of the nearest [FAccessibilityScope] in the given [context].
  ///
  /// It is recommended to use the terser [FAccessibilityContext.motion] getter instead.
  @useResult
  static FAccessibilityMotion motionOf(BuildContext context) =>
      InheritedModel.inheritFrom<_Accessibility>(context, aspect: _Aspect.motion)!.data.motion;

  /// Returns [FAccessibility.focusHighlight] of the nearest [FAccessibilityScope] in the given [context].
  ///
  /// It is recommended to use the terser [FAccessibilityContext.focusHighlight] getter instead.
  @useResult
  static bool focusHighlightOf(BuildContext context) =>
      InheritedModel.inheritFrom<_Accessibility>(context, aspect: _Aspect.focusHighlight)!.data.focusHighlight;

  /// The features to expose. When null, the platform features are observed instead.
  final FAccessibility? data;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates an [FAccessibilityScope].
  const FAccessibilityScope({required this.child, this.data, super.key});

  @override
  State<FAccessibilityScope> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('data', data));
  }
}

class _State extends State<FAccessibilityScope> with WidgetsBindingObserver {
  static FAccessibility _platform() {
    final features = WidgetsBinding.instance.platformDispatcher.accessibilityFeatures;
    return FAccessibility(
      accessibleNavigation: features.accessibleNavigation,
      deterministicCursor: features.deterministicCursor,
      motion: features.disableAnimations
          ? .disabled
          : features.reduceMotion
          ? .reduced
          : .full,
      focusHighlight: FocusManager.instance.highlightMode == .traditional,
    );
  }

  late FAccessibility _current;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FocusManager.instance.addHighlightModeListener(_onHighlightModeChange);
    _current = _platform();
  }

  @override
  void didChangeAccessibilityFeatures() => _update();

  void _onHighlightModeChange(FocusHighlightMode _) => _update();

  void _update() {
    if (_platform() case final platform when platform != _current && widget.data == null) {
      setState(() => _current = platform);
    }
  }

  @override
  void dispose() {
    FocusManager.instance.removeHighlightModeListener(_onHighlightModeChange);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _Accessibility(data: widget.data ?? _current, child: widget.child);
}

/// Provides convenient access to the nearest [FAccessibility].
extension type FAccessibilityContext(BuildContext context) {
  /// {@macro forui.foundation.FAccessibility.accessibleNavigation}
  bool get accessibleNavigation => FAccessibilityScope.accessibleNavigationOf(context);

  /// {@macro forui.foundation.FAccessibility.deterministicCursor}
  bool get deterministicCursor => FAccessibilityScope.deterministicCursorOf(context);

  /// {@macro forui.foundation.FAccessibility.motion}
  FAccessibilityMotion get motion => FAccessibilityScope.motionOf(context);

  /// {@macro forui.foundation.FAccessibility.focusHighlight}
  bool get focusHighlight => FAccessibilityScope.focusHighlightOf(context);
}

class _Accessibility extends InheritedModel<_Aspect> {
  final FAccessibility data;

  const _Accessibility({required this.data, required super.child});

  @override
  bool updateShouldNotify(_Accessibility old) => data != old.data;

  @override
  bool updateShouldNotifyDependent(_Accessibility old, Set<_Aspect> dependencies) =>
      dependencies.contains(_Aspect.accessibleNavigation) &&
          data.accessibleNavigation != old.data.accessibleNavigation ||
      dependencies.contains(_Aspect.deterministicCursor) && data.deterministicCursor != old.data.deterministicCursor ||
      dependencies.contains(_Aspect.motion) && data.motion != old.data.motion ||
      dependencies.contains(_Aspect.focusHighlight) && data.focusHighlight != old.data.focusHighlight;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('data', data));
  }
}
