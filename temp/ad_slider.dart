import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'ad.dart';

class AdSlider extends StatefulWidget {
  const AdSlider({required this.banners, super.key});

  final List<BannerAd> banners;

  @override
  State<AdSlider> createState() => _AdSliderState();
}

class _AdSliderState extends State<AdSlider> {
  static const _slideDuration = Duration(milliseconds: 450);
  static const _autoPlayInterval = Duration(seconds: 4);
  static const _height = 88.0;

  late final PageController _pageController;
  Timer? _autoPlayTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    if (widget.banners.length < 2) return;
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(_autoPlayInterval, (_) => _goToNext());
  }

  void _goToNext() {
    if (!mounted || widget.banners.isEmpty) return;
    final next = (_currentPage + 1) % widget.banners.length;
    _animateToPage(next);
  }

  Future<void> _animateToPage(int page) {
    return _pageController.animateToPage(
      page,
      duration: _slideDuration,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: _height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: widget.banners.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) =>
                    _BannerSlide(imageUrl: widget.banners[index].imageUrl),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _DotIndicator(
                  count: widget.banners.length,
                  index: _currentPage,
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

class _BannerSlide extends StatelessWidget {
  const _BannerSlide({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      gaplessPlayback: true,
      errorBuilder: (_, _, _) => ColoredBox(
        color: context.theme.colors.muted,
        child: const Center(child: Icon(FLucideIcons.imageOff, size: 28)),
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({
    required this.count,
    required this.index,
    required this.onDotTap,
  });

  final int count;
  final int index;
  final ValueChanged<int> onDotTap;

  static const _dotHeight = 5.0;
  static const _dotWidth = 5.0;
  static const _activeDotWidth = 16.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (i) {
          final isActive = i == index;
          return GestureDetector(
            onTap: () => onDotTap(i),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                width: isActive ? _activeDotWidth : _dotWidth,
                height: _dotHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_dotHeight),
                  color: isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.45),
                  boxShadow: const [
                    BoxShadow(blurRadius: 4, color: Colors.black26),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
