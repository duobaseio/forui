import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// Represents a platform.
extension type const FPlatformVariant(FVariant _) implements FVariant {
  /// The Android platform variant.
  static const android = FPlatformVariant(.new('android'));

  /// The iOS platform variant.
  static const iOS = FPlatformVariant(.new('ios'));

  /// The Fuchsia platform variant.
  static const fuchsia = FPlatformVariant(.new('fuchsia'));

  /// The Windows platform variant.
  static const windows = FPlatformVariant(.new('windows'));

  /// The macOS platform variant.
  static const macOS = FPlatformVariant(.new('macos'));

  /// The Linux platform variant.
  static const linux = FPlatformVariant(.new('linux'));

  /// The web platform variant.
  static const web = FPlatformVariant(.new('web'));

  /// Whether the current platform is a primarily touch-based platform.
  ///
  /// This is not 100% accurate as there are hybrid devices that use both touch and keyboard/mouse input, e.g.,
  /// Windows Surface laptops.
  bool get touch => this == .iOS || this == .android || this == .fuchsia;

  /// Whether the current platform is a primarily keyboard/mouse-based platform.
  bool get desktop => this == .windows || this == .macOS || this == .linux;
}

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

/// Extension on [BuildContext] for accessing platform variants.
extension FAdaptiveBuildContext on BuildContext {
  /// Returns the current [FVariant].
  FPlatformVariant get platformVariant => FAdaptiveScope.of(this);
}
