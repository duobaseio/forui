import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

String path(String str) => kIsWeb ? 'assets/$str' : str;

@RoutePage()
@Options(include: [Card])
class CardPage extends Example {
  CardPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => Card(
    title: const Text('Notifications'),
    subtitle: const Text('You have 3 unread messages.'),
    child: FButton(onPress: () {}, child: const Text('Mark all as read')),
  );
}

class Card extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget child;

  const Card({required this.title, required this.subtitle, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.theme.cardStyle;
    return FCard(
      style: style,
      child: Padding(
        padding: style.padding,
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.titleTextStyle,
              child: title,
            ),
            const SizedBox(height: 2),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.subtitleTextStyle,
              child: subtitle,
            ),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}

@RoutePage()
@Options(include: [TitleCard])
class TitleCardPage extends Example {
  TitleCardPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) =>
      const TitleCard(title: Text('Notifications'), subtitle: Text('You have 3 unread messages.'));
}

class TitleCard extends StatelessWidget {
  final Widget title;
  final Widget subtitle;

  const TitleCard({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.theme.cardStyle;
    return FCard(
      style: style,
      child: Padding(
        padding: style.padding,
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.titleTextStyle,
              child: title,
            ),
            const SizedBox(height: 2),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.subtitleTextStyle,
              child: subtitle,
            ),
          ],
        ),
      ),
    );
  }
}

@RoutePage()
@Options(include: [MediaCard])
class MediaCardPage extends Example {
  MediaCardPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => MediaCard(
    image: Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(path('avatar.png')), fit: .cover),
      ),
      height: 200,
    ),
    title: const Text('Gratitude'),
    subtitle: const Text('The quality of being thankful; readiness to show appreciation for and to return kindness.'),
    child: FButton(onPress: () {}, child: const Text('Read more')),
  );
}

class MediaCard extends StatelessWidget {
  final Widget image;
  final Widget title;
  final Widget subtitle;
  final Widget child;

  const MediaCard({required this.image, required this.title, required this.subtitle, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.theme.cardStyle;
    return FCard(
      style: style,
      child: Padding(
        padding: style.padding,
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedSuperellipseBorder(borderRadius: context.theme.style.borderRadius.lg),
              ),
              child: image,
            ),
            const SizedBox(height: 24),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.titleTextStyle,
              child: title,
            ),
            const SizedBox(height: 2),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.subtitleTextStyle,
              child: subtitle,
            ),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}
