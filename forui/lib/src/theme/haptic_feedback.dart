import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

/// The haptic feedback configuration.
///
/// Each field corresponds to a static method on Flutter's [HapticFeedback] class and defaults to calling it. To disable
/// all haptic feedback, use [FHapticFeedback.none].
///
/// ```dart
/// // Disable all haptic feedback:
/// FHapticFeedback.none()
///
/// // Customize a specific effect:
/// FHapticFeedback(selectionClick: () async => debugPrint('click!'))
/// ```
final class FHapticFeedback with Diagnosticable {
  /// A no-op haptic feedback function.
  static Future<void> noFeedback() async {}

  /// Provides a haptic feedback corresponding to a collision impact with a heavy mass.
  ///
  /// Defaults to [HapticFeedback.heavyImpact].
  final Future<void> Function() heavyImpact;

  /// Provides a haptic feedback corresponding to a collision impact with a light mass.
  ///
  /// Defaults to [HapticFeedback.lightImpact].
  final Future<void> Function() lightImpact;

  /// Provides a haptic feedback corresponding to a collision impact with a medium mass.
  ///
  /// Defaults to [HapticFeedback.mediumImpact].
  final Future<void> Function() mediumImpact;

  /// Provides a haptic feedback corresponding to a UI selection tick.
  ///
  /// Defaults to [HapticFeedback.selectionClick].
  final Future<void> Function() selectionClick;

  /// Provides a haptic feedback indicating that a task or action has completed successfully.
  ///
  /// Defaults to [HapticFeedback.successNotification].
  final Future<void> Function() successNotification;

  /// Provides a haptic feedback indicating that a task or action has produced a warning.
  ///
  /// Defaults to [HapticFeedback.warningNotification].
  final Future<void> Function() warningNotification;

  /// Provides a haptic feedback indicating that a task or action has failed.
  ///
  /// Defaults to [HapticFeedback.errorNotification].
  final Future<void> Function() errorNotification;

  /// Provides vibration haptic feedback to the user.
  ///
  /// Defaults to [HapticFeedback.vibrate].
  final Future<void> Function() vibrate;

  /// Creates an [FHapticFeedback].
  const FHapticFeedback({
    this.heavyImpact = HapticFeedback.heavyImpact,
    this.lightImpact = HapticFeedback.lightImpact,
    this.mediumImpact = HapticFeedback.mediumImpact,
    this.selectionClick = HapticFeedback.selectionClick,
    this.successNotification = HapticFeedback.successNotification,
    this.warningNotification = HapticFeedback.warningNotification,
    this.errorNotification = HapticFeedback.errorNotification,
    this.vibrate = HapticFeedback.vibrate,
  });

  /// Creates an [FHapticFeedback] with no haptic feedback.
  const FHapticFeedback.none()
    : heavyImpact = noFeedback,
      lightImpact = noFeedback,
      mediumImpact = noFeedback,
      selectionClick = noFeedback,
      successNotification = noFeedback,
      warningNotification = noFeedback,
      errorNotification = noFeedback,
      vibrate = noFeedback;

  /// Returns a copy of this [FHapticFeedback] with the given properties replaced.
  @useResult
  FHapticFeedback copyWith({
    Future<void> Function()? heavyImpact,
    Future<void> Function()? lightImpact,
    Future<void> Function()? mediumImpact,
    Future<void> Function()? selectionClick,
    Future<void> Function()? successNotification,
    Future<void> Function()? warningNotification,
    Future<void> Function()? errorNotification,
    Future<void> Function()? vibrate,
  }) => FHapticFeedback(
    heavyImpact: heavyImpact ?? this.heavyImpact,
    lightImpact: lightImpact ?? this.lightImpact,
    mediumImpact: mediumImpact ?? this.mediumImpact,
    selectionClick: selectionClick ?? this.selectionClick,
    successNotification: successNotification ?? this.successNotification,
    warningNotification: warningNotification ?? this.warningNotification,
    errorNotification: errorNotification ?? this.errorNotification,
    vibrate: vibrate ?? this.vibrate,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('heavyImpact', heavyImpact))
      ..add(ObjectFlagProperty.has('lightImpact', lightImpact))
      ..add(ObjectFlagProperty.has('mediumImpact', mediumImpact))
      ..add(ObjectFlagProperty.has('selectionClick', selectionClick))
      ..add(ObjectFlagProperty.has('successNotification', successNotification))
      ..add(ObjectFlagProperty.has('warningNotification', warningNotification))
      ..add(ObjectFlagProperty.has('errorNotification', errorNotification))
      ..add(ObjectFlagProperty.has('vibrate', vibrate));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FHapticFeedback &&
          runtimeType == other.runtimeType &&
          heavyImpact == other.heavyImpact &&
          lightImpact == other.lightImpact &&
          mediumImpact == other.mediumImpact &&
          selectionClick == other.selectionClick &&
          successNotification == other.successNotification &&
          warningNotification == other.warningNotification &&
          errorNotification == other.errorNotification &&
          vibrate == other.vibrate;

  @override
  int get hashCode =>
      heavyImpact.hashCode ^
      lightImpact.hashCode ^
      mediumImpact.hashCode ^
      selectionClick.hashCode ^
      successNotification.hashCode ^
      warningNotification.hashCode ^
      errorNotification.hashCode ^
      vibrate.hashCode;
}
