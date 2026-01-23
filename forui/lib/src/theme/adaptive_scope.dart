import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

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
  bool updateShouldNotify(FAdaptiveScope old) => platform != old.platform;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('platform', platform));
  }
}

/// Provides functions for accessing the current platform variant.
extension FAdaptiveBuildContext on BuildContext {
  /// Returns the current [FVariant].
  FPlatformVariant get platformVariant => FAdaptiveScope.of(this);
}
