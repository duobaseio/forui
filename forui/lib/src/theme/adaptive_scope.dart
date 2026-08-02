import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// Provides the current platform variant down the widget tree.
///
/// [FTheme] includes an [FAdaptiveScope] by default.
///
/// ```dart
/// FAdaptiveScope(
///   platform: FPlatformVariant.ios, // Force iOS styling
///   child: MyWidget(),
/// )
/// ```
class FAdaptiveScope extends InheritedWidget {
  /// Returns the current [FPlatformVariant].
  @useResult
  static FPlatformVariant of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FAdaptiveScope>()?.platform ?? _platform;

  static FPlatformVariant get _platform {
    if (kIsWeb) {
      return .web;
    }

    return switch (defaultTargetPlatform) {
      .android => .android,
      .iOS => .iOS,
      .fuchsia => .fuchsia,
      .windows => .windows,
      .macOS => .macOS,
      .linux => .linux,
    };
  }

  /// The platform variant. Defaults to the current platform.
  final FPlatformVariant platform;

  /// Creates an [FAdaptiveScope].
  FAdaptiveScope({required super.child, FPlatformVariant? platform, super.key}) : platform = platform ?? _platform;

  @override
  InheritedElement createElement() => AdaptiveScopeElement(this);

  @override
  bool updateShouldNotify(FAdaptiveScope old) => platform != old.platform;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('platform', platform));
  }
}

@internal
class AdaptiveScopeElement extends InheritedElement {
  static ValueListenable<FPlatformVariant>? of(BuildContext context) =>
      (context.getElementForInheritedWidgetOfExactType<FAdaptiveScope>() as AdaptiveScopeElement?)?.notifier;

  final ValueNotifier<FPlatformVariant> notifier;

  AdaptiveScopeElement(FAdaptiveScope super.widget) : notifier = ValueNotifier(widget.platform);

  @override
  void update(covariant FAdaptiveScope current) {
    notifier.value = current.platform;
    super.update(current);
  }

  @override
  void unmount() {
    notifier.dispose();
    super.unmount();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('notifier', notifier));
  }
}
