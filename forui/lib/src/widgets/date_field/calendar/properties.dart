import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A date field calendar popover's properties.
///
/// The calendar mode is chosen by the subclass:
/// * [FDateFieldGridCalendarProperties] for a calendar that cycles through the day, month and year grid pickers.
/// * [FDateFieldGridSplitCalendarProperties] for a calendar with a split header whose month and year grid pickers are
///   independently togglable.
/// * [FDateFieldWheelCalendarProperties] for a calendar that toggles between a day grid and a month-year wheel.
sealed class FDateFieldCalendarProperties with Diagnosticable {
  /// The alignment point on the calendar popover. Defaults to [Alignment.topLeft].
  final AlignmentGeometry anchor;

  /// The alignment point on the field. Defaults to [Alignment.bottomLeft].
  final AlignmentGeometry fieldAnchor;

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing spacing;

  /// {@macro forui.widgets.FPopover.overflow}
  final FPortalOverflow overflow;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset;

  /// {@macro forui.foundation.FPortal.useViewPadding}
  ///
  /// Defaults to true.
  final bool useViewPadding;

  /// {@macro forui.foundation.FPortal.useViewInsets}
  ///
  /// Defaults to true.
  final bool useViewInsets;

  /// {@macro forui.widgets.FPopover.hideRegion}
  ///
  /// Defaults to [FPopoverHideRegion.excludeChild].
  ///
  /// Setting [hideRegion] to [FPopoverHideRegion.anywhere] may result in the calendar disappearing and reappearing
  /// when pressing and holding the field, due to the popover being hidden and then immediately shown again.
  final FPopoverHideRegion hideRegion;

  /// {@macro forui.widgets.FPopover.groupId}
  final Object? groupId;

  /// {@macro forui.widgets.FPopover.onTapHide}
  ///
  /// This is only called if [hideRegion] is set to [FPopoverHideRegion.anywhere] or [FPopoverHideRegion.excludeChild].
  final VoidCallback? onTapHide;

  /// {@macro forui.widgets.FPopover.cutout}
  final bool cutout;

  /// {@macro forui.widgets.FPopover.cutoutBuilder}
  final void Function(Path path, Rect bounds) cutoutBuilder;

  /// The builder used to wrap the calendar popover content.
  final FDateFieldPopoverBuilder popoverBuilder;

  /// True if the calendar popover should be automatically hidden after a date is selected. Defaults to true.
  final bool autoHide;

  const FDateFieldCalendarProperties._({
    this.anchor = .topLeft,
    this.fieldAnchor = .bottomLeft,
    this.spacing = const .spacing(4),
    this.overflow = .flip,
    this.offset = .zero,
    this.useViewPadding = true,
    this.useViewInsets = true,
    this.hideRegion = .excludeChild,
    this.groupId,
    this.onTapHide,
    this.cutout = true,
    this.cutoutBuilder = FModalBarrier.defaultCutoutBuilder,
    this.popoverBuilder = FPopover.defaultPopoverBuilder,
    this.autoHide = true,
  });

  /// The control for the calendar's navigation.
  FCalendarControl get control;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('control', control))
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DiagnosticsProperty('fieldAnchor', fieldAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(FlagProperty('useViewPadding', value: useViewPadding, ifTrue: 'using view padding'))
      ..add(FlagProperty('useViewInsets', value: useViewInsets, ifTrue: 'using view insets'))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(FlagProperty('cutout', value: cutout, ifTrue: 'cutout'))
      ..add(ObjectFlagProperty.has('cutoutBuilder', cutoutBuilder))
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder))
      ..add(FlagProperty('autoHide', value: autoHide, ifTrue: 'autoHide'));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDateFieldCalendarProperties &&
          runtimeType == other.runtimeType &&
          control == other.control &&
          anchor == other.anchor &&
          fieldAnchor == other.fieldAnchor &&
          spacing == other.spacing &&
          overflow == other.overflow &&
          offset == other.offset &&
          useViewPadding == other.useViewPadding &&
          useViewInsets == other.useViewInsets &&
          hideRegion == other.hideRegion &&
          groupId == other.groupId &&
          onTapHide == other.onTapHide &&
          cutout == other.cutout &&
          cutoutBuilder == other.cutoutBuilder &&
          popoverBuilder == other.popoverBuilder &&
          autoHide == other.autoHide;

  @override
  int get hashCode =>
      control.hashCode ^
      anchor.hashCode ^
      fieldAnchor.hashCode ^
      spacing.hashCode ^
      overflow.hashCode ^
      offset.hashCode ^
      useViewPadding.hashCode ^
      useViewInsets.hashCode ^
      hideRegion.hashCode ^
      groupId.hashCode ^
      onTapHide.hashCode ^
      cutout.hashCode ^
      cutoutBuilder.hashCode ^
      popoverBuilder.hashCode ^
      autoHide.hashCode;
}

/// A date field calendar that cycles through the day, month and year grid pickers. Mirrors [FCalendar.grid].
class FDateFieldGridCalendarProperties extends FDateFieldCalendarProperties {
  /// The control for the calendar's navigation.
  @override
  final FGridCalendarControl control;

  /// The day picker's scroll physics.
  final ScrollPhysics? dayScrollPhysics;

  /// {@macro forui.foundation.doc_templates.scrollCacheExtent}
  final ScrollCacheExtent? dayScrollCacheExtent;

  /// The day picker's scroll behavior.
  final ScrollBehavior? dayScrollBehavior;

  /// The month picker's scroll physics.
  final ScrollPhysics? monthScrollPhysics;

  /// {@macro forui.foundation.doc_templates.scrollCacheExtent}
  final ScrollCacheExtent? monthScrollCacheExtent;

  /// The month picker's scroll behavior.
  final ScrollBehavior? monthScrollBehavior;

  /// The year picker's scroll physics.
  final ScrollPhysics? yearScrollPhysics;

  /// {@macro forui.foundation.doc_templates.scrollCacheExtent}
  final ScrollCacheExtent? yearScrollCacheExtent;

  /// The year picker's scroll behavior.
  final ScrollBehavior? yearScrollBehavior;

  /// Builds the calendar's header.
  final FCalendarHeaderBuilder<FGridCalendarController> headerBuilder;

  /// Builds the calendar's footer.
  final FCalendarFooterBuilder<FGridCalendarController> footerBuilder;

  /// Customizes the appearance of calendar days. Defaults to [FCalendar.defaultDayBuilder].
  final FCalendarDayBuilder dayBuilder;

  /// Customizes the appearance of calendar months. Defaults to [FCalendar.defaultMonthBuilder].
  final FCalendarMonthBuilder monthBuilder;

  /// Customizes the appearance of calendar years. Defaults to [FCalendar.defaultYearBuilder].
  final FCalendarYearBuilder yearBuilder;

  /// A callback for when a date is pressed.
  final FutureOr<void> Function(DateTime)? onDayPress;

  /// A callback for when a date is long pressed.
  final FutureOr<void> Function(DateTime)? onDayLongPress;

  /// Creates a [FDateFieldGridCalendarProperties].
  const FDateFieldGridCalendarProperties({
    this.control = const FGridCalendarControl(),
    this.dayScrollPhysics,
    this.dayScrollCacheExtent,
    this.dayScrollBehavior,
    this.monthScrollPhysics,
    this.monthScrollCacheExtent,
    this.monthScrollBehavior,
    this.yearScrollPhysics,
    this.yearScrollCacheExtent,
    this.yearScrollBehavior,
    this.headerBuilder = FCalendar.defaultHeaderBuilder,
    this.footerBuilder = FCalendar.defaultFooterBuilder,
    this.dayBuilder = FCalendar.defaultDayBuilder,
    this.monthBuilder = FCalendar.defaultMonthBuilder,
    this.yearBuilder = FCalendar.defaultYearBuilder,
    this.onDayPress,
    this.onDayLongPress,
    super.anchor,
    super.fieldAnchor,
    super.spacing,
    super.overflow,
    super.offset,
    super.useViewPadding,
    super.useViewInsets,
    super.hideRegion,
    super.groupId,
    super.onTapHide,
    super.cutout,
    super.cutoutBuilder,
    super.popoverBuilder,
    super.autoHide,
  }) : super._();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('dayScrollPhysics', dayScrollPhysics))
      ..add(DiagnosticsProperty('dayScrollCacheExtent', dayScrollCacheExtent))
      ..add(DiagnosticsProperty('dayScrollBehavior', dayScrollBehavior))
      ..add(DiagnosticsProperty('monthScrollPhysics', monthScrollPhysics))
      ..add(DiagnosticsProperty('monthScrollCacheExtent', monthScrollCacheExtent))
      ..add(DiagnosticsProperty('monthScrollBehavior', monthScrollBehavior))
      ..add(DiagnosticsProperty('yearScrollPhysics', yearScrollPhysics))
      ..add(DiagnosticsProperty('yearScrollCacheExtent', yearScrollCacheExtent))
      ..add(DiagnosticsProperty('yearScrollBehavior', yearScrollBehavior))
      ..add(ObjectFlagProperty.has('headerBuilder', headerBuilder))
      ..add(ObjectFlagProperty.has('footerBuilder', footerBuilder))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder))
      ..add(ObjectFlagProperty.has('monthBuilder', monthBuilder))
      ..add(ObjectFlagProperty.has('yearBuilder', yearBuilder))
      ..add(ObjectFlagProperty.has('onDayPress', onDayPress))
      ..add(ObjectFlagProperty.has('onDayLongPress', onDayLongPress));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FDateFieldGridCalendarProperties &&
          dayScrollPhysics == other.dayScrollPhysics &&
          dayScrollCacheExtent == other.dayScrollCacheExtent &&
          dayScrollBehavior == other.dayScrollBehavior &&
          monthScrollPhysics == other.monthScrollPhysics &&
          monthScrollCacheExtent == other.monthScrollCacheExtent &&
          monthScrollBehavior == other.monthScrollBehavior &&
          yearScrollPhysics == other.yearScrollPhysics &&
          yearScrollCacheExtent == other.yearScrollCacheExtent &&
          yearScrollBehavior == other.yearScrollBehavior &&
          headerBuilder == other.headerBuilder &&
          footerBuilder == other.footerBuilder &&
          dayBuilder == other.dayBuilder &&
          monthBuilder == other.monthBuilder &&
          yearBuilder == other.yearBuilder &&
          onDayPress == other.onDayPress &&
          onDayLongPress == other.onDayLongPress;

  @override
  int get hashCode =>
      super.hashCode ^
      dayScrollPhysics.hashCode ^
      dayScrollCacheExtent.hashCode ^
      dayScrollBehavior.hashCode ^
      monthScrollPhysics.hashCode ^
      monthScrollCacheExtent.hashCode ^
      monthScrollBehavior.hashCode ^
      yearScrollPhysics.hashCode ^
      yearScrollCacheExtent.hashCode ^
      yearScrollBehavior.hashCode ^
      headerBuilder.hashCode ^
      footerBuilder.hashCode ^
      dayBuilder.hashCode ^
      monthBuilder.hashCode ^
      yearBuilder.hashCode ^
      onDayPress.hashCode ^
      onDayLongPress.hashCode;
}

/// A date field calendar with a split header whose month and year grid pickers are independently togglable. Mirrors
/// [FCalendar.splitGrid].
class FDateFieldGridSplitCalendarProperties extends FDateFieldCalendarProperties {
  /// The control for the calendar's navigation.
  @override
  final FGridSplitCalendarControl control;

  /// The day picker's scroll physics.
  final ScrollPhysics? dayScrollPhysics;

  /// {@macro forui.foundation.doc_templates.scrollCacheExtent}
  final ScrollCacheExtent? dayScrollCacheExtent;

  /// The day picker's scroll behavior.
  final ScrollBehavior? dayScrollBehavior;

  /// The year picker's scroll physics.
  final ScrollPhysics? yearScrollPhysics;

  /// {@macro forui.foundation.doc_templates.scrollCacheExtent}
  final ScrollCacheExtent? yearScrollCacheExtent;

  /// The year picker's scroll behavior.
  final ScrollBehavior? yearScrollBehavior;

  /// Builds the calendar's header.
  final FCalendarHeaderBuilder<FGridSplitCalendarController> headerBuilder;

  /// Builds the calendar's footer.
  final FCalendarFooterBuilder<FGridSplitCalendarController> footerBuilder;

  /// Customizes the appearance of calendar days. Defaults to [FCalendar.defaultDayBuilder].
  final FCalendarDayBuilder dayBuilder;

  /// Customizes the appearance of calendar months. Defaults to [FCalendar.defaultMonthBuilder].
  final FCalendarMonthBuilder monthBuilder;

  /// Customizes the appearance of calendar years. Defaults to [FCalendar.defaultYearBuilder].
  final FCalendarYearBuilder yearBuilder;

  /// A callback for when a date is pressed.
  final FutureOr<void> Function(DateTime)? onDayPress;

  /// A callback for when a date is long pressed.
  final FutureOr<void> Function(DateTime)? onDayLongPress;

  /// Creates a [FDateFieldGridSplitCalendarProperties].
  const FDateFieldGridSplitCalendarProperties({
    this.control = const FGridSplitCalendarControl(),
    this.dayScrollPhysics,
    this.dayScrollCacheExtent,
    this.dayScrollBehavior,
    this.yearScrollPhysics,
    this.yearScrollCacheExtent,
    this.yearScrollBehavior,
    this.headerBuilder = FCalendar.defaultHeaderBuilder,
    this.footerBuilder = FCalendar.defaultFooterBuilder,
    this.dayBuilder = FCalendar.defaultDayBuilder,
    this.monthBuilder = FCalendar.defaultMonthBuilder,
    this.yearBuilder = FCalendar.defaultYearBuilder,
    this.onDayPress,
    this.onDayLongPress,
    super.anchor,
    super.fieldAnchor,
    super.spacing,
    super.overflow,
    super.offset,
    super.useViewPadding,
    super.useViewInsets,
    super.hideRegion,
    super.groupId,
    super.onTapHide,
    super.cutout,
    super.cutoutBuilder,
    super.popoverBuilder,
    super.autoHide,
  }) : super._();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('dayScrollPhysics', dayScrollPhysics))
      ..add(DiagnosticsProperty('dayScrollCacheExtent', dayScrollCacheExtent))
      ..add(DiagnosticsProperty('dayScrollBehavior', dayScrollBehavior))
      ..add(DiagnosticsProperty('yearScrollPhysics', yearScrollPhysics))
      ..add(DiagnosticsProperty('yearScrollCacheExtent', yearScrollCacheExtent))
      ..add(DiagnosticsProperty('yearScrollBehavior', yearScrollBehavior))
      ..add(ObjectFlagProperty.has('headerBuilder', headerBuilder))
      ..add(ObjectFlagProperty.has('footerBuilder', footerBuilder))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder))
      ..add(ObjectFlagProperty.has('monthBuilder', monthBuilder))
      ..add(ObjectFlagProperty.has('yearBuilder', yearBuilder))
      ..add(ObjectFlagProperty.has('onDayPress', onDayPress))
      ..add(ObjectFlagProperty.has('onDayLongPress', onDayLongPress));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FDateFieldGridSplitCalendarProperties &&
          dayScrollPhysics == other.dayScrollPhysics &&
          dayScrollCacheExtent == other.dayScrollCacheExtent &&
          dayScrollBehavior == other.dayScrollBehavior &&
          yearScrollPhysics == other.yearScrollPhysics &&
          yearScrollCacheExtent == other.yearScrollCacheExtent &&
          yearScrollBehavior == other.yearScrollBehavior &&
          headerBuilder == other.headerBuilder &&
          footerBuilder == other.footerBuilder &&
          dayBuilder == other.dayBuilder &&
          monthBuilder == other.monthBuilder &&
          yearBuilder == other.yearBuilder &&
          onDayPress == other.onDayPress &&
          onDayLongPress == other.onDayLongPress;

  @override
  int get hashCode =>
      super.hashCode ^
      dayScrollPhysics.hashCode ^
      dayScrollCacheExtent.hashCode ^
      dayScrollBehavior.hashCode ^
      yearScrollPhysics.hashCode ^
      yearScrollCacheExtent.hashCode ^
      yearScrollBehavior.hashCode ^
      headerBuilder.hashCode ^
      footerBuilder.hashCode ^
      dayBuilder.hashCode ^
      monthBuilder.hashCode ^
      yearBuilder.hashCode ^
      onDayPress.hashCode ^
      onDayLongPress.hashCode;
}

/// A date field calendar that toggles between a day grid picker and a month-year wheel picker. Mirrors [FCalendar.wheel].
class FDateFieldWheelCalendarProperties extends FDateFieldCalendarProperties {
  /// The control for the calendar's navigation.
  @override
  final FWheelCalendarControl control;

  /// Whether the month-year wheel loops. Defaults to false.
  final bool loop;

  /// The flex of the month wheel. Defaults to 1.
  final int monthFlex;

  /// The flex of the year wheel. Defaults to 1.
  final int yearFlex;

  /// The day picker's scroll physics.
  final ScrollPhysics? dayScrollPhysics;

  /// {@macro forui.foundation.doc_templates.scrollCacheExtent}
  final ScrollCacheExtent? dayScrollCacheExtent;

  /// The day picker's scroll behavior.
  final ScrollBehavior? dayScrollBehavior;

  /// Builds the calendar's header.
  final FCalendarHeaderBuilder<FWheelCalendarController> headerBuilder;

  /// Builds the calendar's footer.
  final FCalendarFooterBuilder<FWheelCalendarController> footerBuilder;

  /// Customizes the appearance of calendar days. Defaults to [FCalendar.defaultDayBuilder].
  final FCalendarDayBuilder dayBuilder;

  /// A callback for when a date is pressed.
  final FutureOr<void> Function(DateTime)? onDayPress;

  /// A callback for when a date is long pressed.
  final FutureOr<void> Function(DateTime)? onDayLongPress;

  /// Creates a [FDateFieldWheelCalendarProperties].
  const FDateFieldWheelCalendarProperties({
    this.control = const FWheelCalendarControl(),
    this.loop = false,
    this.monthFlex = 1,
    this.yearFlex = 1,
    this.dayScrollPhysics,
    this.dayScrollCacheExtent,
    this.dayScrollBehavior,
    this.headerBuilder = FCalendar.defaultHeaderBuilder,
    this.footerBuilder = FCalendar.defaultFooterBuilder,
    this.dayBuilder = FCalendar.defaultDayBuilder,
    this.onDayPress,
    this.onDayLongPress,
    super.anchor,
    super.fieldAnchor,
    super.spacing,
    super.overflow,
    super.offset,
    super.useViewPadding,
    super.useViewInsets,
    super.hideRegion,
    super.groupId,
    super.onTapHide,
    super.cutout,
    super.cutoutBuilder,
    super.popoverBuilder,
    super.autoHide,
  }) : super._();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('loop', value: loop, ifTrue: 'loop'))
      ..add(IntProperty('monthFlex', monthFlex))
      ..add(IntProperty('yearFlex', yearFlex))
      ..add(DiagnosticsProperty('dayScrollPhysics', dayScrollPhysics))
      ..add(DiagnosticsProperty('dayScrollCacheExtent', dayScrollCacheExtent))
      ..add(DiagnosticsProperty('dayScrollBehavior', dayScrollBehavior))
      ..add(ObjectFlagProperty.has('headerBuilder', headerBuilder))
      ..add(ObjectFlagProperty.has('footerBuilder', footerBuilder))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder))
      ..add(ObjectFlagProperty.has('onDayPress', onDayPress))
      ..add(ObjectFlagProperty.has('onDayLongPress', onDayLongPress));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FDateFieldWheelCalendarProperties &&
          loop == other.loop &&
          monthFlex == other.monthFlex &&
          yearFlex == other.yearFlex &&
          dayScrollPhysics == other.dayScrollPhysics &&
          dayScrollCacheExtent == other.dayScrollCacheExtent &&
          dayScrollBehavior == other.dayScrollBehavior &&
          headerBuilder == other.headerBuilder &&
          footerBuilder == other.footerBuilder &&
          dayBuilder == other.dayBuilder &&
          onDayPress == other.onDayPress &&
          onDayLongPress == other.onDayLongPress;

  @override
  int get hashCode =>
      super.hashCode ^
      loop.hashCode ^
      monthFlex.hashCode ^
      yearFlex.hashCode ^
      dayScrollPhysics.hashCode ^
      dayScrollCacheExtent.hashCode ^
      dayScrollBehavior.hashCode ^
      headerBuilder.hashCode ^
      footerBuilder.hashCode ^
      dayBuilder.hashCode ^
      onDayPress.hashCode ^
      onDayLongPress.hashCode;
}
