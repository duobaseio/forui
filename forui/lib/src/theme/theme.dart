import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'theme.design.dart';

/// Applies a theme to descendant widgets with animated transitions over a given duration whenever the provided
/// [FThemeData] changes.
///
/// A theme configures the colors and typographic choices of Forui widgets. The actual configuration is stored in
/// a [FThemeData]. Descendant widgets obtain the current theme's [FThemeData] via either [FThemeBuildContext.theme],
/// or [FTheme.of]. When a widget uses either, it is automatically rebuilt if the theme later changes.
///
/// ```dart
/// class Parent extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) => FTheme(
///      data: FThemes.neutral.light,
///      child: Child(),
///    );
///  }
///
///  class Child extends StatelessWidget {
///    @override
///    Widget build(BuildContext context) {
///      final FThemeData theme = context.theme;
///      final FThemeData sameTheme = FTheme.of(context);
///
///      return const Placeholder();
///    }
///  }
/// ```
///
/// See:
/// * [FBasicTheme], the non-animated theme widget wrapped by this widget.
/// * [FThemeDataMixin] which describes a dynamic theme that can resolve to different [FThemeData] based on brightness
///    and platform variant.
/// * [FThemeData] which describes the actual configuration of a theme.
class FTheme extends StatelessWidget {
  /// Returns the current [FThemeData], or `FThemes.neutral.light.touch` if there is no ancestor [FTheme].
  ///
  /// It is recommended to use the terser [FThemeBuildContext.theme] getter instead.
  ///
  /// ## Troubleshooting:
  ///
  /// ### [FTheme.of] always returns `FThemes.neutral.light.touch`
  ///
  /// One of the most common causes is calling [FTheme.of] in the same context which [FTheme] was declared. To fix this,
  /// move the call to [FTheme.of] to a descendant widget.
  ///
  /// ✅ Do:
  /// ```dart
  /// class Parent extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) => FTheme(
  ///      data: FThemes.neutral.light,
  ///      child: Child(),
  ///    );
  ///  }
  ///
  ///  class Child extends StatelessWidget {
  ///    @override
  ///    Widget build(BuildContext context) {
  ///      final FThemeData theme = FTheme.of(context);
  ///      return const SomeWidget(theme: theme);
  ///    }
  ///  }
  /// ```
  ///
  /// ❌ Do not:
  /// ```dart
  /// class Parent extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) => FTheme(
  ///      data: FThemes.neutral.light,
  ///      child: SomeWidget(
  ///        theme: FTheme.of(context), // Whoops!
  ///      ),
  ///    );
  ///  }
  /// ```
  @useResult
  static FThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return theme?.data ?? FThemes.neutral.light.touch;
  }

  /// Motion-related properties for the animation.
  final FThemeMotion motion;

  /// The theme.
  ///
  /// An [FAutoThemeData] automatically resolves to light or dark based on [brightness]:
  /// ```dart
  /// FTheme(
  ///   data: FThemes.neutral, // Resolves based on the platform's brightness.
  ///   child: Child(),
  /// );
  /// ```
  ///
  /// A [FThemeData] ignores [brightness] and [platform]:
  /// ```dart
  /// FTheme(
  ///   data: FThemes.neutral.light.touch, // Always light and touch-optimized.
  ///   child: Child(),
  /// );
  /// ```
  final FThemeDataMixin data;

  /// The text direction. Defaults to the text direction inherited from its nearest ancestor.
  final TextDirection? textDirection;

  /// The theme's brightness. Defaults to the current platform's brightness.
  ///
  /// ## Troubleshooting:
  ///
  /// ### Theme does not change with brightness
  ///
  /// One of the most common cause is passing a pre-resolved theme, e.g. `FThemes.neutral.light`. To fix this, pass a
  /// [FAutoThemeData] or brightness-aware theme such as [FThemes.neutral].
  ///
  /// ✅ Do:
  /// ```dart
  /// FTheme(
  ///   data: FThemes.neutral, // Resolves to light or dark based on the platform's brightness.
  ///   child: Child(),
  /// );
  /// ```
  ///
  /// ❌ Do not:
  /// ```dart
  /// FTheme(
  ///   data: FThemes.neutral.light, // Always light, ignores the platform's brightness
  ///   child: Child(),
  /// );
  /// ```
  final Brightness? brightness;

  /// The platform variant. Defaults to the current platform.
  final FPlatformVariant? platform;

  /// Called every time an animation completes.
  final VoidCallback? onEnd;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates an animated theme.
  const FTheme({
    required this.data,
    required this.child,
    this.textDirection,
    this.brightness,
    this.platform,
    this.motion = const FThemeMotion(),
    this.onEnd,
    super.key,
  });

  @override
  Widget build(BuildContext context) => _AnimatedTheme(
    // This isn't technically correct since there is not [FAdaptiveScope] above this widget but it is better than
    // forcing users to wrap their [FTheme] in an [FAdaptiveScope].
    data: data.resolve(brightness ?? MediaQuery.platformBrightnessOf(context), platform ?? context.platformVariant),
    textDirection: textDirection ?? Directionality.maybeOf(context) ?? .ltr,
    platform: platform,
    motion: motion,
    onEnd: onEnd,
    child: child,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('motion', motion))
      ..add(DiagnosticsProperty('data', data))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(EnumProperty('brightness', brightness))
      ..add(DiagnosticsProperty('platform', platform))
      ..add(ObjectFlagProperty.has('onEnd', onEnd));
  }
}

class _AnimatedTheme extends ImplicitlyAnimatedWidget {
  final FThemeData data;
  final TextDirection textDirection;
  final FPlatformVariant? platform;
  final Widget child;

  _AnimatedTheme({
    required this.data,
    required this.textDirection,
    required this.child,
    this.platform,
    FThemeMotion motion = const FThemeMotion(),
    super.onEnd,
  }) : super(duration: motion.duration, curve: motion.curve);

  @override
  AnimatedWidgetBaseState<_AnimatedTheme> createState() => _AnimatedThemeState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('data', data))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(DiagnosticsProperty('platform', platform));
  }
}

class _AnimatedThemeState extends AnimatedWidgetBaseState<_AnimatedTheme> {
  _Tween? _tween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween = visitor(_tween, widget.data, (value) => _Tween(begin: value as FThemeData))! as _Tween;
  }

  @override
  Widget build(BuildContext context) => FBasicTheme(
    data: _tween!.evaluate(animation),
    textDirection: widget.textDirection,
    platform: widget.platform,
    child: widget.child,
  );
}

class _Tween extends Tween<FThemeData> {
  _Tween({super.begin});

  @override
  FThemeData lerp(double t) => FThemeData.lerp(begin!, end!, t);
}

/// The motion-related properties for [FTheme].
class FThemeMotion with Diagnosticable, _$FThemeMotionFunctions {
  /// The animation's duration. Defaults to 200 milliseconds.
  @override
  final Duration duration;

  /// The animation's curve. Defaults to [Curves.linear].
  ///
  /// We recommend [Curves.linear], especially if only the theme's colors are changing.
  /// See https://pow.rs/blog/animation-easings/ for more information.
  @override
  final Curve curve;

  /// Creates a [FThemeMotion].
  const FThemeMotion({this.duration = const Duration(milliseconds: 200), this.curve = Curves.linear});
}

/// Provides functions for accessing the current [FThemeData].
extension FThemeBuildContext on BuildContext {
  /// Returns the current [FThemeData], or `FThemes.neutral.light.touch` if there is no ancestor [FTheme].
  ///
  /// ## Troubleshooting:
  ///
  /// ### [theme] always returns `FThemes.neutral.light.touch`
  ///
  /// One of the most common causes is calling [theme] in the same context which [FTheme] was declared. To fix this,
  /// move the call to [theme] to a descendant widget.
  ///
  /// ✅ Do:
  /// ```dart
  /// class Parent extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) => FTheme(
  ///      data: FThemes.neutral.light,
  ///      child: Child(),
  ///    );
  ///  }
  ///
  ///  class Child extends StatelessWidget {
  ///    @override
  ///    Widget build(BuildContext context) {
  ///      final FThemeData theme = context.theme;
  ///      return const SomeWidget(theme: theme);
  ///    }
  ///  }
  /// ```
  ///
  /// ❌ Do not:
  /// ```dart
  /// class Parent extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) => FTheme(
  ///      data: FThemes.neutral.light,
  ///      child: SomeWidget(
  ///        theme: context.theme, // Whoops!
  ///      ),
  ///    );
  ///  }
  /// ```
  FThemeData get theme => FTheme.of(this);
}

/// Applies a theme to descendant widgets.
///
/// See:
/// * [FTheme] which is an animated version of this widget.
/// * [FThemeDataMixin] which describes a dynamic theme that can resolve to different [FThemeData] based on brightness
///    and platform variant.
/// * [FThemeData] which describes the actual configuration of a theme.
class FBasicTheme extends StatelessWidget {
  /// The color and typography values for descendant Forui widgets.
  ///
  /// An [FAutoThemeData] automatically resolves to light or dark based on [brightness]:
  /// ```dart
  /// FBasicTheme(
  ///   data: FThemes.neutral, // Resolves based on the platform's brightness.
  ///   child: Child(),
  /// );
  /// ```
  ///
  /// A [FThemeData] ignores [brightness] and [platform]:
  /// ```dart
  /// FBasicTheme(
  ///   data: FThemes.neutral.light.touch, // Always light and touch-optimized.
  ///   child: Child(),
  /// );
  /// ```
  final FThemeDataMixin data;

  /// The text direction. Defaults to the text direction inherited from its nearest ancestor.
  final TextDirection? textDirection;

  /// The theme's brightness. Defaults to the current platform's brightness.
  ///
  /// ## Troubleshooting:
  ///
  /// ### Theme does not change with brightness
  ///
  /// One of the most common cause is passing a pre-resolved theme, e.g. `FThemes.neutral.light`. To fix this, pass a
  /// [FAutoThemeData] or brightness-aware theme such as [FThemes.neutral].
  ///
  /// ✅ Do:
  /// ```dart
  /// FBasicTheme(
  ///   data: FThemes.neutral, // Resolves to light or dark based on the platform's brightness.
  ///   child: Child(),
  /// );
  /// ```
  ///
  /// ❌ Do not:
  /// ```dart
  /// FBasicTheme(
  ///   data: FThemes.neutral.light, // Always light, ignores the platform's brightness
  ///   child: Child(),
  /// );
  /// ```
  final Brightness? brightness;

  /// The platform variant. Defaults to the current platform.
  final FPlatformVariant? platform;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates a [FTheme] that applies [data] to all descendant widgets in [child].
  const FBasicTheme({
    required this.data,
    required this.child,
    this.textDirection,
    this.brightness,
    this.platform,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FAdaptiveScope(
    platform: platform,
    child: Builder(
      builder: (context) {
        final data = this.data.resolve(brightness ?? MediaQuery.platformBrightnessOf(context), context.platformVariant);
        return _InheritedTheme(
          data: data,
          child: Directionality(
            textDirection: textDirection ?? Directionality.maybeOf(context) ?? .ltr,
            child: DefaultTextStyle(
              style: data.typography.sm.copyWith(
                fontFamily: data.typography.defaultFontFamily,
                color: data.colors.foreground,
              ),
              child: child,
            ),
          ),
        );
      },
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('data', data, showName: false))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(EnumProperty('brightness', brightness))
      ..add(DiagnosticsProperty('platform', platform));
  }
}

class _InheritedTheme extends InheritedTheme {
  final FThemeData data;

  const _InheritedTheme({required this.data, required super.child});

  @override
  Widget wrap(BuildContext context, Widget child) => _InheritedTheme(data: data, child: child);

  @override
  bool updateShouldNotify(covariant _InheritedTheme old) => data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('data', data));
  }
}
