import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A Phosphor duotone icon's data.
class const FPhosphorDuotoneIconData({
  /// The foreground layer.
  required final IconData foreground,

  /// The background layer, drawn at [FPhosphorDuotoneIcon.backgroundOpacity]. Null for icons with only a foreground
  /// layer.
  final IconData? background,
}) {
  /// Creates a [FPhosphorDuotoneIconData].
  this;
}

/// A Phosphor duotone icon, composed of a translucent background layer beneath a foreground layer.
///
/// ```dart
/// FPhosphorDuotoneIcon(FPhosphorDuotoneIcons.acorn)
/// ```
class const FPhosphorDuotoneIcon(
  /// The icon to display.
  final FPhosphorDuotoneIconData icon, {

  /// The icon's size. Defaults to the current [IconTheme]'s size.
  final double? size,

  /// The icon's color. Defaults to the current [IconTheme]'s color.
  final Color? color,

  /// The background layer's opacity, relative to [color]'s opacity. Defaults to 0.2.
  final double backgroundOpacity = 0.2,

  /// The icon's semantic label.
  final String? semanticLabel,
  super.key,
}) extends StatelessWidget {
  /// Creates a [FPhosphorDuotoneIcon].
  this;

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    final color = this.color ?? theme.color ?? const Color(0xFF000000);
    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: Stack(
          children: [
            if (icon.background case final background?)
              Icon(background, size: size, color: color.withValues(alpha: color.a * backgroundOpacity)),
            Icon(icon.foreground, size: size, color: color),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DoubleProperty('size', size))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('backgroundOpacity', backgroundOpacity))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
