import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/picker/picker.dart';

class _ScrollBehavior extends ScrollBehavior {
  static final _devices = PointerDeviceKind.values.toSet();

  const _ScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => _devices;
}

/// A marker interface that indicates that a widget is a picker wheel.
mixin FPickerWheelMixin on Widget {}

/// A picker wheel that displays a list of items that can be scrolled vertically.
///
/// It should only be used in a [FPicker].
abstract class FPickerWheel extends StatefulWidget with FPickerWheelMixin {
  /// Estimates the extent of each item in the picker based on the given [style] and [context].
  static double estimateExtent(FPickerStyle style, BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final scale = MediaQuery.textScalerOf(context);

    final height = style.textStyle.height ?? defaultTextStyle.style.height;
    final fontSize = style.textStyle.fontSize ?? defaultTextStyle.style.fontSize ?? 0;
    return scale.scale(height == null ? fontSize : height * fontSize);
  }

  /// The flex factor to use for this child.
  ///
  /// If zero, the child is inflexible and determines its own size. If non-zero, the amount of space the child can
  /// occupy in the main axis is determined by dividing the free space (after placing the inflexible children) according
  /// to the flex factors of the flexible children.
  ///
  /// Defaults to 1.
  final int flex;

  /// The extent of each item in the picker. Defaults to the height of the picker's text style, scaled by the current
  /// [TextScaler].
  final double? itemExtent;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// Builds the value announced by screen readers for the item at the given index, e.g. "3".
  ///
  /// Defaults to null.
  final String Function(int index)? semanticsValueBuilder;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// Creates a picker wheel with the given children.
  const factory FPickerWheel({
    required List<Widget> children,
    bool loop,
    int flex,
    double? itemExtent,
    String? semanticsLabel,
    String Function(int index)? semanticsValueBuilder,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    Key? key,
  }) = ListWheel;

  /// Creates a picker wheel with the given builder.
  const factory FPickerWheel.builder({
    required IndexedWidgetBuilder builder,
    int flex,
    double? itemExtent,
    String? semanticsLabel,
    String Function(int index)? semanticsValueBuilder,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    Key? key,
  }) = BuilderWheel;

  const FPickerWheel._({
    this.flex = 1,
    this.itemExtent,
    this.semanticsLabel,
    this.semanticsValueBuilder,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('flex', flex))
      ..add(DoubleProperty('itemExtent', itemExtent))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(ObjectFlagProperty.has('semanticsValueBuilder', semanticsValueBuilder))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

abstract class _State<T extends FPickerWheel> extends State<T> {
  bool _focused = false;
  FixedExtentScrollController? _controller;
  late ValueNotifier<int> _index;

  @override
  void initState() {
    super.initState();
    _focused = widget.autofocus;
    _index = ValueNotifier(0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = PickerData.of(context).controller;
    if (_controller != controller) {
      _controller = controller;
      _index.value = controller.initialItem;
    }
  }

  @override
  void dispose() {
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PickerData(:style) = .of(context);
    final motion = context.accessibility.motion;
    final extent = widget.itemExtent ?? FPickerWheel.estimateExtent(style, context);

    Widget wheel = ScrollConfiguration(
      behavior: const _ScrollBehavior(),
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        physics: const FixedExtentScrollPhysics(),
        itemExtent: extent,
        diameterRatio: style.diameterRatio,
        magnification: style.magnification,
        squeeze: style.squeeze,
        overAndUnderCenterOpacity: style.overAndUnderCenterOpacity,
        childDelegate: delegate(style),
        onSelectedItemChanged: (index) {
          style.hapticFeedback();
          _index.value = index;
        },
      ),
    );

    if (widget.semanticsValueBuilder case final value?) {
      wheel = ValueListenableBuilder<int>(
        valueListenable: _index,
        builder: (_, selected, child) => Semantics(
          container: true,
          excludeSemantics: true,
          label: widget.semanticsLabel,
          value: value(selected),
          increasedValue: value(clamp(selected + 1)),
          decreasedValue: value(clamp(selected - 1)),
          onIncrease: () => _adjust(motion, 1),
          onDecrease: () => _adjust(motion, -1),
          child: child,
        ),
        child: wheel,
      );
    } else if (widget.semanticsLabel case final label?) {
      wheel = Semantics(container: true, label: label, child: wheel);
    }

    Widget detector = FocusableActionDetector(
      descendantsAreFocusable: false,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onFocusChange: (focused) {
        widget.onFocusChange?.call(focused);
        if (_focused != focused) {
          setState(() => _focused = focused);
        }
      },
      shortcuts: const {
        SingleActivator(.arrowUp): ScrollIntent(direction: .up),
        SingleActivator(.arrowDown): ScrollIntent(direction: .down),
      },
      actions: {
        ScrollIntent: CallbackAction<ScrollIntent>(
          onInvoke: (intent) {
            _adjust(motion, intent.direction == .up ? -1 : 1);
            return null;
          },
        ),
      },
      child: Stack(
        alignment: .center,
        children: [
          if (_focused && context.accessibility.focusHighlight)
            Container(
              height: extent,
              decoration: ShapeDecoration(
                shape: RoundedSuperellipseBorder(
                  side: BorderSide(color: style.focusedOutlineStyle.color, width: style.focusedOutlineStyle.width),
                  borderRadius: style.focusedOutlineStyle.borderRadius,
                ),
              ),
            ),
          wheel,
        ],
      ),
    );

    // Merge into a single adjustable node so screen readers announce it once, not twice (the focus node's computed name
    // and then the value node). Unmerged behavior is flaky.
    if (widget.semanticsValueBuilder != null) {
      detector = MergeSemantics(child: detector);
    }

    return Flexible(flex: widget.flex, child: detector);
  }

  void _adjust(FAccessibilityMotion motion, int delta) {
    final target = _controller!.selectedItem + delta;
    if (motion == .all) {
      _controller!.animateToItem(target, duration: const Duration(milliseconds: 100), curve: Curves.decelerate);
    } else {
      _controller!.jumpToItem(target);
    }
  }

  ListWheelChildDelegate delegate(FPickerStyle style);

  int clamp(int index);
}

@internal
class ListWheel extends FPickerWheel {
  final bool loop;
  final List<Widget> children;

  const ListWheel({
    required this.children,
    this.loop = false,
    super.flex = 1,
    super.itemExtent,
    super.semanticsLabel,
    super.semanticsValueBuilder,
    super.autofocus,
    super.focusNode,
    super.onFocusChange,
    super.key,
  }) : super._();

  @override
  State<StatefulWidget> createState() => _ListState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('loop', value: loop, ifTrue: 'loop'));
  }
}

class _ListState extends _State<ListWheel> {
  @override
  ListWheelChildDelegate delegate(FPickerStyle style) {
    final children = [
      for (final child in widget.children)
        Center(
          child: DefaultTextStyle.merge(
            textHeightBehavior: style.textHeightBehavior,
            style: style.textStyle,
            child: Semantics(inMutuallyExclusiveGroup: true, child: child),
          ),
        ),
    ];

    return widget.loop
        ? ListWheelChildLoopingListDelegate(children: children)
        : ListWheelChildListDelegate(children: children);
  }

  @override
  int clamp(int index) {
    final length = widget.children.length;
    if (length == 0) {
      return 0;
    }

    return widget.loop ? index % length : index.clamp(0, length - 1);
  }
}

@internal
class BuilderWheel extends FPickerWheel {
  final IndexedWidgetBuilder builder;

  const BuilderWheel({
    required this.builder,
    super.flex,
    super.itemExtent,
    super.semanticsLabel,
    super.semanticsValueBuilder,
    super.autofocus,
    super.focusNode,
    super.onFocusChange,
    super.key,
  }) : super._();

  @override
  State<BuilderWheel> createState() => _BuilderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('builder', builder));
  }
}

class _BuilderState extends _State<BuilderWheel> {
  @override
  ListWheelChildDelegate delegate(FPickerStyle style) => ListWheelChildBuilderDelegate(
    builder: (context, index) => Center(
      child: DefaultTextStyle.merge(
        textHeightBehavior: style.textHeightBehavior,
        style: style.textStyle,
        child: widget.builder(context, index),
      ),
    ),
  );

  @override
  int clamp(int index) => index;
}
