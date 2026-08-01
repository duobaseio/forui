import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The icon tokens used by Forui's widgets. Defaults to icons in [FLucideIcons].
///
/// ## Customizing icons
/// To change the icons used by Forui widgets, pass a [FIcons] to [FThemeData].
///
/// Icons in [FIcons] should inherit their properties from the ambient [IconTheme]. Packages that represent icons as
/// [IconData] inherit automatically; use [FIcon.new] to wrap them.
///
/// For example, to use the in-built Material icons:
/// ```dart
/// FThemeData(
///   colors: FColors.neutralLight,
///   touch: false,
///   icons: FIcons(
///     arrowLeft: FIcon(Icons.arrow_left),
///     calendar: FIcon(Icons.calendar_month),
///     check: FIcon(Icons.check),
///     // ...
///   ),
/// );
/// ```
///
/// Packages with duotone or multi-color glyphs typically expose a custom icon widget instead. Implement [FIcon] to use
/// them, taking care to follow [FIcon]'s contract:
///
/// ```dart
/// class AwesomeIcon implements FIcon {
///   final IconDataBrands data;
///
///   const AwesomeIcon(this.data);
///
///   @override
///   Widget call(BuildContext context, {String? semanticsLabel}) =>
///       FaIcon(data, semanticLabel: semanticsLabel);
///
///   @override
///   bool operator ==(Object other) => identical(this, other) || other is AwesomeIcon && data == other.data;
///
///   @override
///   int get hashCode => data.hashCode;
/// }
/// ```
///
/// Known-compatible packages:
/// * `font_awesome_flutter`
/// * `hugeicons`
///
/// Icons that do not inherit from the ambient [IconTheme] (e.g. SVG-based packages) must read the data themselves. Wrap
/// the widget in a [Builder] so [IconTheme.of] is evaluated inside the caller's wrap:
///
/// ```dart
/// class SvgIcon implements FIcon {
///   final String asset;
///
///   const SvgIcon(this.asset);
///
///   @override
///   Widget call(BuildContext _, {String? semanticsLabel}) => Builder(
///     builder: (context) {
///       final data = IconTheme.of(context);
///       return SvgPicture.asset(
///         asset,
///         width: data.size,
///         height: data.size,
///         colorFilter: data.color == null ? null : ColorFilter.mode(data.color!, BlendMode.srcIn),
///         semanticsLabel: semanticsLabel,
///       );
///     },
///   );
///
///   @override
///   bool operator ==(Object other) => identical(this, other) || other is SvgIcon && asset == other.asset;
///
///   @override
///   int get hashCode => asset.hashCode;
/// }
/// ```
///
/// Run [`dart run forui theme create`](https://forui.dev/docs/reference/cli#create-2) to generate a custom theme.
final class FIcons with Diagnosticable {
  /// A left-pointing arrow.
  final FIcon arrowLeft;

  /// A calendar.
  final FIcon calendar;

  /// A check mark.
  final FIcon check;

  /// A downward-pointing chevron.
  final FIcon chevronDown;

  /// A left-pointing chevron.
  final FIcon chevronLeft;

  /// A right-pointing chevron.
  final FIcon chevronRight;

  /// An upward-pointing chevron.
  final FIcon chevronUp;

  /// A pair of vertically-stacked chevrons.
  final FIcon chevronsUpDown;

  /// An alert / warning indicator inside a circle.
  final FIcon circleAlert;

  /// A clock with a 4 o'clock indicator.
  final FIcon clock4;

  /// A horizontal ellipsis (three dots).
  final FIcon ellipsis;

  /// An alert used to denote errors such as form field validation failures.
  final FIcon error;

  /// An open eye.
  final FIcon eye;

  /// A closed eye.
  final FIcon eyeClosed;

  /// A horizontal grip handle.
  final FIcon gripHorizontal;

  /// A vertical grip handle.
  final FIcon gripVertical;

  /// A loading indicator (segments).
  final FIcon loader;

  /// A loading indicator (circular).
  final FIcon loaderCircle;

  /// A loading indicator (pinwheel).
  final FIcon loaderPinwheel;

  /// A search / magnifying glass.
  final FIcon search;

  /// A user silhouette in a circle.
  final FIcon userRound;

  /// An "x" / close mark.
  final FIcon x;

  /// Creates a [FIcons] with the given icons.
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
  const FIcons.lucide()
    : this(
        arrowLeft: const FIcon(FLucideIcons.arrowLeft),
        calendar: const FIcon(FLucideIcons.calendar),
        check: const FIcon(FLucideIcons.check),
        chevronDown: const FIcon(FLucideIcons.chevronDown),
        chevronLeft: const FIcon(FLucideIcons.chevronLeft),
        chevronRight: const FIcon(FLucideIcons.chevronRight),
        chevronUp: const FIcon(FLucideIcons.chevronUp),
        chevronsUpDown: const FIcon(FLucideIcons.chevronsUpDown),
        circleAlert: const FIcon(FLucideIcons.circleAlert),
        clock4: const FIcon(FLucideIcons.clock4),
        ellipsis: const FIcon(FLucideIcons.ellipsis),
        error: const FIcon(FLucideIcons.circleAlert),
        eye: const FIcon(FLucideIcons.eye),
        eyeClosed: const FIcon(FLucideIcons.eyeClosed),
        gripHorizontal: const FIcon(FLucideIcons.gripHorizontal),
        gripVertical: const FIcon(FLucideIcons.gripVertical),
        loader: const FIcon(FLucideIcons.loader),
        loaderCircle: const FIcon(FLucideIcons.loaderCircle),
        loaderPinwheel: const FIcon(FLucideIcons.loaderPinwheel),
        search: const FIcon(FLucideIcons.search),
        userRound: const FIcon(FLucideIcons.userRound),
        x: const FIcon(FLucideIcons.x),
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FIcons &&
          runtimeType == other.runtimeType &&
          arrowLeft == other.arrowLeft &&
          calendar == other.calendar &&
          check == other.check &&
          chevronDown == other.chevronDown &&
          chevronLeft == other.chevronLeft &&
          chevronRight == other.chevronRight &&
          chevronUp == other.chevronUp &&
          chevronsUpDown == other.chevronsUpDown &&
          circleAlert == other.circleAlert &&
          clock4 == other.clock4 &&
          ellipsis == other.ellipsis &&
          error == other.error &&
          eye == other.eye &&
          eyeClosed == other.eyeClosed &&
          gripHorizontal == other.gripHorizontal &&
          gripVertical == other.gripVertical &&
          loader == other.loader &&
          loaderCircle == other.loaderCircle &&
          loaderPinwheel == other.loaderPinwheel &&
          search == other.search &&
          userRound == other.userRound &&
          x == other.x;

  @override
  int get hashCode => Object.hashAll([
    arrowLeft,
    calendar,
    check,
    chevronDown,
    chevronLeft,
    chevronRight,
    chevronUp,
    chevronsUpDown,
    circleAlert,
    clock4,
    ellipsis,
    error,
    eye,
    eyeClosed,
    gripHorizontal,
    gripVertical,
    loader,
    loaderCircle,
    loaderPinwheel,
    search,
    userRound,
    x,
  ]);
}

/// An icon that is used by Forui widgets.
///
/// ## Contract
/// Subclasses should implement [==] and [hashCode] so that two icons that render the same glyph are equal. Not doing so
/// may cause widgets to "flicker" whenever the same [FThemeData] is recreated.
// ignore: one_member_abstracts
abstract interface class FIcon {
  /// Creates an [FIcon] with the given [IconData].
  const factory FIcon(IconData icon) = _Icon;

  /// Builds an icon given a [BuildContext].
  ///
  /// The icon inherits its size/color from the ambient [IconTheme].
  Widget call(BuildContext context, {String? semanticsLabel});
}

class _Icon implements FIcon {
  final IconData icon;

  const _Icon(this.icon);

  @override
  Widget call(BuildContext context, {String? semanticsLabel}) => Icon(icon, semanticLabel: semanticsLabel);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Icon && runtimeType == other.runtimeType && icon == other.icon;

  @override
  int get hashCode => icon.hashCode;
}
