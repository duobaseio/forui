import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';

/// A smart home control for a room's roller shade.
class SmartHomeCard extends StatelessWidget {
  /// Creates a [SmartHomeCard].
  const SmartHomeCard({super.key});

  @override
  Widget build(BuildContext context) => const _Shades();
}

class _Shades extends StatefulWidget {
  const _Shades();

  @override
  State<_Shades> createState() => _ShadesState();
}

class _ShadesState extends State<_Shades> {
  static const _presets = <(String, double)>[('Open', 0), ('Half', 0.5), ('Closed', 1)];

  double _position = 0.55;

  void _slide(FSliderValue value) => setState(() => _position = value.max);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final label = theme.typography.body.xs.copyWith(color: colors.mutedForeground, letterSpacing: 0.8);

    return PreviewCard(
      title: 'Living Room',
      subtitle: 'Roller Shades',
      footer: Row(
        children: [
          for (final (index, (name, preset)) in _presets.indexed) ...[
            if (index > 0) const SizedBox(width: 12),
            Expanded(
              child: FButton(
                variant: _position == preset ? .secondary : .outline,
                size: .sm,
                onPress: () => setState(() => _position = preset),
                child: Text(name),
              ),
            ),
          ],
        ],
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          _Window(position: _position),
          const SizedBox(height: 12),
          Padding(
            padding: const .only(top: 10, bottom: 6),
            child: Row(
              children: [
                SelectionContainer.disabled(child: Text('OPEN', style: label)),
                Expanded(
                  child: FSlider(
                    style: const .delta(childPadding: .value(.symmetric(horizontal: 20, vertical: 0))),
                    control: .liftedContinuous(
                      value: FSliderValue(max: _position),
                      onChange: _slide,
                    ),
                    tooltipControls: const .disabled(),
                  ),
                ),
                SelectionContainer.disabled(child: Text('CLOSE', style: label)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Window extends StatelessWidget {
  final double position;

  const _Window({required this.position});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final radius = theme.style.borderRadius.lg;

    return DecoratedBox(
      position: .foreground,
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: colors.border),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(color: colors.muted, borderRadius: radius),
        child: ClipRRect(
          borderRadius: radius,
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Align(
              alignment: .topCenter,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: position,
                child: ColoredBox(color: colors.mutedForeground.withValues(alpha: 0.45)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
