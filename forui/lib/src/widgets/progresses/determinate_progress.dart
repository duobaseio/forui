import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'determinate_progress.design.dart';

/// A determinate linear progress indicator.
///
/// See:
/// * https://forui.dev/docs/widgets/feedback/progress for working examples.
/// * [FDeterminateProgressStyle] for customizing a progress's appearance.
/// * [FProgress] for for an indeterminate linear progress indicator.
/// * [FCircularProgress] for for an indeterminate circular progress indicator.
class FDeterminateProgress extends StatefulWidget {
  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FDeterminateProgressStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create determinate-progress
  /// ```
  final FDeterminateProgressStyleDelta style;

  /// The semantics label. Defaults to [FLocalizations.progressSemanticsLabel].
  final String? semanticsLabel;

  /// The progress value. Defaults to null.
  ///
  /// ## Contract
  /// Throw [AssertionError] if value is not between 0.0 and 1.0.
  final double value;

  /// Creates a determinate [FDeterminateProgress].
  const FDeterminateProgress({required this.value, this.style = const .context(), this.semanticsLabel, super.key})
    : assert((0.0 <= value && value <= 1.0), 'value ($value) must be between 0.0 and 1.0');

  @override
  State<FDeterminateProgress> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(PercentProperty('value', value));
  }
}

class _State extends State<FDeterminateProgress> with SingleTickerProviderStateMixin {
  FDeterminateProgressStyle? _style;
  FAccessibilityMotion? _motion;
  late AnimationController _controller;
  double? _target;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setup();
  }

  @override
  void didUpdateWidget(covariant FDeterminateProgress old) {
    super.didUpdateWidget(old);
    _setup();
  }

  void _setup() {
    final style = _style = widget.style(context.theme.determinateProgressStyle);
    final motion = context.accessibility.motion;
    if (_target != widget.value || _motion != motion) {
      _target = widget.value;
      _motion = motion;

      if (_motion == .disabled) {
        _controller.value = widget.value;
      } else {
        _controller.animateTo(widget.value, duration: style.motion.duration, curve: style.motion.curve);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return ConstrainedBox(
      constraints: _style!.constraints,
      child: Semantics(
        label: widget.semanticsLabel ?? localizations.progressSemanticsLabel,
        value: NumberFormat.percentPattern(localizations.localeName).format(widget.value),
        child: DecoratedBox(
          decoration: _style!.trackDecoration,
          child: Align(
            alignment: .centerStart,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, child) => FractionallySizedBox(widthFactor: _controller.value, child: child!),
              child: Container(decoration: _style!.fillDecoration),
            ),
          ),
        ),
      ),
    );
  }
}

/// A [FDeterminateProgress]'s style.
class FDeterminateProgressStyle with Diagnosticable, _$FDeterminateProgressStyleFunctions {
  /// The linear progress's constraints. Defaults to a height of 6.0 and no horizontal constraint.
  @override
  final BoxConstraints constraints;

  /// The track's decoration.
  @override
  final Decoration trackDecoration;

  /// The fill's decoration.
  @override
  final Decoration fillDecoration;

  /// The motion-related properties for an indeterminate [FDeterminateProgress].
  @override
  final FDeterminateProgressMotion motion;

  /// Creates a [FDeterminateProgressStyle].
  const FDeterminateProgressStyle({
    required this.trackDecoration,
    required this.fillDecoration,
    this.constraints = const .tightFor(height: 6.0),
    this.motion = const FDeterminateProgressMotion(),
  });

  /// Creates a [FDeterminateProgressStyle] that inherits its properties.
  FDeterminateProgressStyle.inherit({required FColors colors, required FStyle style})
    : this(
        trackDecoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.pill),
          color: colors.muted,
        ),
        fillDecoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius.pill),
          color: colors.primary,
        ),
      );
}

/// Motion-related properties for a [FDeterminateProgress].
///
/// All motion is automatically disabled when [FAccessibility.motion] is [FAccessibilityMotion.disabled].
class FDeterminateProgressMotion with Diagnosticable, _$FDeterminateProgressMotionFunctions {
  /// The animation's duration. Defaults to 1s.
  @override
  final Duration duration;

  /// The animation curve. Defaults to [Curves.linear].
  @override
  final Curve curve;

  /// Creates a [FDeterminateProgressMotion].
  const FDeterminateProgressMotion({this.duration = const Duration(milliseconds: 1000), this.curve = Curves.linear});
}
