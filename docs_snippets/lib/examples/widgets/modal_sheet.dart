import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

@RoutePage()
@Options(include: [Form])
class ModalSheetPage extends Example {
  ModalSheetPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => Row(
    mainAxisAlignment: .center,
    mainAxisSize: .min,
    spacing: 10,
    children: [
      FButton(
        variant: .outline,
        size: .sm,
        mainAxisSize: .min,
        child: const Text('Left'),
        onPress: () => showFSheet(
          context: context,
          side: .ltr,
          builder: (context) => const Form(side: .ltr),
        ),
      ),
      FButton(
        variant: .outline,
        size: .sm,
        mainAxisSize: .min,
        child: const Text('Top'),
        onPress: () => showFSheet(
          context: context,
          side: .ttb,
          builder: (context) => const Form(side: .ttb),
        ),
      ),
      FButton(
        variant: .outline,
        size: .sm,
        mainAxisSize: .min,
        child: const Text('Bottom'),
        onPress: () => showFSheet(
          context: context,
          side: .btt,
          builder: (context) => const Form(side: .btt),
        ),
      ),
      FButton(
        variant: .outline,
        size: .sm,
        mainAxisSize: .min,
        child: const Text('Right'),
        onPress: () => showFSheet(
          context: context,
          side: .rtl,
          builder: (context) => const Form(side: .rtl),
        ),
      ),
    ],
  );
}

@RoutePage()
@Options(include: [Form])
class BlurredModalSheetPage extends Example {
  BlurredModalSheetPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => Row(
    mainAxisAlignment: .end,
    spacing: 20,
    children: [
      FButton(
        variant: .outline,
        size: .sm,
        mainAxisSize: .min,
        child: const Text('Open'),
        onPress: () => showFSheet(
          style: .delta(
            // {@highlight}
            barrierFilter: (animation) => .compose(
              outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
              inner: ColorFilter.mode(context.theme.colors.barrier, .srcOver),
            ),
            // {@endhighlight}
          ),
          context: context,
          side: .rtl,
          builder: (context) => const Form(side: .rtl),
        ),
      ),
      Expanded(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: 8,
          children: [
            Text('Account Settings', style: context.theme.typography.lg.copyWith(fontWeight: .w600)),
            Text('Manage your preferences and profile details.', style: context.theme.typography.sm),
            const FDivider(),
            Row(
              spacing: 8,
              children: [
                FAvatar(image: const NetworkImage('https://picsum.photos/200'), fallback: const Text('JR')),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('John Renalo', style: context.theme.typography.sm.copyWith(fontWeight: .w600)),
                    Text('john@doe.com', style: context.theme.typography.xs),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class Form extends StatelessWidget {
  final FLayout side;

  const Form({required this.side, super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: .infinity,
    width: .infinity,
    decoration: BoxDecoration(
      color: context.theme.colors.background,
      border: side.vertical
          ? .symmetric(horizontal: BorderSide(color: context.theme.colors.border))
          : .symmetric(vertical: BorderSide(color: context.theme.colors.border)),
    ),
    child: Padding(
      padding: const .symmetric(horizontal: 15, vertical: 8.0),
      child: Center(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              'Account',
              style: context.theme.typography.xl2.copyWith(
                fontWeight: .w600,
                color: context.theme.colors.foreground,
                height: 1.5,
              ),
            ),
            Text(
              'Make changes to your account here. Click save when you are done.',
              style: context.theme.typography.sm.copyWith(color: context.theme.colors.mutedForeground),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 450,
              child: Column(
                children: [
                  const FTextField(label: Text('Name'), hint: 'John Renalo'),
                  const SizedBox(height: 12),
                  const FTextField(label: Text('Email'), hint: 'john@doe.com'),
                  const SizedBox(height: 20),
                  Align(
                    alignment: .centerRight,
                    child: FButton(
                      size: .sm,
                      mainAxisSize: .min,
                      child: const Text('Save'),
                      onPress: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

@RoutePage()
class DraggableModalSheetPage extends Example {
  DraggableModalSheetPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    child: const Text('Click me'),
    onPress: () => showFSheet(
      context: context,
      side: .btt,
      mainAxisMaxRatio: null,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, controller) => ScrollConfiguration(
          // This is required to enable dragging on desktop.
          // See https://github.com/flutter/flutter/issues/101903 for more information.
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {.touch, .mouse, .trackpad}),
          child: FTileGroup.builder(
            count: 25,
            scrollController: controller,
            tileBuilder: (context, index) => FTile(title: Text('Tile $index')),
          ),
        ),
      ),
    ),
  );
}
