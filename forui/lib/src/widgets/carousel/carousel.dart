import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/carousel/carousel_controller.dart';

/// A carousel displays a horizontally scrollable sequence of slides with optional page indicators.
///
/// See:
/// * https://forui.dev/docs/widgets/navigation/carousel for working examples.
/// * [FCarouselController] for customizing the carousel's behavior.
/// * [FCarouselStyle] for customizing the carousel's appearance.
class FCarousel extends StatefulWidget {
  /// The control that manages the carousel's state.
  final FCarouselControl control;

  /// The carousel's style.
  ///
  /// To modify the current style:
  /// ```dart
  /// style: .delta(...)
  /// ```
  ///
  /// To replace the style:
  /// ```dart
  /// style: FCarouselStyle(...)
  /// ```
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create carousel
  /// ```
  final FCarouselStyleDelta style;

  /// The slides.
  final List<Widget> children;

  /// Whether to show the page indicator. Defaults to true.
  ///
  /// The indicator is hidden when [children] contains fewer than 2 slides.
  final bool showIndicator;

  /// The interval between automatic slide changes.
  ///
  /// When null, automatic playback is disabled. Defaults to `Duration(seconds: 4)`.
  final Duration? autoPlay;

  /// The duration of the slide transition animation. Defaults to `Duration(milliseconds: 450)`.
  final Duration slideDuration;

  /// The curve of the slide transition animation. Defaults to [Curves.easeOutCubic].
  final Curve slideCurve;

  /// The fraction of the viewport that each slide occupies. Defaults to `1`.
  final double viewportFraction;

  /// How the carousel should respond to user input. Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// The carousel's width.
  ///
  /// When null, the carousel expands to fill the available horizontal space.
  final double? width;

  /// The carousel's height.
  ///
  /// When null, [FCarouselStyle.height] is used.
  final double? height;

  /// Whether to show previous and next navigation controls. Defaults to false.
  ///
  /// The controls are hidden when [children] contains fewer than 2 slides.
  final bool showControls;

  /// The previous slide button placed on the left side of the carousel.
  ///
  /// Defaults to an [FIcons.chevronLeft] icon.
  final Widget? previous;

  /// The next slide button placed on the right side of the carousel.
  ///
  /// Defaults to an [FIcons.chevronRight] icon.
  final Widget? next;

  /// Creates a [FCarousel].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [children] is empty.
  FCarousel({
    required this.children,
    this.control = const .managed(),
    this.style = const .context(),
    this.showIndicator = true,
    this.autoPlay = const Duration(seconds: 4),
    this.slideDuration = const Duration(milliseconds: 450),
    this.slideCurve = Curves.easeOutCubic,
    this.viewportFraction = 1,
    this.physics,
    this.width,
    this.height,
    this.showControls = false,
    this.previous,
    this.next,
    super.key,
  }) : assert(children.isNotEmpty, 'Must provide at least 1 slide.');

  @override
  State<FCarousel> createState() => _FCarouselState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(IterableProperty('children', children))
      ..add(FlagProperty('showIndicator', value: showIndicator, ifTrue: 'showIndicator'))
      ..add(DiagnosticsProperty('autoPlay', autoPlay))
      ..add(DiagnosticsProperty('slideDuration', slideDuration))
      ..add(DiagnosticsProperty('slideCurve', slideCurve))
      ..add(DoubleProperty('viewportFraction', viewportFraction))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('height', height))
      ..add(FlagProperty('showControls', value: showControls, ifTrue: 'showControls'))
      ..add(ObjectFlagProperty.has('previous', previous))
      ..add(ObjectFlagProperty.has('next', next));
  }
}

class _FCarouselState extends State<FCarousel> {
  late FCarouselController _controller;
  late PageController _pageController;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleChange);
    _controller.length = widget.children.length;
    _pageController = PageController(
      initialPage: _controller.value,
      viewportFraction: widget.viewportFraction,
    );
    _controller.addListener(_syncPage);
    _startAutoPlay();
  }

  @override
  void didUpdateWidget(covariant FCarousel old) {
    super.didUpdateWidget(old);
    _controller = widget.control.update(old.control, _controller, _handleChange).$1;
    _controller.length = widget.children.length;

    if (old.viewportFraction != widget.viewportFraction) {
      final page = _controller.value;
      _pageController.dispose();
      _pageController = PageController(initialPage: page, viewportFraction: widget.viewportFraction);
    }

    if (old.autoPlay != widget.autoPlay || old.children.length != widget.children.length) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _controller.removeListener(_syncPage);
    widget.control.dispose(_controller, _handleChange);
    _pageController.dispose();
    super.dispose();
  }

  void _handleChange() {
    if (widget.control case FCarouselManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  void _syncPage() {
    if (!_pageController.hasClients) {
      return;
    }

    final page = _pageController.page?.round();
    if (page != _controller.value) {
      _pageController.animateToPage(_controller.value, duration: widget.slideDuration, curve: widget.slideCurve);
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    if (widget.autoPlay case final interval? when widget.children.length > 1) {
      _autoPlayTimer = Timer.periodic(interval, (_) => _controller.next());
    }
  }

  void _animateToPage(int page) => _controller.value = page;

  @override
  Widget build(BuildContext context) {
    if (widget.children.isEmpty) {
      return const SizedBox.shrink();
    }

    final style = widget.style(context.theme.carouselStyle);
    final showIndicator = widget.showIndicator && widget.children.length > 1;
    final showControls = widget.showControls && widget.children.length > 1;

    return Padding(
      padding: style.padding,
      child: ClipRRect(
        borderRadius: style.borderRadius,
        child: SizedBox(
          width: widget.width,
          height: widget.height ?? style.height,
          child: Stack(
            fit: .expand,
            children: [
              PageView.builder(
                controller: _pageController,
                physics: widget.physics,
                itemCount: widget.children.length,
                onPageChanged: (index) {
                  if (_controller.value != index) {
                    _controller.value = index;
                  }
                },
                itemBuilder: (context, index) => widget.children[index],
              ),
              if (showControls) ...[
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child:
                        widget.previous ??
                        _Control(
                          style: style,
                          semanticsLabel:
                              (FLocalizations.of(context) ?? FDefaultLocalizations()).paginationPreviousSemanticsLabel,
                          onPress: _controller.previous,
                          child: context.theme.icons.chevronLeft(context),
                        ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child:
                        widget.next ??
                        _Control(
                          style: style,
                          semanticsLabel:
                              (FLocalizations.of(context) ?? FDefaultLocalizations()).paginationNextSemanticsLabel,
                          onPress: _controller.next,
                          child: context.theme.icons.chevronRight(context),
                        ),
                  ),
                ),
              ],
              if (showIndicator)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _Indicator(
                    controller: _controller,
                    style: style,
                    count: widget.children.length,
                    onDotTap: _animateToPage,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Control extends StatelessWidget {
  final FCarouselStyle style;
  final String semanticsLabel;
  final VoidCallback onPress;
  final Widget child;

  const _Control({
    required this.style,
    required this.semanticsLabel,
    required this.onPress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: style.controlPadding,
    child: FTappable(
      style: style.controlTappableStyle,
      semanticsLabel: semanticsLabel,
      focusedOutlineStyle: context.theme.style.focusedOutlineStyle,
      onPress: onPress,
      builder: (context, variants, child) => DecoratedBox(
        decoration: style.controlDecoration,
        child: ConstrainedBox(
          constraints: style.controlConstraints,
          child: Center(child: IconTheme(data: style.controlIconStyle, child: child!)),
        ),
      ),
      child: child,
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(StringProperty('semanticsLabel', semanticsLabel));
  }
}

class _Indicator extends StatelessWidget {
  final FCarouselController controller;
  final FCarouselStyle style;
  final int count;
  final ValueChanged<int> onDotTap;

  const _Indicator({
    required this.controller,
    required this.style,
    required this.count,
    required this.onDotTap,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(IntProperty('count', count))
      ..add(ObjectFlagProperty.has('onDotTap', onDotTap));
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final current = controller.value;
        return Padding(
          padding: style.indicatorPadding,
          child: Row(
            mainAxisAlignment: .center,
            children: List.generate(count, (i) {
              final active = i == current;
              return FTappable(
                style: style.indicatorTappableStyle,
                focusedOutlineStyle: context.theme.style.focusedOutlineStyle,
                onPress: () => onDotTap(i),
                builder: (context, variants, child) => Padding(
                  padding: .symmetric(horizontal: style.indicatorSpacing),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    width: active ? style.indicatorActiveDotWidth : style.indicatorDotWidth,
                    height: style.indicatorDotHeight,
                    decoration: BoxDecoration(
                      borderRadius: .circular(style.indicatorDotHeight),
                      color: active ? style.indicatorActiveColor : style.indicatorInactiveColor,
                      boxShadow: [style.indicatorShadow],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
}
