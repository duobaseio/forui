import 'dart:io';

import 'package:forui_cli/src/codec.dart';
import 'package:forui_cli/src/commands/theme/theme.dart';
import 'package:forui_cli/src/components/log.dart';
import 'package:forui_cli/src/components/spinner.dart';
import 'package:forui_cli/src/preset/icon_mapping.dart';
import 'package:forui_cli/src/terminal/terminal.dart';

/// Generates the icons section by rewriting the neutral theme's Lucide icons with [preset]'s icon library.
String generateIcons(Preset preset) {
  var icons = neutral.icons;
  for (final mapping in IconMapping.values) {
    if (preset.icon.map(mapping) case final icon?) {
      icons = icons.replaceAll('FIcons.iconData(FLucideIcons.${mapping.name})', icon);
    }
  }

  return icons;
}

/// Adds [preset]'s icon library package to the project, unless it is the built-in Lucide.
Future<void> installIcons(Preset preset, Directory root) async {
  if (preset.icon == .lucide) {
    return;
  }

  final spinner = Spinner()..start('Adding ${preset.icon.package}...');
  final result = await Process.run('flutter', ['pub', 'add', preset.icon.package], workingDirectory: root.path);

  if (result.exitCode != 0) {
    spinner.error('Failed to add ${preset.icon.package}.', result.stderr.toString());
    terminal.outro();
    exit(1);
  }

  spinner.stop('Added ${preset.icon.package}');
}

extension Icons on IconLibrary {
  // Tabler's font metrics (ascent 0.9em, descent -0.1em) round differently from lucide's (1em, 0) at device
  // pixel scale, sinking every glyph ~0.05em below lucide's position on macOS, so nudge all slots up. Some
  // glyphs also render ~10% smaller than their lucide counterparts; scale those to match.
  static String _tabler(String value, {double? scale}) {
    var icon = 'Icon(TablerIcons.$value, semanticLabel: semanticsLabel)';
    if (scale != null) {
      icon = 'Transform.scale(scale: $scale, child: $icon)';
    }

    return '(_, {semanticsLabel}) => Builder(builder: (context) => Transform.translate(offset: '
        'Offset(0, -0.05 * (IconTheme.of(context).size ?? 24)), '
        'child: $icon))';
  }

  static String _remix(String value, {bool rotated = false}) {
    var icon = 'Icon(RemixIcons.$value, semanticLabel: semanticsLabel)';
    if (rotated) {
      icon = 'RotatedBox(quarterTurns: 1, child: $icon)';
    }

    return '(_, {semanticsLabel}) => Builder(builder: (context) => Transform.translate(offset: '
        'Offset(0, 0.02 * (IconTheme.of(context).size ?? 24)), '
        'child: Transform.scale(scale: 1.15, child: $icon)))';
  }

  static String _hugeicon(String value) => '(_, {semanticsLabel}) => HugeIcon(icon: HugeIcons.$value, size: null)';

  static String _iconoir(String value) =>
      '(_, {semanticsLabel}) => Builder(builder: (context) => iconoir.'
      '$value(color: IconTheme.of(context).color, width: IconTheme.of(context).size, height: IconTheme.of(context).size))';

  /// The import statement for this library, or null for the built-in Lucide.
  String? get import => switch (this) {
    IconLibrary.lucide => null,
    IconLibrary.tabler => "import 'package:tabler_icons_plus/tabler_icons_plus.dart';",
    IconLibrary.remix => "import 'package:remixicon/remixicon.dart';",
    IconLibrary.hugeicons => "import 'package:hugeicons/hugeicons.dart';",
    IconLibrary.iconoir => "import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;",
  };

  /// Maps [mapping] to the equivalent icon in this library, or null for the built-in Lucide.
  String? map(IconMapping mapping) => switch (this) {
    .lucide => null,
    .tabler => switch (mapping) {
      .arrowLeft => _tabler('arrowLeft', scale: 1.1),
      .calendar => _tabler('calendar', scale: 1.1),
      .check => _tabler('check', scale: 1.1),
      .chevronDown => _tabler('chevronDown'),
      .chevronLeft => _tabler('chevronLeft'),
      .chevronRight => _tabler('chevronRight'),
      .chevronUp => _tabler('chevronUp'),
      .chevronsUpDown => _tabler('selector', scale: 1.1),
      .circleAlert => _tabler('alertCircle', scale: 1.1),
      .clock4 => _tabler('clockHour4', scale: 1.1),
      .ellipsis => _tabler('dots'),
      .eye => _tabler('eye', scale: 1.1),
      .eyeClosed => _tabler('eyeOff'),
      .gripHorizontal => _tabler('gripHorizontal'),
      .gripVertical => _tabler('gripVertical'),
      .loader => _tabler('loader', scale: 1.1),
      .loaderCircle => _tabler('loader2'),
      .loaderPinwheel => _tabler('windmill', scale: 1.1),
      .search => _tabler('search'),
      .userRound => _tabler('userCircle'),
      .x => _tabler('x'),
    },
    .remix => switch (mapping) {
      .arrowLeft => _remix('arrow_left_line'),
      .calendar => _remix('calendar_line'),
      .check => _remix('check_line'),
      .chevronDown => _remix('arrow_down_s_line'),
      .chevronLeft => _remix('arrow_left_s_line'),
      .chevronRight => _remix('arrow_right_s_line'),
      .chevronUp => _remix('arrow_up_s_line'),
      .chevronsUpDown => _remix('expand_up_down_line'),
      .circleAlert => _remix('error_warning_line'),
      .clock4 => _remix('time_line'),
      .ellipsis => _remix('more_line'),
      .eye => _remix('eye_line'),
      .eyeClosed => _remix('eye_off_line'),
      // Remix only ships a vertical grip; rotate it a quarter turn for the horizontal slot.
      .gripHorizontal => _remix('draggable', rotated: true),
      .gripVertical => _remix('draggable'),
      .loader => _remix('loader_line'),
      .loaderCircle => _remix('loader_4_line'),
      .loaderPinwheel => _remix('loader_line'),
      .search => _remix('search_line'),
      .userRound => _remix('user_line'),
      .x => _remix('close_line'),
    },
    .hugeicons => switch (mapping) {
      .arrowLeft => _hugeicon('strokeRoundedArrowLeft01'),
      .calendar => _hugeicon('strokeRoundedCalendar03'),
      .check => _hugeicon('strokeRoundedTick02'),
      .chevronDown => _hugeicon('strokeRoundedArrowDown01'),
      .chevronLeft => _hugeicon('strokeRoundedArrowLeft01'),
      .chevronRight => _hugeicon('strokeRoundedArrowRight01'),
      .chevronUp => _hugeicon('strokeRoundedArrowUp01'),
      .chevronsUpDown => _hugeicon('strokeRoundedUnfoldMore'),
      .circleAlert => _hugeicon('strokeRoundedAlertCircle'),
      .clock4 => _hugeicon('strokeRoundedClock01'),
      .ellipsis => _hugeicon('strokeRoundedMoreHorizontal'),
      .eye => _hugeicon('strokeRoundedView'),
      .eyeClosed => _hugeicon('strokeRoundedViewOff'),
      .gripHorizontal => _hugeicon('strokeRoundedDragDropHorizontal'),
      .gripVertical => _hugeicon('strokeRoundedDragDropVertical'),
      // TODO: Replace with HugeIcons.strokeRoundedLoader once it is available.
      .loader => _hugeicon('strokeRoundedLoading03'),
      .loaderCircle => _hugeicon('strokeRoundedLoading03'),
      .loaderPinwheel => _hugeicon('strokeRoundedLoaderPinwheel'),
      .search => _hugeicon('strokeRoundedSearch01'),
      .userRound => _hugeicon('strokeRoundedUserCircle'),
      .x => _hugeicon('strokeRoundedCancel01'),
    },
    .iconoir => switch (mapping) {
      .arrowLeft => _iconoir('ArrowLeft'),
      .calendar => _iconoir('Calendar'),
      .check => _iconoir('Check'),
      .chevronDown => _iconoir('NavArrowDown'),
      .chevronLeft => _iconoir('NavArrowLeft'),
      .chevronRight => _iconoir('NavArrowRight'),
      .chevronUp => _iconoir('NavArrowUp'),
      .chevronsUpDown => _iconoir('ArrowSeparateVertical'),
      .circleAlert => _iconoir('WarningCircle'),
      .clock4 => _iconoir('Clock'),
      .ellipsis => _iconoir('MoreHoriz'),
      .eye => _iconoir('Eye'),
      .eyeClosed => _iconoir('EyeClosed'),
      .gripHorizontal => _iconoir('Drag'),
      .gripVertical => _iconoir('Drag'),
      .loader => _iconoir('OnePointCircle'),
      .loaderCircle => _iconoir('OnePointCircle'),
      .loaderPinwheel => _iconoir('ColorWheel'),
      .search => _iconoir('Search'),
      .userRound => _iconoir('UserCircle'),
      .x => _iconoir('Xmark'),
    },
  };
}
