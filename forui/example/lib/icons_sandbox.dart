// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir_flutter;
import 'package:remixicon/remixicon.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

enum _Icons {
  lucide('Lucide'),
  tabler('Tabler'),
  remix('Remix'),
  hugeicons('Hugeicons'),
  iconoir('Iconoir');

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
      arrowLeft: FIcons.iconData(TablerIcons.arrowLeft),
      calendar: FIcons.iconData(TablerIcons.calendar),
      check: FIcons.iconData(TablerIcons.check),
      chevronDown: FIcons.iconData(TablerIcons.chevronDown),
      chevronLeft: FIcons.iconData(TablerIcons.chevronLeft),
      chevronRight: FIcons.iconData(TablerIcons.chevronRight),
      chevronUp: FIcons.iconData(TablerIcons.chevronUp),
      chevronsUpDown: FIcons.iconData(TablerIcons.selector),
      circleAlert: FIcons.iconData(TablerIcons.alertCircle),
      clock4: FIcons.iconData(TablerIcons.clockHour4),
      ellipsis: FIcons.iconData(TablerIcons.dots),
      eye: FIcons.iconData(TablerIcons.eye),
      eyeClosed: FIcons.iconData(TablerIcons.eyeOff),
      gripHorizontal: FIcons.iconData(TablerIcons.gripHorizontal),
      gripVertical: FIcons.iconData(TablerIcons.gripVertical),
      loader: FIcons.iconData(TablerIcons.loader),
      loaderCircle: FIcons.iconData(TablerIcons.loader2),
      loaderPinwheel: FIcons.iconData(TablerIcons.loaderQuarter),
      search: FIcons.iconData(TablerIcons.search),
      userRound: FIcons.iconData(TablerIcons.userCircle),
      x: FIcons.iconData(TablerIcons.x),
    ),
    .remix => FIcons(
      arrowLeft: FIcons.iconData(RemixIcons.arrow_left_line),
      calendar: FIcons.iconData(RemixIcons.calendar_line),
      check: FIcons.iconData(RemixIcons.check_line),
      chevronDown: FIcons.iconData(RemixIcons.arrow_down_s_line),
      chevronLeft: FIcons.iconData(RemixIcons.arrow_left_s_line),
      chevronRight: FIcons.iconData(RemixIcons.arrow_right_s_line),
      chevronUp: FIcons.iconData(RemixIcons.arrow_up_s_line),
      chevronsUpDown: FIcons.iconData(RemixIcons.expand_up_down_line),
      circleAlert: FIcons.iconData(RemixIcons.error_warning_line),
      clock4: FIcons.iconData(RemixIcons.time_line),
      ellipsis: FIcons.iconData(RemixIcons.more_line),
      eye: FIcons.iconData(RemixIcons.eye_line),
      eyeClosed: FIcons.iconData(RemixIcons.eye_off_line),
      gripHorizontal: FIcons.iconData(RemixIcons.draggable),
      gripVertical: FIcons.iconData(RemixIcons.draggable),
      loader: FIcons.iconData(RemixIcons.loader_line),
      loaderCircle: FIcons.iconData(RemixIcons.loader_4_line),
      loaderPinwheel: FIcons.iconData(RemixIcons.loader_5_line),
      search: FIcons.iconData(RemixIcons.search_line),
      userRound: FIcons.iconData(RemixIcons.user_line),
      x: FIcons.iconData(RemixIcons.close_line),
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
      eye: _hugeicon(HugeIcons.strokeRoundedView),
      eyeClosed: _hugeicon(HugeIcons.strokeRoundedViewOff),
      gripHorizontal: _hugeicon(HugeIcons.strokeRoundedDragDropHorizontal),
      gripVertical: _hugeicon(HugeIcons.strokeRoundedDragDropVertical),
      loader: _hugeicon(HugeIcons.strokeRoundedLoading01),
      loaderCircle: _hugeicon(HugeIcons.strokeRoundedLoading03),
      loaderPinwheel: _hugeicon(HugeIcons.strokeRoundedLoading04),
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
      chevronsUpDown: _iconoirIcon(iconoir_flutter.DataTransferBoth.new),
      circleAlert: _iconoirIcon(iconoir_flutter.WarningCircle.new),
      clock4: _iconoirIcon(iconoir_flutter.Clock.new),
      ellipsis: _iconoirIcon(iconoir_flutter.MoreHoriz.new),
      eye: _iconoirIcon(iconoir_flutter.Eye.new),
      eyeClosed: _iconoirIcon(iconoir_flutter.EyeClosed.new),
      gripHorizontal: _iconoirIcon(iconoir_flutter.Drag.new),
      gripVertical: _iconoirIcon(iconoir_flutter.Drag.new),
      loader: _iconoirIcon(iconoir_flutter.Refresh.new),
      loaderCircle: _iconoirIcon(iconoir_flutter.RefreshCircle.new),
      loaderPinwheel: _iconoirIcon(iconoir_flutter.Spiral.new),
      search: _iconoirIcon(iconoir_flutter.Search.new),
      userRound: _iconoirIcon(iconoir_flutter.UserCircle.new),
      x: _iconoirIcon(iconoir_flutter.Xmark.new),
    ),
  };
}

class IconsSandbox extends StatefulWidget {
  const IconsSandbox({super.key});

  @override
  State<IconsSandbox> createState() => _IconsSandboxState();
}

class _IconsSandboxState extends State<IconsSandbox> {
  _Icons _library = .lucide;

  @override
  Widget build(BuildContext context) {
    final base = context.theme;
    final theme = FThemeData(colors: base.colors, touch: false, icons: _library.icons);

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
                FButton(
                  variant: library == _library ? .primary : .outline,
                  onPress: () => setState(() => _library = library),
                  child: Text(library.label),
                ),
            ],
          ),
          FTheme(data: theme, child: const _Showcase()),
        ],
      ),
    );
  }
}

class _Showcase extends StatelessWidget {
  static const _fruits = {
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

  const _Showcase();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    spacing: 24,
    children: [
      _section(
        context,
        'FAlert (circleAlert)',
        const FAlert(title: Text('Heads up'), subtitle: Text('This alert uses the circleAlert slot.')),
      ),
      _section(
        context,
        'FAvatar (userRound)',
        // An unreachable image forces the userRound fallback.
        FAvatar(image: const NetworkImage('https://invalid.example/none.png'), size: 56),
      ),
      _section(
        context,
        'FAccordion (chevronDown)',
        const FAccordion(
          children: [
            FAccordionItem(
              title: Text('Accordion item'),
              child: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Body content')),
            ),
          ],
        ),
      ),
      _section(
        context,
        'FBreadcrumb (chevronRight)',
        FBreadcrumb(
          children: [
            FBreadcrumbItem(onPress: () {}, child: const Text('Home')),
            FBreadcrumbItem(onPress: () {}, child: const Text('Library')),
            FBreadcrumbItem(current: true, onPress: () {}, child: const Text('Icons')),
          ],
        ),
      ),
      _section(context, 'FDateField (calendar)', FDateField(label: const Text('Date'))),
      _section(context, 'FTimeField (clock4)', FTimeField(label: const Text('Time'))),
      _section(
        context,
        'FHeader (arrowLeft, x)',
        // FHeader.nested expects the loose width constraint of a scaffold header slot, so loosen the section's tight
        // width with an Align.
        Align(
          child: FHeader.nested(
            title: const Text('Header'),
            prefixes: [FHeaderAction.back(onPress: () {})],
            suffixes: [FHeaderAction.x(onPress: () {})],
          ),
        ),
      ),
      _section(context, 'FPagination (chevronLeft, chevronRight)', const FPagination(control: .managed(pages: 10))),
      _section(
        context,
        'FCarousel',
        FCarousel(
          autoPlay: null,
          children: [
            ColoredBox(color: context.theme.colors.primary),
            ColoredBox(color: context.theme.colors.secondary),
            ColoredBox(color: context.theme.colors.destructive),
          ],
        ),
      ),
      _section(
        context,
        'FCircularProgress (loader, loaderCircle, loaderPinwheel)',
        const Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            FCircularProgress(size: .lg),
            FCircularProgress.loader(size: .lg),
            FCircularProgress.pinwheel(size: .lg),
          ],
        ),
      ),
      _section(context, 'FSelect (chevronDown, check)', FSelect<String>(hint: 'Select a fruit', items: _fruits)),
      _section(
        context,
        'FSelect.search (search, chevronUp)',
        FSelect<String>.search(hint: 'Search a fruit', items: _fruits),
      ),
      _section(
        context,
        'FMultiSelect (chevronDown)',
        FMultiSelect<String>(hint: const Text('Select fruits'), items: _fruits),
      ),
      _section(
        context,
        'FSelectMenuTile (chevronsUpDown)',
        FSelectMenuTile<String>(
          selectControl: const .managedRadio(),
          title: const Text('Menu tile'),
          menu: const [
            FSelectTile(title: Text('Option 1'), value: 'option1'),
            FSelectTile(title: Text('Option 2'), value: 'option2'),
          ],
        ),
      ),
      _section(context, 'FTextField.password (eye, eyeClosed)', FTextField.password(label: const Text('Password'))),
      _section(
        context,
        'FTextField (x clear)',
        FTextField(
          label: const Text('Clearable'),
          hint: 'Type to reveal clear button',
          clearable: (value) => value.text.isNotEmpty,
        ),
      ),
      _section(
        context,
        'FResizable (gripHorizontal, gripVertical)',
        Column(
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
    ],
  );

  static Widget _section(BuildContext context, String title, Widget child) {
    final colors = context.theme.colors;
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Text(title, style: context.theme.typography.body.sm.copyWith(color: colors.mutedForeground)),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.background,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ],
    );
  }
}
