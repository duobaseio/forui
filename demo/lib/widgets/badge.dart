import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Badge extends StatefulWidget {
  const Badge({super.key});

  @override
  State<Badge> createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  static const List<FBadgeVariant> _variants = [.primary, .secondary, .outline, .destructive];
  static const List<String> _labels = ['Primary', 'Secondary', 'Outline', 'Destructive'];

  late Timer _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _index = (_index + 1) % _variants.length);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.92, end: 1.0).animate(animation),
              child: child,
            ),
          ),
          child: FBadge(
            key: ValueKey(_index),
            variant: _variants[_index],
            child: Text(_labels[_index]),
          ),
        ),
      ),
    );
  }
}
