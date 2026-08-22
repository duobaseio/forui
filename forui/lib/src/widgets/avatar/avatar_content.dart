import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

@internal
class const Content({
  required final FAvatarStyleDelta style,
  required final double size,
  required final ImageProvider image,
  required final String? semanticsLabel,
  required final Widget? fallback,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fallback = this.fallback ?? PlaceholderContent(style: style, size: size);
    final duration = context.accessibility.motion == .disabled
        ? Duration.zero
        : style(context.theme.avatarStyle).fadeInDuration;

    return Image(
      height: size,
      width: size,
      image: image,
      semanticLabel: semanticsLabel,
      errorBuilder: (_, _, _) => fallback,
      frameBuilder: (_, child, frame, wasSynchronouslyLoaded) => wasSynchronouslyLoaded
          ? child
          : AnimatedSwitcher(duration: duration, child: frame == null ? fallback : child),
      loadingBuilder: (_, child, loadingProgress) => loadingProgress == null ? child : fallback,
      fit: BoxFit.cover,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('size', size))
      ..add(DiagnosticsProperty('image', image))
      ..add(StringProperty('semanticsLabel', semanticsLabel));
  }
}

@internal
class const PlaceholderContent({required final double size, required final FAvatarStyleDelta style, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resolved = style.call(context.theme.avatarStyle);
    return IconTheme(
      data: IconThemeData(size: size / 2, color: resolved.foregroundColor),
      child: resolved.fallbackIcon(context),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('size', size));
  }
}
