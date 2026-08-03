import 'package:flutter/widgets.dart' hide Radius;

import 'package:forui/forui.dart';
import 'package:forui_cli/forui_cli.dart';
import 'package:hugeicons/hugeicons.dart' as hugeicons;
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:remixicon/remixicon.dart' as remix;
import 'package:tabler_icons_plus/tabler_icons_plus.dart' as tabler;

/// Pads a select field's prefix.
Widget fieldPrefix(Widget child) => Padding(padding: const .directional(start: 10, end: 2), child: child);

class _PresetSelect<T extends Option> extends StatelessWidget {
  final String label;
  final T value;
  final ValueChanged<T> onChanged;
  final Widget prefix;
  final List<FSelectItemMixin> children;

  const _PresetSelect({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.prefix,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FSelect<T>.rich(
    label: Text(label),
    fieldAnchor: .topEnd,
    format: (v) => v.name,
    control: .lifted(
      value: value,
      onChange: (v) {
        if (v != null) {
          onChanged(v);
        }
      },
    ),
    prefixBuilder: (context, style, _) => fieldPrefix(prefix),
    children: children,
  );
}

class BaseColorControl extends StatelessWidget {
  final BaseColor value;
  final ValueChanged<BaseColor> onChanged;

  const BaseColorControl({required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) => _PresetSelect<BaseColor>(
    key: const ValueKey('preset-base-color'),
    label: 'Base Color',
    value: value,
    onChanged: onChanged,
    prefix: _BaseSwatch(color: value),
    children: [
      for (final color in BaseColor.values)
        .item(
          prefix: _BaseSwatch(color: color),
          title: Text(color.name),
          value: color,
        ),
    ],
  );
}

class PrimaryColorControl extends StatelessWidget {
  final BaseColor base;
  final PrimaryColor? value;
  final ValueChanged<PrimaryColor?> onChanged;

  const PrimaryColorControl({required this.base, required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) => FSelect<_PrimaryOption>.rich(
    key: const ValueKey('preset-primary-color'),
    label: const Text('Primary Color'),
    fieldAnchor: .topEnd,
    format: (option) => option.color?.name ?? base.name, // A null primary inherits the base palette.
    control: .lifted(value: _PrimaryOption(value), onChange: (option) => onChanged(option?.color)),
    prefixBuilder: (context, style, _) {
      final color = value;
      return fieldPrefix(color == null ? _BaseSwatch(color: base) : _Swatch(color: Color(color.light.primary)));
    },
    contentDivider: .full,
    children: [
      FSelectItem<_PrimaryOption>(
        style: .delta(padding: .value(const .fromLTRB(4, 0, 4, 4))),
        prefix: _BaseSwatch(color: base),
        title: Text(base.name),
        value: const _PrimaryOption(null),
      ),
      FSelectSection<_PrimaryOption>.rich(
        style: .delta(labelPadding: .value(const .only(top: 4))),
        label: const SizedBox.shrink(),
        children: [
          for (final color in PrimaryColor.values)
            FSelectItem<_PrimaryOption>(
              prefix: _Swatch(color: Color(color.light.primary)),
              title: Text(color.name),
              value: _PrimaryOption(color),
            ),
        ],
      ),
    ],
  );
}

class _PrimaryOption {
  final PrimaryColor? color;

  const _PrimaryOption(this.color);

  @override
  bool operator ==(Object other) => other is _PrimaryOption && other.color == color;

  @override
  int get hashCode => color.hashCode;
}

/// A font select with options grouped by category and rendered in their own typefaces.
class FontControl extends StatelessWidget {
  final String label;
  final FontFamily value;
  final ValueChanged<FontFamily> onChanged;

  const FontControl({required this.label, required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) => _PresetSelect<FontFamily>(
    label: label,
    value: value,
    onChanged: onChanged,
    prefix: Text(
      'Aa',
      style: TextStyle(fontFamily: value.name, color: context.theme.colors.mutedForeground),
    ),
    children: [
      for (final category in FontFamilyCategory.values)
        .richSection(
          label: Text(switch (category) {
            .sans => 'Sans Serif',
            .serif => 'Serif',
            .mono => 'Monospace',
          }),
          children: [
            for (final font in FontFamily.values.where((f) => f.category == category))
              FSelectItem(
                title: Text(font.name, style: TextStyle(fontFamily: font.name)),
                value: font,
              ),
          ],
        ),
    ],
  );
}

class IconLibraryControl extends StatelessWidget {
  final IconLibrary value;
  final ValueChanged<IconLibrary> onChanged;

  const IconLibraryControl({required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colors.mutedForeground;
    return _PresetSelect<IconLibrary>(
      key: const ValueKey('preset-icon-library'),
      label: 'Icon Library',
      value: value,
      onChanged: onChanged,
      prefix: _libraryPreview(value, color),
      children: [
        for (final library in IconLibrary.values)
          .item(prefix: _libraryPreview(library, color), title: Text(library.name), value: library),
      ],
    );
  }
}

/// A representative house glyph rendered with each icon library.
Widget _libraryPreview(IconLibrary library, Color color) => switch (library) {
  .hugeicons => hugeicons.HugeIcon(icon: hugeicons.HugeIcons.strokeRoundedHome01, color: color, size: 18),
  .lucide => Icon(FLucideIcons.house, size: 18, color: color),
  .tabler => Icon(tabler.TablerIcons.home, size: 18, color: color),
  .remix => Icon(remix.RemixIcons.home_line, size: 18, color: color),
  .iconoir => SizedBox.square(dimension: 18, child: iconoir.Home(color: color, width: 18, height: 18)),
};

class RadiusControl extends StatelessWidget {
  final Radius value;
  final ValueChanged<Radius> onChanged;

  const RadiusControl({required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) => _PresetSelect<Radius>(
    key: const ValueKey('preset-radius'),
    label: 'Radius',
    value: value,
    onChanged: onChanged,
    prefix: _RadiusSwatch(radius: value.radius.md),
    children: [
      for (final radius in Radius.values)
        .item(
          prefix: _RadiusSwatch(radius: radius.radius.md),
          title: Text(radius.name),
          value: radius,
        ),
    ],
  );
}

/// A circular swatch filled with [color].
class _Swatch extends StatelessWidget {
  final Color color;

  const _Swatch({required this.color});

  @override
  Widget build(BuildContext context) => Container(
    width: 16,
    height: 16,
    decoration: BoxDecoration(
      color: color,
      shape: .circle,
      border: Border.all(color: context.theme.colors.border),
    ),
  );
}

/// A swatch for a base (default) palette.
class _BaseSwatch extends StatelessWidget {
  final BaseColor color;

  const _BaseSwatch({required this.color});

  @override
  Widget build(BuildContext context) {
    final palette = context.theme.colors.brightness == Brightness.dark ? color.dark : color.light;
    return _Swatch(color: Color(palette.muted));
  }
}

/// A radius swatch drawn as a single rounded corner representing a radius.
class _RadiusSwatch extends StatelessWidget {
  final double radius;

  const _RadiusSwatch({required this.radius});

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: const Size.square(16), painter: _RadiusPainter(radius, context.theme.colors.mutedForeground));
}

class _RadiusPainter extends CustomPainter {
  final double radius;
  final Color color;

  const _RadiusPainter(this.radius, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    const margin = 2.5;
    final near = margin;
    final far = size.shortestSide - margin;
    final inner = size.shortestSide - margin * 2;
    final scaledRadius = (radius / Radius.large.radius.md * inner).clamp(0.0, inner).toDouble();
    final paint = Paint()
      ..color = color
      ..style = .stroke
      ..strokeWidth = 1.5
      ..strokeCap = .round;
    final path = Path()
      ..moveTo(near, far)
      ..lineTo(near, near + scaledRadius)
      ..conicTo(near, near, near + scaledRadius, near, 0.7071067811865476)
      ..lineTo(far, near);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RadiusPainter old) => old.radius != radius || old.color != color;
}
