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

  // Tabler's font metrics (ascent 0.9em, descent -0.1em) round differently from lucide's (1em, 0) at device
  // pixel scale, sinking every glyph ~0.05em below lucide's position on macOS, so nudge all slots up. Some
  // glyphs also render ~10% smaller than their lucide counterparts; scale those to match.
  static FIconBuilder _tablerIcon(IconData icon, {double scale = 1}) =>
      (_, {semanticsLabel}) => Builder(
        builder: (context) {
          final size = IconTheme.of(context).size ?? 24;
          final child = Icon(icon, semanticLabel: semanticsLabel);
          return Transform.translate(
            offset: Offset(0, -0.05 * size),
            child: scale == 1 ? child : Transform.scale(scale: scale, child: child),
          );
        },
      );

  static FIconBuilder _fitted(IconData icon, {bool rotated = false}) =>
      (_, {semanticsLabel}) => Builder(
        builder: (context) {
          final size = IconTheme.of(context).size ?? 24;
          final child = Icon(icon, semanticLabel: semanticsLabel);
          return Transform.translate(
            offset: Offset(0, 0.02 * size),
            child: Transform.scale(scale: 1.15, child: rotated ? RotatedBox(quarterTurns: 1, child: child) : child),
          );
        },
      );

  static FIconBuilder _hugeicon(List<List<dynamic>> icon) =>
      (_, {semanticsLabel}) => HugeIcon(icon: icon, size: null);

  static FIconBuilder _iconoirIcon(Widget Function({Color? color, double? width, double? height}) icon) =>
      (_, {semanticsLabel}) => Builder(
        builder: (context) {
          final theme = IconTheme.of(context);
          return icon(color: theme.color, width: theme.size, height: theme.size);
        },
      );

  final String label;

  const _Icons(this.label);

  FIcons get icons => switch (this) {
    .lucide => FIcons.lucide(),
    .tabler => FIcons(
      arrowLeft: _tablerIcon(TablerIcons.arrowLeft, scale: 1.1),
      calendar: _tablerIcon(TablerIcons.calendar, scale: 1.1),
      check: _tablerIcon(TablerIcons.check, scale: 1.1),
      chevronDown: _tablerIcon(TablerIcons.chevronDown),
      chevronLeft: _tablerIcon(TablerIcons.chevronLeft),
      chevronRight: _tablerIcon(TablerIcons.chevronRight),
      chevronUp: _tablerIcon(TablerIcons.chevronUp),
      chevronsUpDown: _tablerIcon(TablerIcons.selector, scale: 1.1),
      circleAlert: _tablerIcon(TablerIcons.alertCircle, scale: 1.1),
      clock4: _tablerIcon(TablerIcons.clockHour4, scale: 1.1),
      ellipsis: _tablerIcon(TablerIcons.dots),
      error: _tablerIcon(TablerIcons.alertCircle, scale: 1.1),
      eye: _tablerIcon(TablerIcons.eye, scale: 1.1),
      eyeClosed: _tablerIcon(TablerIcons.eyeOff),
      gripHorizontal: _tablerIcon(TablerIcons.gripHorizontal),
      gripVertical: _tablerIcon(TablerIcons.gripVertical),
      loader: _tablerIcon(TablerIcons.loader, scale: 1.1),
      loaderCircle: _tablerIcon(TablerIcons.loader2),
      loaderPinwheel: _tablerIcon(TablerIcons.windmill, scale: 1.1),
      search: _tablerIcon(TablerIcons.search),
      userRound: _tablerIcon(TablerIcons.userCircle),
      x: _tablerIcon(TablerIcons.x),
    ),
    .remix => FIcons(
      arrowLeft: _fitted(RemixIcons.arrow_left_line),
      calendar: _fitted(RemixIcons.calendar_line),
      check: _fitted(RemixIcons.check_line),
      chevronDown: _fitted(RemixIcons.arrow_down_s_line),
      chevronLeft: _fitted(RemixIcons.arrow_left_s_line),
      chevronRight: _fitted(RemixIcons.arrow_right_s_line),
      chevronUp: _fitted(RemixIcons.arrow_up_s_line),
      chevronsUpDown: _fitted(RemixIcons.expand_up_down_line),
      circleAlert: _fitted(RemixIcons.error_warning_line),
      clock4: _fitted(RemixIcons.time_line),
      ellipsis: _fitted(RemixIcons.more_line),
      error: _fitted(RemixIcons.error_warning_line),
      eye: _fitted(RemixIcons.eye_line),
      eyeClosed: _fitted(RemixIcons.eye_off_line),
      // Remix only ships a vertical grip; rotate it a quarter turn for the horizontal slot.
      gripHorizontal: _fitted(RemixIcons.draggable, rotated: true),
      gripVertical: _fitted(RemixIcons.draggable),
      loader: _fitted(RemixIcons.loader_line),
      loaderCircle: _fitted(RemixIcons.loader_4_line),
      loaderPinwheel: _fitted(RemixIcons.loader_line),
      search: _fitted(RemixIcons.search_line),
      userRound: _fitted(RemixIcons.user_line),
      x: _fitted(RemixIcons.close_line),
    ),
    .hugeicons => FIcons(
      arrowLeft: _hugeicon(HugeIcons.strokeRoundedArrowLeft01),
      calendar: _hugeicon(HugeIcons.strokeRoundedCalendar03),
      check: _hugeicon(HugeIcons.strokeRoundedTick02),
      chevronDown: _hugeicon(HugeIcons.strokeRoundedArrowDown01),
      chevronLeft: _hugeicon(HugeIcons.strokeRoundedArrowLeft01),
      chevronRight: _hugeicon(HugeIcons.strokeRoundedArrowRight01),
      chevronUp: _hugeicon(HugeIcons.strokeRoundedArrowUp01),
      chevronsUpDown: _hugeicon(HugeIcons.strokeRoundedUnfoldMore),
      circleAlert: _hugeicon(HugeIcons.strokeRoundedAlertCircle),
      clock4: _hugeicon(HugeIcons.strokeRoundedClock01),
      ellipsis: _hugeicon(HugeIcons.strokeRoundedMoreHorizontal),
      error: _hugeicon(HugeIcons.strokeRoundedAlertCircle),
      eye: _hugeicon(HugeIcons.strokeRoundedView),
      eyeClosed: _hugeicon(HugeIcons.strokeRoundedViewOff),
      gripHorizontal: _hugeicon(HugeIcons.strokeRoundedDragDropHorizontal),
      gripVertical: _hugeicon(HugeIcons.strokeRoundedDragDropVertical),
      loader: _hugeicon(HugeIcons.strokeRoundedLoading03),
      loaderCircle: _hugeicon(HugeIcons.strokeRoundedLoading03),
      loaderPinwheel: _hugeicon(HugeIcons.strokeRoundedLoaderPinwheel),
      search: _hugeicon(HugeIcons.strokeRoundedSearch01),
      userRound: _hugeicon(HugeIcons.strokeRoundedUserCircle),
      x: _hugeicon(HugeIcons.strokeRoundedCancel01),
    ),
    .iconoir => FIcons(
      arrowLeft: _iconoirIcon(iconoir_flutter.ArrowLeft.new),
      calendar: _iconoirIcon(iconoir_flutter.Calendar.new),
      check: _iconoirIcon(iconoir_flutter.Check.new),
      chevronDown: _iconoirIcon(iconoir_flutter.NavArrowDown.new),
      chevronLeft: _iconoirIcon(iconoir_flutter.NavArrowLeft.new),
      chevronRight: _iconoirIcon(iconoir_flutter.NavArrowRight.new),
      chevronUp: _iconoirIcon(iconoir_flutter.NavArrowUp.new),
      chevronsUpDown: _iconoirIcon(iconoir_flutter.ArrowSeparateVertical.new),
      circleAlert: _iconoirIcon(iconoir_flutter.WarningCircle.new),
      clock4: _iconoirIcon(iconoir_flutter.Clock.new),
      ellipsis: _iconoirIcon(iconoir_flutter.MoreHoriz.new),
      error: _iconoirIcon(iconoir_flutter.WarningCircle.new),
      eye: _iconoirIcon(iconoir_flutter.Eye.new),
      eyeClosed: _iconoirIcon(iconoir_flutter.EyeClosed.new),
      gripHorizontal: _iconoirIcon(iconoir_flutter.Drag.new),
      gripVertical: _iconoirIcon(iconoir_flutter.Drag.new),
      loader: _iconoirIcon(iconoir_flutter.OnePointCircle.new),
      loaderCircle: _iconoirIcon(iconoir_flutter.OnePointCircle.new),
      loaderPinwheel: _iconoirIcon(iconoir_flutter.ColorWheel.new),
      search: _iconoirIcon(iconoir_flutter.Search.new),
      userRound: _iconoirIcon(iconoir_flutter.UserCircle.new),
      x: _iconoirIcon(iconoir_flutter.Xmark.new),
    ),
  };
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
