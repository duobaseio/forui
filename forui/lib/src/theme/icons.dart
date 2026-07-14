import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// Builds an icon given a [BuildContext]. The icon inherits its size/color from the ambient [IconTheme]; callers
/// should wrap the builder's result in an [IconTheme] with the desired [IconThemeData].
typedef FIconBuilder = Widget Function(BuildContext context, {String? semanticsLabel});

/// The icon tokens used by Forui's widgets. Defaults to icons in [FLucideIcons].
///
/// ## Customizing icons
/// To change the icons used by Forui widgets, pass a [FIcons] to [FThemeData].
///
/// Icons in [FIcons] should inherit their properties from the ambient [IconTheme]. Packages that represent icons as
/// [IconData] inherit automatically; use [iconData] to wrap them.
///
/// For example, to use the in-built Material icons:
/// ```dart
/// FThemeData(
///   colors: FColors.neutralLight,
///   touch: false,
///   icons: FIcons(
///     arrowLeft: FIcons.iconData(Icons.arrow_left),
///     calendar: FIcons.iconData(Icons.calendar_month),
///     check: FIcons.iconData(Icons.check),
///     // ...
///   ),
/// );
/// ```
///
/// Packages with duotone or multi-color glyphs typically expose a custom icon widget instead. As long as the widget
/// inherits from the ambient [IconTheme], you can pass it directly.
///
/// Known-compatible packages:
/// * `font_awesome_flutter`
/// * `hugeicons`
///
/// Custom widgets that do not inherit from the ambient [IconTheme] (e.g. SVG-based packages) must read the data
/// themselves. Wrap the callback in a [Builder] so [IconTheme.of] is evaluated inside the caller's wrap:
///
/// ```dart
/// FThemeData(
///   colors: FColors.neutralLight,
///   touch: false,
///   icons: FIcons(
///     arrowLeft: (_, {semanticsLabel}) => Builder(builder: (context) {
///       final data = IconTheme.of(context);
///       return SvgPicture.asset(
///         'assets/arrow_left.svg',
///         width: data.size,
///         height: data.size,
///         colorFilter: data.color == null ? null : ColorFilter.mode(data.color!, BlendMode.srcIn),
///         semanticsLabel: semanticsLabel,
///       );
///     }),
///     // ...
///   ),
/// );
/// ```
///
/// Run [`dart run forui theme create`](https://forui.dev/docs/reference/cli#create-2) to generate a custom theme.
final class FIcons with Diagnosticable {
  /// A builder that renders the given [IconData] as a Flutter [Icon].
  static FIconBuilder iconData(IconData icon) =>
      (_, {semanticsLabel}) => Icon(icon, semanticLabel: semanticsLabel);

  /// A left-pointing arrow.
  final FIconBuilder arrowLeft;

  /// A calendar.
  final FIconBuilder calendar;

  /// A check mark.
  final FIconBuilder check;

  /// A downward-pointing chevron.
  final FIconBuilder chevronDown;

  /// A left-pointing chevron.
  final FIconBuilder chevronLeft;

  /// A right-pointing chevron.
  final FIconBuilder chevronRight;

  /// An upward-pointing chevron.
  final FIconBuilder chevronUp;

  /// A pair of vertically-stacked chevrons.
  final FIconBuilder chevronsUpDown;

  /// An alert / warning indicator inside a circle.
  final FIconBuilder circleAlert;

  /// A clock with a 4 o'clock indicator.
  final FIconBuilder clock4;

  /// A horizontal ellipsis (three dots).
  final FIconBuilder ellipsis;

  /// An alert used to denote errors such as form field validation failures.
  final FIconBuilder error;

  /// An open eye.
  final FIconBuilder eye;

  /// A closed eye.
  final FIconBuilder eyeClosed;

  /// A horizontal grip handle.
  final FIconBuilder gripHorizontal;

  /// A vertical grip handle.
  final FIconBuilder gripVertical;

  /// A loading indicator (segments).
  final FIconBuilder loader;

  /// A loading indicator (circular).
  final FIconBuilder loaderCircle;

  /// A loading indicator (pinwheel).
  final FIconBuilder loaderPinwheel;

  /// A search / magnifying glass.
  final FIconBuilder search;

  /// A user silhouette in a circle.
  final FIconBuilder userRound;

  /// An "x" / close mark.
  final FIconBuilder x;

  /// Creates a [FIcons] with the given builders.
  const FIcons({
    required this.arrowLeft,
    required this.calendar,
    required this.check,
    required this.chevronDown,
    required this.chevronLeft,
    required this.chevronRight,
    required this.chevronUp,
    required this.chevronsUpDown,
    required this.circleAlert,
    required this.clock4,
    required this.ellipsis,
    required this.error,
    required this.eye,
    required this.eyeClosed,
    required this.gripHorizontal,
    required this.gripVertical,
    required this.loader,
    required this.loaderCircle,
    required this.loaderPinwheel,
    required this.search,
    required this.userRound,
    required this.x,
  });

  /// Creates a [FIcons] backed by [FLucideIcons] defaults.
  FIcons.lucide()
    : this(
        arrowLeft: iconData(FLucideIcons.arrowLeft),
        calendar: iconData(FLucideIcons.calendar),
        check: iconData(FLucideIcons.check),
        chevronDown: iconData(FLucideIcons.chevronDown),
        chevronLeft: iconData(FLucideIcons.chevronLeft),
        chevronRight: iconData(FLucideIcons.chevronRight),
        chevronUp: iconData(FLucideIcons.chevronUp),
        chevronsUpDown: iconData(FLucideIcons.chevronsUpDown),
        circleAlert: iconData(FLucideIcons.circleAlert),
        clock4: iconData(FLucideIcons.clock4),
        ellipsis: iconData(FLucideIcons.ellipsis),
        error: iconData(FLucideIcons.circleAlert),
        eye: iconData(FLucideIcons.eye),
        eyeClosed: iconData(FLucideIcons.eyeClosed),
        gripHorizontal: iconData(FLucideIcons.gripHorizontal),
        gripVertical: iconData(FLucideIcons.gripVertical),
        loader: iconData(FLucideIcons.loader),
        loaderCircle: iconData(FLucideIcons.loaderCircle),
        loaderPinwheel: iconData(FLucideIcons.loaderPinwheel),
        search: iconData(FLucideIcons.search),
        userRound: iconData(FLucideIcons.userRound),
        x: iconData(FLucideIcons.x),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('arrowLeft', arrowLeft))
      ..add(ObjectFlagProperty.has('calendar', calendar))
      ..add(ObjectFlagProperty.has('check', check))
      ..add(ObjectFlagProperty.has('chevronDown', chevronDown))
      ..add(ObjectFlagProperty.has('chevronLeft', chevronLeft))
      ..add(ObjectFlagProperty.has('chevronRight', chevronRight))
      ..add(ObjectFlagProperty.has('chevronUp', chevronUp))
      ..add(ObjectFlagProperty.has('chevronsUpDown', chevronsUpDown))
      ..add(ObjectFlagProperty.has('circleAlert', circleAlert))
      ..add(ObjectFlagProperty.has('clock4', clock4))
      ..add(ObjectFlagProperty.has('ellipsis', ellipsis))
      ..add(ObjectFlagProperty.has('error', error))
      ..add(ObjectFlagProperty.has('eye', eye))
      ..add(ObjectFlagProperty.has('eyeClosed', eyeClosed))
      ..add(ObjectFlagProperty.has('gripHorizontal', gripHorizontal))
      ..add(ObjectFlagProperty.has('gripVertical', gripVertical))
      ..add(ObjectFlagProperty.has('loader', loader))
      ..add(ObjectFlagProperty.has('loaderCircle', loaderCircle))
      ..add(ObjectFlagProperty.has('loaderPinwheel', loaderPinwheel))
      ..add(ObjectFlagProperty.has('search', search))
      ..add(ObjectFlagProperty.has('userRound', userRound))
      ..add(ObjectFlagProperty.has('x', x));
  }
}
