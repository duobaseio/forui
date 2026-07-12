import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

String path(String str) => kIsWeb ? 'assets/$str' : str;

@RoutePage()
@Options(include: [AdaptiveDialog])
class DialogPage extends Example {
  DialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: AdaptiveDialog(
          style: style,
          animation: animation,
          title: const Text('Are you absolutely sure?'),
          body: const Text(
            'This action cannot be undone. This will permanently delete your account and '
            'remove your data from our servers.',
          ),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              variant: .outline,
              size: .sm,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
@Options(include: [AdaptiveTitleDialog])
class AdaptiveTitleDialogPage extends Example {
  AdaptiveTitleDialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: AdaptiveTitleDialog(
          style: style,
          animation: animation,
          title: const Text('Are you absolutely sure?'),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              variant: .outline,
              size: .sm,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
@Options(include: [AdaptiveMediaDialog])
class AdaptiveMediaDialogPage extends Example {
  AdaptiveMediaDialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: AdaptiveMediaDialog(
          style: style,
          animation: animation,
          image: ClipRRect(
            borderRadius: context.theme.style.borderRadius.sm,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(path('avatar.png')), fit: .cover),
              ),
              height: 140,
            ),
          ),
          title: const Text('Gratitude'),
          body: const Text('The quality of being thankful; readiness to show appreciation for and to return kindness.'),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              variant: .outline,
              size: .sm,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
@Options(include: [HorizontalDialog])
class HorizontalDialogPage extends Example {
  HorizontalDialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: HorizontalDialog(
          style: style,
          animation: animation,
          title: const Text('Are you absolutely sure?'),
          body: const Text(
            'This action cannot be undone. This will permanently delete your account and '
            'remove your data from our servers.',
          ),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              variant: .outline,
              size: .sm,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
@Options(include: [HorizontalTitleDialog])
class HorizontalTitleDialogPage extends Example {
  HorizontalTitleDialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: HorizontalTitleDialog(
          style: style,
          animation: animation,
          title: const Text('Are you absolutely sure?'),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              variant: .outline,
              size: .sm,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
@Options(include: [HorizontalMediaDialog])
class HorizontalMediaDialogPage extends Example {
  HorizontalMediaDialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: HorizontalMediaDialog(
          style: style,
          animation: animation,
          image: ClipRRect(
            borderRadius: context.theme.style.borderRadius.sm,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(path('avatar.png')), fit: .cover),
              ),
              height: 140,
            ),
          ),
          title: const Text('Gratitude'),
          body: const Text('The quality of being thankful; readiness to show appreciation for and to return kindness.'),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              variant: .outline,
              size: .sm,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
@Options(include: [VerticalDialog])
class VerticalDialogPage extends Example {
  VerticalDialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: VerticalDialog(
          style: style,
          animation: animation,
          title: const Text('Are you absolutely sure?'),
          body: const Text(
            'This action cannot be undone. This will permanently delete your account and '
            'remove your data from our servers.',
          ),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              variant: .outline,
              size: .sm,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
@Options(include: [VerticalTitleDialog])
class VerticalTitleDialogPage extends Example {
  VerticalTitleDialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: VerticalTitleDialog(
          style: style,
          animation: animation,
          title: const Text('Are you absolutely sure?'),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              variant: .outline,
              size: .sm,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
@Options(include: [VerticalMediaDialog])
class VerticalMediaDialogPage extends Example {
  VerticalMediaDialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: VerticalMediaDialog(
          style: style,
          animation: animation,
          image: ClipRRect(
            borderRadius: context.theme.style.borderRadius.sm,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(path('avatar.png')), fit: .cover),
              ),
              height: 140,
            ),
          ),
          title: const Text('Gratitude'),
          body: const Text('The quality of being thankful; readiness to show appreciation for and to return kindness.'),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              variant: .outline,
              size: .sm,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
@Options(include: [VerticalDialog])
class BlurredDialogPage extends Example {
  BlurredDialogPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 10);

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      // {@highlight}
      routeStyle: .delta(
        barrierFilter: () =>
            (animation) => ImageFilter.compose(
              outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
              inner: ColorFilter.mode(context.theme.colors.barrier, .srcOver),
            ),
      ),
      // {@endhighlight}
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: VerticalDialog(
          style: style,
          animation: animation,
          title: const Text('Are you absolutely sure?'),
          body: const Text(
            'This action cannot be undone. This will permanently delete your account and '
            'remove your data from our servers.',
          ),
          actions: [
            FButton(size: .sm, child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
            FButton(
              size: .sm,
              variant: .outline,
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

class AdaptiveDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final Widget body;
  final List<Widget> actions;

  const AdaptiveDialog({
    required this.title,
    required this.body,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog.adaptive(
    style: style,
    animation: animation,
    horizontalBuilder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: touch ? const .only(left: 8, right: 8, bottom: 9) : const .only(bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
            ),
            Row(
              mainAxisAlignment: .end,
              spacing: touch ? 10 : 8,
              children: touch ? [for (final action in actions) Expanded(child: action)] : actions,
            ),
          ],
        ),
      );
    },
    verticalBuilder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: touch ? const .only(left: 8, right: 8, bottom: 9) : const .only(left: 8, right: 8, bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch
                    ? const .only(left: 8, right: 8, bottom: 20)
                    : const .only(left: 8, right: 8, bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
            ),
            Column(mainAxisSize: .min, spacing: touch ? 10 : 8, children: actions),
          ],
        ),
      );
    },
  );
}

class AdaptiveTitleDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final List<Widget> actions;

  const AdaptiveTitleDialog({
    required this.title,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog.adaptive(
    style: style,
    animation: animation,
    horizontalBuilder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(bottom: 16),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Row(
              mainAxisAlignment: .end,
              spacing: touch ? 10 : 8,
              children: touch ? [for (final action in actions) Expanded(child: action)] : actions,
            ),
          ],
        ),
      );
    },
    verticalBuilder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(left: 8, right: 8, bottom: 16),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Column(mainAxisSize: .min, spacing: touch ? 10 : 8, children: actions),
          ],
        ),
      );
    },
  );
}

class AdaptiveMediaDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget image;
  final Widget title;
  final Widget body;
  final List<Widget> actions;

  const AdaptiveMediaDialog({
    required this.image,
    required this.title,
    required this.body,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog.adaptive(
    style: style,
    animation: animation,
    horizontalBuilder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            image,
            Padding(
              padding: touch ? const .only(left: 8, right: 8, top: 9, bottom: 9) : const .only(top: 9, bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
            ),
            Row(
              mainAxisAlignment: .end,
              spacing: touch ? 10 : 8,
              children: touch ? [for (final action in actions) Expanded(child: action)] : actions,
            ),
          ],
        ),
      );
    },
    verticalBuilder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            image,
            Padding(
              padding: touch
                  ? const .only(left: 8, right: 8, top: 9, bottom: 9)
                  : const .only(left: 8, right: 8, top: 9, bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch
                    ? const .only(left: 8, right: 8, bottom: 20)
                    : const .only(left: 8, right: 8, bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
            ),
            Column(mainAxisSize: .min, spacing: touch ? 10 : 8, children: actions),
          ],
        ),
      );
    },
  );
}

class HorizontalDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final Widget body;
  final List<Widget> actions;

  const HorizontalDialog({
    required this.title,
    required this.body,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog(
    style: style,
    animation: animation,
    builder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: touch ? const .only(left: 8, right: 8, bottom: 9) : const .only(bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
            ),
            Row(
              mainAxisAlignment: .end,
              spacing: touch ? 10 : 8,
              children: touch ? [for (final action in actions) Expanded(child: action)] : actions,
            ),
          ],
        ),
      );
    },
  );
}

class HorizontalTitleDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final List<Widget> actions;

  const HorizontalTitleDialog({
    required this.title,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog(
    style: style,
    animation: animation,
    builder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(bottom: 16),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Row(
              mainAxisAlignment: .end,
              spacing: touch ? 10 : 8,
              children: touch ? [for (final action in actions) Expanded(child: action)] : actions,
            ),
          ],
        ),
      );
    },
  );
}

class HorizontalMediaDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget image;
  final Widget title;
  final Widget body;
  final List<Widget> actions;

  const HorizontalMediaDialog({
    required this.image,
    required this.title,
    required this.body,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog(
    style: style,
    animation: animation,
    builder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            image,
            Padding(
              padding: touch ? const .only(left: 8, right: 8, top: 9, bottom: 9) : const .only(top: 9, bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
            ),
            Row(
              mainAxisAlignment: .end,
              spacing: touch ? 10 : 8,
              children: touch ? [for (final action in actions) Expanded(child: action)] : actions,
            ),
          ],
        ),
      );
    },
  );
}

class VerticalDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final Widget body;
  final List<Widget> actions;

  const VerticalDialog({
    required this.title,
    required this.body,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog(
    style: style,
    animation: animation,
    builder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: touch ? const .only(left: 8, right: 8, bottom: 9) : const .only(left: 8, right: 8, bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch
                    ? const .only(left: 8, right: 8, bottom: 20)
                    : const .only(left: 8, right: 8, bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
            ),
            Column(mainAxisSize: .min, spacing: touch ? 10 : 8, children: actions),
          ],
        ),
      );
    },
  );
}

class VerticalTitleDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final List<Widget> actions;

  const VerticalTitleDialog({
    required this.title,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog(
    style: style,
    animation: animation,
    builder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: touch ? const .only(left: 8, right: 8, bottom: 20) : const .only(left: 8, right: 8, bottom: 16),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Column(mainAxisSize: .min, spacing: touch ? 10 : 8, children: actions),
          ],
        ),
      );
    },
  );
}

class VerticalMediaDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget image;
  final Widget title;
  final Widget body;
  final List<Widget> actions;

  const VerticalMediaDialog({
    required this.image,
    required this.title,
    required this.body,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog(
    style: style,
    animation: animation,
    builder: (context, style) {
      final touch = context.platformVariant.touch;
      return Padding(
        padding: touch
            ? const .symmetric(horizontal: 16, vertical: 18)
            : const .symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            image,
            Padding(
              padding: touch
                  ? const .only(left: 8, right: 8, top: 9, bottom: 9)
                  : const .only(left: 8, right: 8, top: 9, bottom: 5),
              child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
            ),
            Flexible(
              child: Padding(
                padding: touch
                    ? const .only(left: 8, right: 8, bottom: 20)
                    : const .only(left: 8, right: 8, bottom: 16),
                child: DefaultTextStyle.merge(style: style.bodyTextStyle, child: body),
              ),
            ),
            Column(mainAxisSize: .min, spacing: touch ? 10 : 8, children: actions),
          ],
        ),
      );
    },
  );
}
