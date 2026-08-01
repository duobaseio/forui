// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir_flutter;
import 'package:remixicon/remixicon.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

/// These mappings mirror `forui_cli/lib/src/preset/icons.dart`. Keep both in sync.
enum _Icons {
  lucide('Lucide'),
  tabler('Tabler'),
  remix('Remix'),
  hugeicons('Hugeicons'),
  iconoir('Iconoir');

  final String label;

  const _Icons(this.label);

  FIcons get icons => switch (this) {
    .lucide => FIcons.lucide(),
    .tabler => FIcons(
      arrowLeft: const _TablerIcon(TablerIcons.arrowLeft, scale: 1.1),
      calendar: const _TablerIcon(TablerIcons.calendar, scale: 1.1),
      check: const _TablerIcon(TablerIcons.check, scale: 1.1),
      chevronDown: const _TablerIcon(TablerIcons.chevronDown),
      chevronLeft: const _TablerIcon(TablerIcons.chevronLeft),
      chevronRight: const _TablerIcon(TablerIcons.chevronRight),
      chevronUp: const _TablerIcon(TablerIcons.chevronUp),
      chevronsUpDown: const _TablerIcon(TablerIcons.selector, scale: 1.1),
      circleAlert: const _TablerIcon(TablerIcons.alertCircle, scale: 1.1),
      clock4: const _TablerIcon(TablerIcons.clockHour4, scale: 1.1),
      ellipsis: const _TablerIcon(TablerIcons.dots),
      error: const _TablerIcon(TablerIcons.alertCircle, scale: 1.1),
      eye: const _TablerIcon(TablerIcons.eye, scale: 1.1),
      eyeClosed: const _TablerIcon(TablerIcons.eyeOff),
      gripHorizontal: const _TablerIcon(TablerIcons.gripHorizontal),
      gripVertical: const _TablerIcon(TablerIcons.gripVertical),
      loader: const _TablerIcon(TablerIcons.loader, scale: 1.1),
      loaderCircle: const _TablerIcon(TablerIcons.loader2),
      loaderPinwheel: const _TablerIcon(TablerIcons.windmill, scale: 1.1),
      search: const _TablerIcon(TablerIcons.search),
      userRound: const _TablerIcon(TablerIcons.userCircle),
      x: const _TablerIcon(TablerIcons.x),
    ),
    .remix => FIcons(
      arrowLeft: const _RemixIcon(RemixIcons.arrow_left_line),
      calendar: const _RemixIcon(RemixIcons.calendar_line),
      check: const _RemixIcon(RemixIcons.check_line),
      chevronDown: const _RemixIcon(RemixIcons.arrow_down_s_line),
      chevronLeft: const _RemixIcon(RemixIcons.arrow_left_s_line),
      chevronRight: const _RemixIcon(RemixIcons.arrow_right_s_line),
      chevronUp: const _RemixIcon(RemixIcons.arrow_up_s_line),
      chevronsUpDown: const _RemixIcon(RemixIcons.expand_up_down_line),
      circleAlert: const _RemixIcon(RemixIcons.error_warning_line),
      clock4: const _RemixIcon(RemixIcons.time_line),
      ellipsis: const _RemixIcon(RemixIcons.more_line),
      error: const _RemixIcon(RemixIcons.error_warning_line),
      eye: const _RemixIcon(RemixIcons.eye_line),
      eyeClosed: const _RemixIcon(RemixIcons.eye_off_line),
      // Remix only ships a vertical grip; rotate it a quarter turn for the horizontal slot.
      gripHorizontal: const _RemixIcon(RemixIcons.draggable, rotated: true),
      gripVertical: const _RemixIcon(RemixIcons.draggable),
      loader: const _RemixIcon(RemixIcons.loader_line),
      loaderCircle: const _RemixIcon(RemixIcons.loader_4_line),
      loaderPinwheel: const _RemixIcon(RemixIcons.loader_line),
      search: const _RemixIcon(RemixIcons.search_line),
      userRound: const _RemixIcon(RemixIcons.user_line),
      x: const _RemixIcon(RemixIcons.close_line),
    ),
    .hugeicons => FIcons(
      arrowLeft: const _HugeIcon(HugeIcons.strokeRoundedArrowLeft01),
      calendar: const _HugeIcon(HugeIcons.strokeRoundedCalendar03),
      check: const _HugeIcon(HugeIcons.strokeRoundedTick02),
      chevronDown: const _HugeIcon(HugeIcons.strokeRoundedArrowDown01),
      chevronLeft: const _HugeIcon(HugeIcons.strokeRoundedArrowLeft01),
      chevronRight: const _HugeIcon(HugeIcons.strokeRoundedArrowRight01),
      chevronUp: const _HugeIcon(HugeIcons.strokeRoundedArrowUp01),
      chevronsUpDown: const _HugeIcon(HugeIcons.strokeRoundedUnfoldMore),
      circleAlert: const _HugeIcon(HugeIcons.strokeRoundedAlertCircle),
      clock4: const _HugeIcon(HugeIcons.strokeRoundedClock01),
      ellipsis: const _HugeIcon(HugeIcons.strokeRoundedMoreHorizontal),
      error: const _HugeIcon(HugeIcons.strokeRoundedAlertCircle),
      eye: const _HugeIcon(HugeIcons.strokeRoundedView),
      eyeClosed: const _HugeIcon(HugeIcons.strokeRoundedViewOff),
      gripHorizontal: const _HugeIcon(HugeIcons.strokeRoundedDragDropHorizontal),
      gripVertical: const _HugeIcon(HugeIcons.strokeRoundedDragDropVertical),
      loader: const _HugeIcon(HugeIcons.strokeRoundedLoading03),
      loaderCircle: const _HugeIcon(HugeIcons.strokeRoundedLoading03),
      loaderPinwheel: const _HugeIcon(HugeIcons.strokeRoundedLoaderPinwheel),
      search: const _HugeIcon(HugeIcons.strokeRoundedSearch01),
      userRound: const _HugeIcon(HugeIcons.strokeRoundedUserCircle),
      x: const _HugeIcon(HugeIcons.strokeRoundedCancel01),
    ),
    .iconoir => FIcons(
      arrowLeft: const _IconoirIcon(iconoir_flutter.ArrowLeft.new),
      calendar: const _IconoirIcon(iconoir_flutter.Calendar.new),
      check: const _IconoirIcon(iconoir_flutter.Check.new),
      chevronDown: const _IconoirIcon(iconoir_flutter.NavArrowDown.new),
      chevronLeft: const _IconoirIcon(iconoir_flutter.NavArrowLeft.new),
      chevronRight: const _IconoirIcon(iconoir_flutter.NavArrowRight.new),
      chevronUp: const _IconoirIcon(iconoir_flutter.NavArrowUp.new),
      chevronsUpDown: const _IconoirIcon(iconoir_flutter.ArrowSeparateVertical.new),
      circleAlert: const _IconoirIcon(iconoir_flutter.WarningCircle.new),
      clock4: const _IconoirIcon(iconoir_flutter.Clock.new),
      ellipsis: const _IconoirIcon(iconoir_flutter.MoreHoriz.new),
      error: const _IconoirIcon(iconoir_flutter.WarningCircle.new),
      eye: const _IconoirIcon(iconoir_flutter.Eye.new),
      eyeClosed: const _IconoirIcon(iconoir_flutter.EyeClosed.new),
      gripHorizontal: const _IconoirIcon(iconoir_flutter.Drag.new),
      gripVertical: const _IconoirIcon(iconoir_flutter.Drag.new),
      loader: const _IconoirIcon(iconoir_flutter.OnePointCircle.new),
      loaderCircle: const _IconoirIcon(iconoir_flutter.OnePointCircle.new),
      loaderPinwheel: const _IconoirIcon(iconoir_flutter.ColorWheel.new),
      search: const _IconoirIcon(iconoir_flutter.Search.new),
      userRound: const _IconoirIcon(iconoir_flutter.UserCircle.new),
      x: const _IconoirIcon(iconoir_flutter.Xmark.new),
    ),
  };
}

// Tabler's font metrics (ascent 0.9em, descent -0.1em) round differently from lucide's (1em, 0) at device
// pixel scale, sinking every glyph ~0.05em below lucide's position on macOS, so nudge all slots up. Some
// glyphs also render ~10% smaller than their lucide counterparts; scale those to match.
class _TablerIcon implements FIcon {
  final IconData icon;
  final double scale;

  const _TablerIcon(this.icon, {this.scale = 1});

  @override
  Widget call(BuildContext _, {String? semanticsLabel}) => Builder(
    builder: (context) {
      final size = IconTheme.of(context).size ?? 24;
      final child = Icon(icon, semanticLabel: semanticsLabel);
      return Transform.translate(
        offset: Offset(0, -0.05 * size),
        child: scale == 1 ? child : Transform.scale(scale: scale, child: child),
      );
    },
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _TablerIcon && icon == other.icon && scale == other.scale;

  @override
  int get hashCode => Object.hash(icon, scale);
}

class _RemixIcon implements FIcon {
  final IconData icon;
  final bool rotated;

  const _RemixIcon(this.icon, {this.rotated = false});

  @override
  Widget call(BuildContext _, {String? semanticsLabel}) => Builder(
    builder: (context) {
      final size = IconTheme.of(context).size ?? 24;
      final child = Icon(icon, semanticLabel: semanticsLabel);
      return Transform.translate(
        offset: Offset(0, 0.02 * size),
        child: Transform.scale(scale: 1.15, child: rotated ? RotatedBox(quarterTurns: 1, child: child) : child),
      );
    },
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _RemixIcon && icon == other.icon && rotated == other.rotated;

  @override
  int get hashCode => Object.hash(icon, rotated);
}

class _HugeIcon implements FIcon {
  final List<List<dynamic>> icon;

  const _HugeIcon(this.icon);

  @override
  Widget call(BuildContext _, {String? semanticsLabel}) => HugeIcon(icon: icon, size: null);

  // HugeIcons' constants are const lists, so identity is sufficient.
  @override
  bool operator ==(Object other) => identical(this, other) || other is _HugeIcon && identical(icon, other.icon);

  @override
  int get hashCode => identityHashCode(icon);
}

class _IconoirIcon implements FIcon {
  final Widget Function({Color? color, double? width, double? height}) icon;

  const _IconoirIcon(this.icon);

  @override
  Widget call(BuildContext _, {String? semanticsLabel}) => Builder(
    builder: (context) {
      final theme = IconTheme.of(context);
      return icon(color: theme.color, width: theme.size, height: theme.size);
    },
  );

  // Constructor tear-offs of the same class are canonical, so `==` holds.
  @override
  bool operator ==(Object other) => identical(this, other) || other is _IconoirIcon && icon == other.icon;

  @override
  int get hashCode => icon.hashCode;
}

const _fruits = {
  'Apple': 'Apple',
  'Banana': 'Banana',
  'Blueberry': 'Blueberry',
  'Grapes': 'Grapes',
  'Lemon': 'Lemon',
  'Mango': 'Mango',
  'Kiwi': 'Kiwi',
  'Orange': 'Orange',
  'Pear': 'Pear',
  'Strawberry': 'Strawberry',
};

/// Each section is rendered twice, once per column, so both libraries show identical content.
final List<(String, WidgetBuilder)> _sections = [
  (
    'FAccordion (chevronDown)',
    (_) => const FAccordion(
      children: [
        FAccordionItem(
          title: Text('Accordion item'),
          child: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Body content')),
        ),
      ],
    ),
  ),
  (
    'FAlert (circleAlert)',
    (_) => const FAlert(title: Text('Heads up'), subtitle: Text('This alert uses the circleAlert slot.')),
  ),
  (
    'FAvatar (userRound)',
    // An unreachable image forces the userRound fallback.
    (_) => FAvatar(image: const NetworkImage('https://invalid.example/none.png'), size: 56),
  ),
  (
    'FBreadcrumb (chevronRight, ellipsis)',
    (_) => FBreadcrumb(
      children: [
        FBreadcrumbItem(onPress: () {}, child: const Text('Home')),
        FBreadcrumbItem.collapsed(
          menu: [
            .group(
              children: [
                .item(title: const Text('Library'), onPress: () {}),
                .item(title: const Text('Widgets'), onPress: () {}),
              ],
            ),
          ],
        ),
        FBreadcrumbItem(current: true, onPress: () {}, child: const Text('Icons')),
      ],
    ),
  ),
  (
    'FCalendar (chevronLeft, chevronRight)',
    (_) => FCalendar.grid(
      control: FGridCalendarControl(start: DateTime.utc(2000), end: DateTime.utc(2040)),
      selectionControl: .managedSingle(),
    ),
  ),
  ('FCheckbox (check)', (_) => const _Checkbox()),
  ('FDateField (calendar)', (_) => FDateField(label: const Text('Date'))),
  ('FTimeField (clock4)', (_) => FTimeField(label: const Text('Time'))),
  (
    'FHeader (arrowLeft, x)',
    // FHeader.nested expects the loose width constraint of a scaffold header slot, so loosen the section's tight
    // width with an Align.
    (_) => Align(
      child: FHeader.nested(
        title: const Text('Header'),
        prefixes: [FHeaderAction.back(onPress: () {})],
        suffixes: [FHeaderAction.x(onPress: () {})],
      ),
    ),
  ),
  ('FPagination (chevronLeft, chevronRight)', (_) => const FPagination(control: .managed(pages: 10))),
  (
    'FCircularProgress (loaderCircle, loader, loaderPinwheel)',
    (_) => const Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        FCircularProgress(size: .lg),
        FCircularProgress.loader(size: .lg),
        FCircularProgress.pinwheel(size: .lg),
      ],
    ),
  ),
  (
    'FPopoverMenu (chevronRight submenu)',
    (_) => FPopoverMenu(
      menu: [
        .group(
          children: [
            .item(title: const Text('Edit'), onPress: () {}),
            .submenu(
              title: const Text('Share'),
              submenu: [
                .group(
                  children: [
                    .item(title: const Text('Email'), onPress: () {}),
                    .item(title: const Text('Copy link'), onPress: () {}),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      builder: (_, controller, _) =>
          FButton(variant: .outline, mainAxisSize: .min, onPress: controller.toggle, child: const Text('Open menu')),
    ),
  ),
  ('FSelect (chevronDown, check)', (_) => FSelect<String>(hint: 'Select a fruit', items: _fruits)),
  ('FSelect.search (search, chevronUp)', (_) => FSelect<String>.search(hint: 'Search a fruit', items: _fruits)),
  (
    'FMultiSelect (chevronDown, x tags)',
    (_) => FMultiSelect<String>(
      control: const .managed(initial: {'Apple', 'Banana'}),
      hint: const Text('Select fruits'),
      items: _fruits,
    ),
  ),
  (
    'FSelectMenuTile (chevronsUpDown)',
    (_) => FSelectMenuTile<String>(
      selectControl: const .managedRadio(),
      title: const Text('Menu tile'),
      menu: const [
        FSelectTile(title: Text('Option 1'), value: 'option1'),
        FSelectTile(title: Text('Option 2'), value: 'option2'),
      ],
    ),
  ),
  (
    'FSelectTileGroup (check)',
    (_) => FSelectTileGroup<String>(
      control: const .managed(initial: {'Apple'}),
      label: const Text('Fruits'),
      children: const [
        .tile(title: Text('Apple'), value: 'Apple'),
        .tile(title: Text('Banana'), value: 'Banana'),
      ],
    ),
  ),
  (
    'FSidebarItem (chevronRight collapsible)',
    (_) => FSidebarItem(
      label: const Text('Components'),
      children: [
        FSidebarItem(label: const Text('Button'), onPress: () {}),
        FSidebarItem(label: const Text('Select'), onPress: () {}),
      ],
    ),
  ),
  ('FTextField.password (eye, eyeClosed)', (_) => FTextField.password(label: const Text('Password'))),
  (
    'FTextField (x clear)',
    (_) => FTextField(
      label: const Text('Clearable'),
      hint: 'Type to reveal clear button',
      clearable: (value) => value.text.isNotEmpty,
    ),
  ),
  (
    'FTextFormField (error message)',
    (_) => FTextFormField(
      label: const Text('Email'),
      hint: 'janedoe@foruslabs.com',
      forceErrorText: 'The email format is invalid',
    ),
  ),
  (
    'FResizable (gripHorizontal, gripVertical)',
    (_) => Column(
      spacing: 16,
      children: [
        SizedBox(
          height: 160,
          child: FResizable(
            axis: .vertical,
            control: const .managedCascade(),
            divider: .dividerWithThumb,
            children: [
              .flex(flex: 2, minFlex: 1, builder: (context, data, child) => const Center(child: Text('Top'))),
              .flex(flex: 2, minFlex: 1, builder: (context, data, child) => const Center(child: Text('Bottom'))),
            ],
          ),
        ),
        SizedBox(
          height: 120,
          child: FResizable(
            axis: .horizontal,
            control: const .managedCascade(),
            divider: .dividerWithThumb,
            children: [
              .flex(flex: 2, minFlex: 1, builder: (context, data, child) => const Center(child: Text('Left'))),
              .flex(flex: 2, minFlex: 1, builder: (context, data, child) => const Center(child: Text('Right'))),
            ],
          ),
        ),
      ],
    ),
  ),
];

/// Compares Lucide (left column) against another icon library (right column) across every widget that consumes an
/// [FIcons] slot.
class IconComparison extends StatefulWidget {
  const IconComparison({super.key});

  @override
  State<IconComparison> createState() => _IconComparisonState();
}

class _IconComparisonState extends State<IconComparison> {
  _Icons _other = .tabler;

  @override
  Widget build(BuildContext context) {
    final base = context.theme;
    final lucide = FThemeData(colors: base.colors, touch: false, icons: _Icons.lucide.icons);
    final other = FThemeData(colors: base.colors, touch: false, icons: _other.icons);
    final header = base.typography.body.md.copyWith(fontWeight: FontWeight.w600);

    return SingleChildScrollView(
      padding: const .all(20),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 24,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final library in _Icons.values)
                if (library != .lucide)
                  FButton(
                    variant: library == _other ? .primary : .outline,
                    mainAxisSize: .min,
                    onPress: () => setState(() => _other = library),
                    child: Text(library.label),
                  ),
            ],
          ),
          Row(
            spacing: 16,
            children: [
              Expanded(child: Text('Lucide', style: header)),
              Expanded(child: Text(_other.label, style: header)),
            ],
          ),
          for (final (title, builder) in _sections) _compare(title, builder, lucide, other),
        ],
      ),
    );
  }

  Widget _compare(String title, WidgetBuilder builder, FThemeData lucide, FThemeData other) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Text(title, style: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground)),
        Row(
          crossAxisAlignment: .start,
          spacing: 16,
          children: [
            Expanded(child: _cell(lucide, builder)),
            Expanded(child: _cell(other, builder)),
          ],
        ),
      ],
    );
  }

  static Widget _cell(FThemeData theme, WidgetBuilder builder) => FTheme(
    data: theme,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.background,
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Builder(builder: builder),
    ),
  );
}

class _Checkbox extends StatefulWidget {
  const _Checkbox();

  @override
  State<_Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<_Checkbox> {
  bool _value = true;

  @override
  Widget build(BuildContext context) =>
      FCheckbox(label: const Text('Checked'), value: _value, onChange: (value) => setState(() => _value = value));
}
