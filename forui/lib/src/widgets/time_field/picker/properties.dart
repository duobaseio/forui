import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

@internal
class const FTimeFieldPickerProperties({
  /// The alignment point on the picker popover. Defaults to [Alignment.topLeft].
  final AlignmentGeometry anchor = .topLeft,

  /// The alignment point on the field. Defaults to [Alignment.bottomLeft].
  final AlignmentGeometry fieldAnchor = .bottomLeft,

  /// The constraints to apply to the picker popover. Defaults to `const FPortalConstraints(maxWidth: 200, maxHeight: 200)`.
  final FPortalConstraints constraints = const FPortalConstraints(maxWidth: 200, maxHeight: 200),

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing spacing = const .spacing(4),

  /// {@macro forui.widgets.FPopover.overflow}
  final FPortalOverflow overflow = .flip,

  /// {@macro forui.foundation.FPortal.useViewPadding}
  ///
  /// Defaults to true.
  final bool useViewPadding = true,

  /// {@macro forui.foundation.FPortal.useViewInsets}
  ///
  /// Defaults to true.
  final bool useViewInsets = true,

  /// {@macro forui.foundation.FPortal.overlayLocation}
  ///
  /// Defaults to [OverlayChildLocation.nearestOverlay].
  final OverlayChildLocation overlayLocation = .nearestOverlay,

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset = .zero,

  /// {@macro forui.widgets.FPopover.hideRegion}
  ///
  /// Defaults to [FPopoverHideRegion.excludeChild].
  ///
  /// Setting [hideRegion] to [FPopoverHideRegion.anywhere] may result in the calendar disappearing and reappearing
  /// when pressing and holding the field, due to the popover being hidden and then immediately shown again.
  final FPopoverHideRegion hideRegion = .excludeChild,

  /// {@macro forui.widgets.FPopover.groupId}
  final Object? groupId,

  /// Callback that is called when the time picker is tapped to hide it.
  final VoidCallback? onTapHide,

  /// {@macro forui.widgets.FPopover.cutout}
  final bool cutout = true,

  /// {@macro forui.widgets.FPopover.cutoutBuilder}
  final void Function(Path path, Rect bounds) cutoutBuilder = FModalBarrier.defaultCutoutBuilder,

  /// The builder used to wrap the time picker popover content.
  final FTimeFieldPopoverBuilder popoverBuilder = FPopover.defaultPopoverBuilder,

  /// The interval between hours shown in the time picker. Defaults to 1.
  ///
  /// For example, setting this to 6 will show hours like 0, 6, 12, and 18.
  final int hourInterval = 1,

  /// The interval between minutes shown in the time picker. Defaults to 1.
  ///
  /// For example, setting this to 15 will show minutes like 0, 15, 30, and 45.
  final int minuteInterval = 1,
}) with Diagnosticable {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DiagnosticsProperty('fieldAnchor', fieldAnchor))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(FlagProperty('useViewPadding', value: useViewPadding, ifTrue: 'using view padding'))
      ..add(FlagProperty('useViewInsets', value: useViewInsets, ifTrue: 'using view insets'))
      ..add(EnumProperty('overlayLocation', overlayLocation))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(FlagProperty('cutout', value: cutout, ifTrue: 'cutout'))
      ..add(ObjectFlagProperty.has('cutoutBuilder', cutoutBuilder))
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder))
      ..add(IntProperty('hourInterval', hourInterval))
      ..add(IntProperty('minuteInterval', minuteInterval));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTimeFieldPickerProperties &&
          runtimeType == other.runtimeType &&
          anchor == other.anchor &&
          fieldAnchor == other.fieldAnchor &&
          constraints == other.constraints &&
          spacing == other.spacing &&
          overflow == other.overflow &&
          useViewPadding == other.useViewPadding &&
          useViewInsets == other.useViewInsets &&
          overlayLocation == other.overlayLocation &&
          offset == other.offset &&
          hideRegion == other.hideRegion &&
          groupId == other.groupId &&
          onTapHide == other.onTapHide &&
          cutout == other.cutout &&
          cutoutBuilder == other.cutoutBuilder &&
          popoverBuilder == other.popoverBuilder &&
          hourInterval == other.hourInterval &&
          minuteInterval == other.minuteInterval;

  @override
  int get hashCode =>
      anchor.hashCode ^
      fieldAnchor.hashCode ^
      constraints.hashCode ^
      spacing.hashCode ^
      overflow.hashCode ^
      useViewPadding.hashCode ^
      useViewInsets.hashCode ^
      overlayLocation.hashCode ^
      offset.hashCode ^
      hideRegion.hashCode ^
      groupId.hashCode ^
      onTapHide.hashCode ^
      cutout.hashCode ^
      cutoutBuilder.hashCode ^
      popoverBuilder.hashCode ^
      hourInterval.hashCode ^
      minuteInterval.hashCode;
}
