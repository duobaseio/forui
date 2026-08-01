// ignore_for_file: missing_required_argument

import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';

// {@snippet}
class SvgIcon implements FIcon {
  final String asset;

  const SvgIcon(this.asset);

  @override
  Widget call(BuildContext _, {String? semanticsLabel}) => Builder(
    builder: (context) {
      final data = IconTheme.of(context);
      return SvgPicture.asset(
        asset,
        width: data.size,
        height: data.size,
        colorFilter: data.color == null ? null : ColorFilter.mode(data.color!, BlendMode.srcIn),
        semanticsLabel: semanticsLabel,
      );
    },
  );

  @override
  bool operator ==(Object other) => identical(this, other) || other is SvgIcon && asset == other.asset;

  @override
  int get hashCode => asset.hashCode;
}

final theme = FThemeData(
  colors: FColors.neutralLight,
  touch: false,
  icons: const FIcons(
    arrowLeft: SvgIcon('assets/icons/arrow_left.svg'),
    // ... apply the same pattern to the rest of the icons.
  ),
);
// {@endsnippet}
