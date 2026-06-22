import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> with SingleTickerProviderStateMixin {
  static const List<ImageProvider> _images = [
    NetworkImage('https://i.pravatar.cc/300?img=12'),
    AssetImage(''),
    NetworkImage('https://i.pravatar.cc/300?img=33'),
    NetworkImage('https://i.pravatar.cc/300?img=58'),
    AssetImage(''),
  ];
  static const _fallbackTextStyle = TextStyle(fontSize: _avatarSize * 0.4, fontWeight: FontWeight.w500);

  static const List<Widget?> _fallbacks = [
    Text('AB', style: _fallbackTextStyle),
    Text('MK', style: _fallbackTextStyle),
    Text('EF', style: _fallbackTextStyle),
    Text('TS', style: _fallbackTextStyle),
    Text('JL', style: _fallbackTextStyle),
  ];

  static const _avatarSize = 120.0;
  static const _ringPadding = 6.0;
  static const _step = 72.0;
  static const _slideDistance = 360.0;

  static const _slideStartDelayMs = 480;
  static const _slideDurationMs = 600;
  static const _holdDurationMs = 5000;
  static const _fadeOutDurationMs = 600;
  static const _resetGapMs = 200;

  static const _count = 5;
  static const _fadeOutStartMs =
      (_count - 1) * _slideStartDelayMs + _slideDurationMs + _holdDurationMs;
  static const _totalMs = _fadeOutStartMs + _fadeOutDurationMs + _resetGapMs;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _totalMs),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringDiameter = _avatarSize + _ringPadding * 2;
    final stackWidth = ringDiameter + _step * (_images.length - 1);
    final ringColor = context.theme.colors.background;

    return Center(
      child: SizedBox(
        width: stackWidth,
        height: ringDiameter,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, _) {
            final elapsedMs = _controller.value * _totalMs;
            final fadeOut = ((elapsedMs - _fadeOutStartMs) / _fadeOutDurationMs).clamp(0.0, 1.0);

            return Stack(
              clipBehavior: .none,
              children: [
                for (var i = 0; i < _images.length; i++)
                  Positioned(
                    left: i * _step,
                    top: 0,
                    child: _buildAvatar(i, elapsedMs, fadeOut, ringDiameter, ringColor),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAvatar(int i, double elapsedMs, double fadeOut, double ringDiameter, Color ringColor) {
    final raw = ((elapsedMs - i * _slideStartDelayMs) / _slideDurationMs).clamp(0.0, 1.0);
    final eased = Curves.easeOutCubic.transform(raw);
    final dx = (1 - eased) * _slideDistance;
    final opacity = eased * (1 - fadeOut);

    return Opacity(
      opacity: opacity,
      child: Transform.translate(
        offset: Offset(dx, 0),
        child: Container(
          width: ringDiameter,
          height: ringDiameter,
          padding: const EdgeInsets.all(_ringPadding),
          decoration: BoxDecoration(shape: .circle, color: ringColor),
          child: FAvatar(
            image: _images[i],
            fallback: _fallbacks[i],
            size: _avatarSize,
          ),
        ),
      ),
    );
  }
}
