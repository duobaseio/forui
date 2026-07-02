// ignore_for_file: missing_required_argument

import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';

// {@snippet}
final theme = FThemeData(
  colors: FColors.neutralLight,
  touch: false,
  icons: FIcons(
    arrowLeft: (_, {semanticsLabel}) => Builder(
      builder: (context) {
        final data = IconTheme.of(context);
        return SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          width: data.size,
          height: data.size,
          colorFilter: data.color == null ? null : ColorFilter.mode(data.color!, BlendMode.srcIn),
          semanticsLabel: semanticsLabel,
        );
      },
    ),
    // ... apply the same pattern to the rest of the icons.
  ),
);
// {@endsnippet}
