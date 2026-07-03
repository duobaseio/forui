import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

String path(String str) => kIsWeb ? 'assets/$str' : str;

const _slides = <Widget>[
  ColoredBox(color: Color(0xFF2563EB), child: Center(child: Text('Slide 1'))),
  ColoredBox(color: Color(0xFF16A34A), child: Center(child: Text('Slide 2'))),
  ColoredBox(color: Color(0xFFDC2626), child: Center(child: Text('Slide 3'))),
];

@RoutePage()
class CarouselPage extends Example {
  CarouselPage({@queryParam super.theme}) : super(maxWidth: 420);

  @override
  Widget example(BuildContext context) => FCarousel(children: _slides);
}

@RoutePage()
class NoIndicatorCarouselPage extends Example {
  NoIndicatorCarouselPage({@queryParam super.theme}) : super(maxWidth: 420);

  @override
  Widget example(BuildContext context) => FCarousel(
    // {@highlight}
    showIndicator: false,
    // {@endhighlight}
    children: _slides,
  );
}

@RoutePage()
class NoAutoPlayCarouselPage extends Example {
  NoAutoPlayCarouselPage({@queryParam super.theme}) : super(maxWidth: 420);

  @override
  Widget example(BuildContext context) => FCarousel(
    // {@highlight}
    autoPlay: null,
    // {@endhighlight}
    children: _slides,
  );
}

@RoutePage()
class ImageCarouselPage extends Example {
  ImageCarouselPage({@queryParam super.theme}) : super(maxWidth: 420);

  @override
  Widget example(BuildContext context) => FCarousel(
    children: [
      DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(path('avatar.png')), fit: .cover),
        ),
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(path('avatar.png')), fit: .cover),
          color: context.theme.colors.primary.withValues(alpha: 0.35),
          backgroundBlendMode: .multiply,
        ),
      ),
      ColoredBox(color: context.theme.colors.secondary),
    ],
  );
}
