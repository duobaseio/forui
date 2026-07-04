import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'focused_outline.design.dart';

@internal
class FocusHighlightScope extends StatefulWidget {
  final Widget child;

  const FocusHighlightScope({required this.child, super.key});

  @override
  State<FocusHighlightScope> createState() => _FocusHighlightScopeState();
}

class _FocusHighlightScopeState extends State<FocusHighlightScope> {
  late bool _highlight;

  @override
  void initState() {
    super.initState();
    _highlight = FocusManager.instance.highlightMode == .traditional;
    FocusManager.instance.addHighlightModeListener(_onChange);
  }

  @override
  void dispose() {
    FocusManager.instance.removeHighlightModeListener(_onChange);
    super.dispose();
  }

  void _onChange(FocusHighlightMode mode) {
    final highlight = FocusManager.instance.highlightMode == .traditional;
    if (mounted && _highlight != highlight) {
      setState(() => _highlight = highlight);
    }
  }

  @override
  Widget build(BuildContext context) => FFocusHighlight(highlight: _highlight, child: widget.child);
}

/// Provides the current [FocusHighlightMode] down the widget tree.
class FFocusHighlight extends InheritedWidget {
  /// Returns whether a highlight should be applied to focused descendants.
  @useResult
  static bool of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FFocusHighlight>()!.highlight;

  /// True if a highlight should be applied to focused descendants.
  final bool highlight;

  /// Creates a [FFocusHighlight].
  const FFocusHighlight({required this.highlight, required super.child, super.key});

  @override
  bool updateShouldNotify(FFocusHighlight old) => highlight != old.highlight;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('highlight', value: highlight, ifTrue: 'highlight'));
  }
}

/// An outline around a focused widget that does not affect its layout.
///
/// See:
/// * https://forui.dev/docs/widgets/foundation/focused-outline for working examples.
/// * [FFocusedOutlineStyle] for customizing an outline.
class FFocusedOutline extends SingleChildRenderObjectWidget {
  /// The style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FFocusedOutlineStyle(...)
  /// ```
  final FFocusedOutlineStyleDelta style;

  /// True if the [child] should be outlined.
  final bool focused;

  /// Creates a [FFocusedOutline].
  const FFocusedOutline({required this.focused, required super.child, this.style = const .context(), super.key});

  @override
  RenderObject createRenderObject(BuildContext context) => _Outline(
    style(context.theme.style.focusedOutlineStyle),
    Directionality.maybeOf(context) ?? .ltr,
    focused: focused,
  );

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, _Outline outline) {
    outline
      ..style = style(context.theme.style.focusedOutlineStyle)
      ..textDirection = Directionality.maybeOf(context) ?? .ltr
      ..focused = focused;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('focused', value: focused, ifTrue: 'focused'));
  }
}

class _Outline extends RenderProxyBox {
  FFocusedOutlineStyle _style;
  TextDirection _textDirection;
  bool _focused;

  _Outline(this._style, this._textDirection, {required this._focused});

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
    if (focused) {
      final size = child!.size;
      final spacing = math.max(_style.spacing, -math.min(size.width, size.height) / 2);
      context.canvas.drawPath(
        RoundedSuperellipseBorder(
          borderRadius: _style.borderRadius.resolve(_textDirection),
        ).getOuterPath((offset & size).inflate(spacing), textDirection: _textDirection),
        Paint()
          ..style = .stroke
          ..color = _style.color
          ..strokeWidth = _style.width,
      );
    }
  }

  @override
  Rect get paintBounds => _focused ? child!.paintBounds.inflate(_style.spacing) : super.paintBounds;

  FFocusedOutlineStyle get style => _style;

  set style(FFocusedOutlineStyle value) {
    if (style != value) {
      _style = value;
      markNeedsPaint();
    }
  }

  TextDirection get textDirection => _textDirection;

  set textDirection(TextDirection value) {
    if (textDirection != value) {
      _textDirection = value;
      markNeedsPaint();
    }
  }

  bool get focused => _focused;

  set focused(bool value) {
    if (focused != value) {
      _focused = value;
      markNeedsPaint();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('focused', value: focused, ifTrue: 'focused'));
  }
}

/// The [FFocusedOutline]'s style.
class FFocusedOutlineStyle with Diagnosticable, _$FFocusedOutlineStyleFunctions {
  /// The outline's color.
  @override
  final Color color;

  /// The border radius.
  @override
  final BorderRadiusGeometry borderRadius;

  /// The outline's width. Defaults to 1.
  ///
  /// ## Contract
  /// Must be > 0.
  @override
  final double width;

  /// The spacing between the outline and the outlined widget. Can be negative. Defaults to 3.
  @override
  final double spacing;

  /// Creates a [FFocusedOutlineStyle].
  const FFocusedOutlineStyle({required this.color, required this.borderRadius, this.width = 1, this.spacing = 3})
    : assert(0 < width, 'width ($width) must be > 0.');
}
