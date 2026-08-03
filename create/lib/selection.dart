import 'package:forui_cli/forui_cli.dart';

/// The current theme-builder selection.
class Selection {
  final BaseColor base;
  final PrimaryColor? primary;
  final FontFamily display;
  final FontFamily body;
  final IconLibrary icon;
  final Radius radius;

  const Selection({
    required this.base,
    required this.primary,
    required this.display,
    required this.body,
    required this.icon,
    required this.radius,
  });

  /// Decodes [code] into the selection it represents.
  ///
  /// A `null` [code] returns the default selection. Throws a [FormatException] if [code] is unrecognised.
  factory Selection.decode([String? code]) {
    final preset = Preset.decode(code);
    return Selection(
      base: preset.base,
      primary: preset.primary,
      display: preset.display,
      body: preset.body,
      icon: preset.icon,
      radius: preset.radius,
    );
  }

  /// Returns a copy with the given fields replaced.
  ///
  /// Pass [clearPrimary] to set [primary] back to null.
  Selection copyWith({
    BaseColor? base,
    PrimaryColor? primary,
    bool clearPrimary = false,
    FontFamily? display,
    FontFamily? body,
    IconLibrary? icon,
    Radius? radius,
  }) => Selection(
    base: base ?? this.base,
    primary: clearPrimary ? null : (primary ?? this.primary),
    display: display ?? this.display,
    body: body ?? this.body,
    icon: icon ?? this.icon,
    radius: radius ?? this.radius,
  );

  /// Encodes this selection into its compact code, the inverse of [Selection.decode].
  String encode() =>
      Preset(base: base, primary: primary, display: display, body: body, icon: icon, radius: radius).encode();
}
