import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/select/content/scroll_handle.dart';

part 'content.design.dart';

@internal
class ContentData<T> extends InheritedWidget {
  static ContentData<T> of<T>(BuildContext context) {
    assert(debugCheckHasAncestor<ContentData<T>>('${FSelect<T>}/${FMultiSelect<T>}', context, generic: true));
    return context.dependOnInheritedWidgetOfExactType<ContentData<T>>()!;
  }

  final FSelectSectionStyle style;
  final bool enabled;
  final bool autofocusFirst;
  final bool Function(T) autofocus;
  final bool Function(T) visible;
  final ValueChanged<BuildContext> ensureVisible;

  const ContentData({
    required this.style,
    required this.enabled,
    required this.autofocusFirst,
    required this.autofocus,
    required this.visible,
    required this.ensureVisible,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(ContentData<T> old) =>
      style != old.style ||
      autofocusFirst != old.autofocusFirst ||
      enabled != old.enabled ||
      autofocus != old.autofocus ||
      visible != old.visible ||
      ensureVisible != old.ensureVisible;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('autofocus', autofocus))
      ..add(FlagProperty('autofocusFirst', value: autofocusFirst, ifTrue: 'autofocusFirst'))
      ..add(ObjectFlagProperty.has('visible', visible))
      ..add(ObjectFlagProperty.has('ensureVisible', ensureVisible));
  }
}

@internal
class Content<T> extends StatefulWidget {
  final ScrollController? controller;
  final FSelectContentStyle style;
  final bool enabled;
  final bool scrollHandles;
  final ScrollPhysics physics;
  final FItemDivider divider;
  final bool autofocusFirst;
  final bool Function(T) autofocus;
  final bool Function(T) visible;
  final List<FSelectItemMixin> children;

  const Content({
    required this.controller,
    required this.style,
    required this.enabled,
    required this.scrollHandles,
    required this.physics,
    required this.divider,
    required this.autofocusFirst,
    required this.autofocus,
    required this.visible,
    required this.children,
    super.key,
  });

  @override
  State<Content<T>> createState() => _ContentState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(FlagProperty('scrollHandles', value: scrollHandles, ifTrue: 'scroll handles'))
      ..add(FlagProperty('autofocusFirst', value: autofocusFirst, ifTrue: 'autofocusFirst'))
      ..add(ObjectFlagProperty.has('autofocus', autofocus))
      ..add(ObjectFlagProperty.has('visible', visible))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(EnumProperty('divider', divider));
  }
}

class _ContentState<T> extends State<Content<T>> {
  late ScrollController _controller;
  bool _up = false;
  bool _down = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? .new();
    _controller.addListener(_updateHandles);
  }

  @override
  void didUpdateWidget(covariant Content<T> old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller?.removeListener(_updateHandles);
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? .new();
      _controller.addListener(_updateHandles);
    }
  }

  void _updateHandles() {
    if (_controller.positions.isEmpty || !_controller.position.hasContentDimensions) {
      return;
    }

    final up = 0 < _controller.position.extentBefore;
    final down = 0 < _controller.position.extentAfter;
    if (up != _up || down != _down) {
      setState(() {
        _up = up;
        _down = down;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style.sectionStyle.itemStyle;
    Widget content = ContentData<T>(
      style: widget.style.sectionStyle,
      enabled: widget.enabled,
      autofocusFirst: false,
      autofocus: widget.autofocus,
      visible: widget.visible,
      ensureVisible: _ensureVisible,
      child: Padding(
        padding: widget.style.padding,
        // We use a SingleChildScrollView instead of a ListView as the latter lazily builds its children. Although great
        // for performance, this means that:
        // * The select will not scroll to the selected item if it far down the list when the select is opened.
        // * There is layout shifting when scrolling.
        //
        // Giving a ListView an increased cacheExtent did not fix the issue.
        child: SingleChildScrollView(
          controller: _controller,
          padding: .zero,
          physics: widget.physics,
          child: Column(
            mainAxisSize: .min,
            children: [
              if (widget.children.firstOrNull case final first?)
                ContentData<T>(
                  style: widget.style.sectionStyle,
                  enabled: widget.enabled,
                  autofocusFirst: widget.autofocusFirst,
                  autofocus: widget.autofocus,
                  visible: widget.visible,
                  ensureVisible: _ensureVisible,
                  child: FInheritedItemData(
                    data: FItemData(
                      styles: .all(style),
                      dividerColor: widget.style.sectionStyle.dividerColor.cast(),
                      dividerWidth: widget.style.sectionStyle.dividerWidth,
                      divider: widget.children.length == 1 ? FItemDivider.none : widget.divider,
                      enabled: widget.enabled,
                      last: widget.children.length == 1,
                      globalLast: widget.children.length == 1,
                    ),
                    child: first,
                  ),
                ),
              for (final (i, child) in widget.children.indexed.skip(1))
                FInheritedItemData(
                  data: FItemData(
                    styles: .all(style),
                    dividerColor: widget.style.sectionStyle.dividerColor.cast(),
                    dividerWidth: widget.style.sectionStyle.dividerWidth,
                    divider: i == widget.children.length - 1 ? FItemDivider.none : widget.divider,
                    enabled: widget.enabled,
                    index: i,
                    last: i == widget.children.length - 1,
                    globalLast: i == widget.children.length - 1,
                  ),
                  child: child,
                ),
            ],
          ),
        ),
      ),
    );

    if (widget.scrollHandles) {
      content = Stack(
        children: [
          NotificationListener<ScrollMetricsNotification>(
            onNotification: (_) {
              _updateHandles();
              return false;
            },
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: content,
            ),
          ),
          if (_up) ScrollHandle.up(controller: _controller, style: widget.style.scrollHandleStyle),

          if (_down) ScrollHandle.down(controller: _controller, style: widget.style.scrollHandleStyle),
        ],
      );
    }

    return content;
  }

  Future<void> _ensureVisible(BuildContext context) async {
    await Scrollable.ensureVisible(context);
    // There is an edge case, when at max scroll extent, the first visible item, if selected, remains partially obscured
    // by the scroll handle.
    if (widget.scrollHandles && 0 < _controller.offset && _controller.offset < _controller.position.maxScrollExtent) {
      _controller.jumpTo(_controller.offset - (widget.style.scrollHandleStyle.iconStyle.size ?? 0));
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateHandles);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// An [FSelect]'s contents style.
class FSelectContentStyle extends FPopoverStyle with Diagnosticable, _$FSelectContentStyleFunctions {
  /// A section's style.
  @override
  final FSelectSectionStyle sectionStyle;

  /// A scroll handle's style.
  @override
  final FSelectScrollHandleStyle scrollHandleStyle;

  /// The padding surrounding the content. Defaults to `const EdgeInsets.symmetric(vertical: 5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FSelectContentStyle].
  FSelectContentStyle({
    required this.sectionStyle,
    required this.scrollHandleStyle,
    required super.decoration,
    this.padding = const .symmetric(vertical: 5),
    super.barrierFilter,
    super.backgroundFilter,
    super.viewInsets,
  });

  /// Creates a [FSelectContentStyle] that inherits its properties.
  FSelectContentStyle.inherit({required super.colors, required super.style, required FTypography typography})
    : sectionStyle = .inherit(colors: colors, style: style, typography: typography),
      scrollHandleStyle = .inherit(colors: colors),
      padding = const .symmetric(vertical: 5),
      super.inherit();
}
