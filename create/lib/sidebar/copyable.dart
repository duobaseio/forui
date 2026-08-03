import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Provides a copy callback and a `copied` flag that lights up for 2 seconds after the last copy.
class Copyable extends StatefulWidget {
  final String text;
  final Widget Function(BuildContext context, bool copied, VoidCallback copy) builder;

  const Copyable({required this.text, required this.builder, super.key});

  @override
  State<Copyable> createState() => _CopyableState();
}

class _CopyableState extends State<Copyable> {
  Timer? _revert;
  bool _copied = false;

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.text));
    setState(() => _copied = true);
    _revert?.cancel();
    _revert = Timer(const Duration(seconds: 2), () => setState(() => _copied = false));
  }

  @override
  void dispose() {
    _revert?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _copied, _copy);
}
