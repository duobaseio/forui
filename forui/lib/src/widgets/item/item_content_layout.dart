import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';

@internal
class ItemContentLayout extends MultiChildRenderObjectWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double top;
  final double bottom;
  final Color? dividerForeground;
  final Color? dividerBackground;
  final double? dividerWidth;
  final FItemDivider dividerType;

  const ItemContentLayout({
    required this.margin,
    required this.padding,
    required this.top,
    required this.bottom,
    required this.dividerForeground,
    required this.dividerBackground,
    required this.dividerWidth,
    required this.dividerType,
    super.children,
    super.key,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    final direction = Directionality.maybeOf(context) ?? .ltr;
    return _RenderLayout(
      margin.resolve(direction),
      padding.resolve(direction),
      top,
      bottom,
      dividerForeground,
      dividerBackground,
      dividerWidth,
      dividerType,
      direction,
    );
  }

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, covariant _RenderLayout content) {
    final direction = Directionality.maybeOf(context) ?? .ltr;
    content
      ..margin = margin.resolve(direction)
      ..padding = padding.resolve(direction)
      ..top = top
      ..bottom = bottom
      ..dividerForeground = dividerForeground
      ..dividerBackground = dividerBackground
      ..dividerWidth = dividerWidth
      ..dividerType = dividerType
      ..textDirection = direction;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('margin', margin))
      ..add(DoubleProperty('top', top))
      ..add(DoubleProperty('bottom', bottom))
      ..add(ColorProperty('dividerForeground', dividerForeground))
      ..add(ColorProperty('dividerBackground', dividerBackground))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(EnumProperty('dividerType', dividerType));
  }
}

class _RenderLayout extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, DefaultData>, RenderBoxContainerDefaultsMixin<RenderBox, DefaultData> {
  EdgeInsets _margin;
  EdgeInsets _padding;
  double _top;
  double _bottom;
  Color? _dividerForeground;

  /// This is necessary when painting the space unoccupied by an indented divider.
  Color? _dividerBackground;
  double? _dividerWidth;
  FItemDivider _dividerType;
  TextDirection _textDirection;

  _RenderLayout(
    this._margin,
    this._padding,
    this._top,
    this._bottom,
    this._dividerForeground,
    this._dividerBackground,
    this._dividerWidth,
    this._dividerType,
    this._textDirection,
  );

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = DefaultData();

  @override
  double computeMinIntrinsicWidth(double height) {
    final EdgeInsets(:left, :right) = _padding;
    final prefix = firstChild!;
    final column = childAfter(prefix)!;
    final details = childAfter(column)!;
    final suffix = childAfter(details)!;
    return left +
        right +
        prefix.getMinIntrinsicWidth(height) +
        column.getMinIntrinsicWidth(height) +
        details.getMinIntrinsicWidth(height) +
        suffix.getMinIntrinsicWidth(height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final EdgeInsets(:left, :right) = _padding;
    final prefix = firstChild!;
    final column = childAfter(prefix)!;
    final details = childAfter(column)!;
    final suffix = childAfter(details)!;
    return left +
        right +
        prefix.getMaxIntrinsicWidth(height) +
        column.getMaxIntrinsicWidth(height) +
        details.getMaxIntrinsicWidth(height) +
        suffix.getMaxIntrinsicWidth(height);
  }

  @override
  void performLayout() {
    final EdgeInsets(:left, :top, :right, :bottom) = _padding;
    final prefix = firstChild!;
    final column = childAfter(prefix)!;
    final details = childAfter(column)!;
    final suffix = childAfter(details)!;

    // Layout children.
    var contentConstraints = constraints.loosen().copyWith(maxWidth: constraints.maxWidth - left - right);

    prefix.layout(contentConstraints, parentUsesSize: true);
    contentConstraints = contentConstraints.copyWith(maxWidth: contentConstraints.maxWidth - prefix.size.width);

    suffix.layout(contentConstraints, parentUsesSize: true);
    contentConstraints = contentConstraints.copyWith(maxWidth: contentConstraints.maxWidth - suffix.size.width);

    // Column takes priority if details is text, and vice-versa.
    final (first, last) = details is RenderParagraph ? (column, details) : (details, column);

    first.layout(contentConstraints, parentUsesSize: true);
    contentConstraints = contentConstraints.copyWith(maxWidth: contentConstraints.maxWidth - first.size.width);
    last.layout(contentConstraints, parentUsesSize: true);

    final height = [prefix.size.height, suffix.size.height, column.size.height, details.size.height].max;
    size = Size(constraints.maxWidth, height + top + bottom);

    // Position children.
    final (l, ml, mr, r) = _textDirection == TextDirection.ltr
        ? (prefix, column, details, suffix)
        : (suffix, details, column, prefix);

    l.data.offset = Offset(left, top + (height - l.size.height) / 2);
    ml.data.offset = Offset(left + l.size.width, top + (height - ml.size.height) / 2);
    mr.data.offset = Offset(
      constraints.maxWidth - right - r.size.width - mr.size.width,
      top + (height - mr.size.height) / 2,
    );
    r.data.offset = Offset(constraints.maxWidth - right - r.size.width, top + (height - r.size.height) / 2);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
    if (dividerType == FItemDivider.none) {
      return;
    }

    final EdgeInsets(:left, :top, :right, :bottom) = _padding;
    // The divider is offset by 0.5 instead of 1.0 due to some weird rendering bug/oddity where part of the line is
    // clipped when rendered exactly on the edge. This is reproducible on an iOS simulator & in golden tests.
    //
    // The divider's width doesn't need to be added as it isn't reflected in _margin but is is reflected in the FItem's
    // margin.
    final y = offset.dy + size.height + _margin.bottom + _bottom + 0.5;

    final paint = Paint()
      ..isAntiAlias = false
      ..color = _dividerForeground!
      ..strokeWidth = _dividerWidth!;

    if (_dividerType == .full) {
      context.canvas.drawLine(
        Offset(offset.dx - _margin.left, y),
        Offset(offset.dx + size.width + _margin.right, y),
        paint,
      );
      return;
    }

    final prefix = firstChild!;
    final spacing = _textDirection == .ltr ? left : right;

    if (_textDirection == .ltr) {
      if (_dividerBackground case final background?) {
        context.canvas.drawLine(
          Offset(offset.dx - _margin.left, y),
          Offset(offset.dx + spacing + prefix.size.width, y),
          paint..color = background,
        );
      }
      context.canvas.drawLine(
        Offset(offset.dx + spacing + prefix.size.width, y),
        Offset(offset.dx + size.width + _margin.right, y),
        paint..color = _dividerForeground!,
      );
    } else {
      context.canvas.drawLine(
        Offset(offset.dx - _margin.left, y),
        Offset(offset.dx + size.width - spacing - prefix.size.width, y),
        paint..color = _dividerForeground!,
      );
      if (_dividerBackground case final background?) {
        context.canvas.drawLine(
          Offset(offset.dx + size.width - spacing - prefix.size.width, y),
          Offset(offset.dx + size.width + _margin.right, y),
          paint..color = background,
        );
      }
    }
  }

  @override
  Rect get paintBounds =>
      Offset(_margin.left, _margin.top + _top) &
      Size(size.width + _margin.horizontal, size.height + _margin.vertical + _top + _bottom + (dividerWidth ?? 0));

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('margin', margin))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('top', top))
      ..add(DoubleProperty('bottom', bottom))
      ..add(ColorProperty('dividerForeground', dividerForeground))
      ..add(ColorProperty('dividerBackground', dividerBackground))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(EnumProperty('dividerType', dividerType))
      ..add(EnumProperty('textDirection', textDirection));
  }

  EdgeInsets get padding => _padding;

  set padding(EdgeInsets value) {
    if (_padding != value) {
      _padding = value;
      markNeedsLayout();
    }
  }

  EdgeInsets get margin => _margin;

  set margin(EdgeInsets value) {
    if (_margin != value) {
      _margin = value;
      markNeedsPaint();
    }
  }

  double get top => _top;

  set top(double value) {
    if (_top != value) {
      _top = value;
      markNeedsPaint();
    }
  }

  double get bottom => _bottom;

  set bottom(double value) {
    if (_bottom != value) {
      _bottom = value;
      markNeedsPaint();
    }
  }

  Color? get dividerForeground => _dividerForeground;

  set dividerForeground(Color? value) {
    if (_dividerForeground != value) {
      _dividerForeground = value;
      markNeedsPaint();
    }
  }

  Color? get dividerBackground => _dividerBackground;

  set dividerBackground(Color? value) {
    if (_dividerBackground != value) {
      _dividerBackground = value;
      markNeedsPaint();
    }
  }

  double? get dividerWidth => _dividerWidth;

  set dividerWidth(double? value) {
    if (_dividerWidth != value) {
      _dividerWidth = value;
      markNeedsPaint();
    }
  }

  FItemDivider get dividerType => _dividerType;

  set dividerType(FItemDivider value) {
    if (_dividerType != value) {
      _dividerType = value;
      markNeedsPaint();
    }
  }

  TextDirection get textDirection => _textDirection;

  set textDirection(TextDirection value) {
    if (_textDirection != value) {
      _textDirection = value;
      markNeedsLayout();
    }
  }
}
