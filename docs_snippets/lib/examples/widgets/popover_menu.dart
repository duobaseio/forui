// ignore_for_file: avoid_redundant_argument_values

import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class PopoverMenuPage extends Example {
  PopoverMenuPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FHeader(
    title: const Text('Edit Notes'),
    suffixes: [
      FPopoverMenu(
        autofocus: true,
        menuAnchor: .topRight,
        childAnchor: .bottomRight,
        menu: [
          .group(
            children: [
              .item(prefix: const Icon(FIcons.user), title: const Text('Personalization'), onPress: () {}),
              .item(prefix: const Icon(FIcons.paperclip), title: const Text('Add attachments'), onPress: () {}),
              .item(prefix: const Icon(FIcons.qrCode), title: const Text('Scan Document'), onPress: () {}),
            ],
          ),
          .group(
            children: [
              .item(prefix: const Icon(FIcons.list), title: const Text('List View'), onPress: () {}),
              .item(prefix: const Icon(FIcons.layoutGrid), title: const Text('Grid View'), onPress: () {}),
            ],
          ),
        ],
        builder: (_, controller, _) => FHeaderAction(icon: const Icon(FIcons.ellipsis), onPress: controller.toggle),
      ),
    ],
  );
}

@RoutePage()
class BlurredPopoverMenuPage extends Example {
  BlurredPopoverMenuPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => Column(
    mainAxisAlignment: .center,
    crossAxisAlignment: .end,
    children: [
      Column(
        crossAxisAlignment: .start,
        children: [
          Text('Layer Properties', style: context.theme.typography.xl.copyWith(fontWeight: .bold)),
          const SizedBox(height: 20),
          const FTextField(
            control: .managed(initial: TextEditingValue(text: 'Header Component')),
          ),
          const SizedBox(height: 16),
          const FTextField(
            control: .managed(initial: TextEditingValue(text: 'Navigation Bar')),
          ),
          const SizedBox(height: 30),
        ],
      ),
      FPopoverMenu(
        // {@highlight}
        style: .delta(
          barrierFilter: () => (animation) => ImageFilter.compose(
            outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
            inner: ColorFilter.mode(
              Color.lerp(const Color(0x00000000), const Color(0x33000000), animation)!,
              BlendMode.srcOver,
            ),
          ),
        ),
        // {@endhighlight}
        cutoutBuilder: FModalBarrier.defaultCutoutBuilder, // Replace this to create a custom cutout shape.
        autofocus: true,
        menuAnchor: .topRight,
        childAnchor: .bottomRight,
        menu: [
          .group(
            children: [
              .item(prefix: const Icon(FIcons.user), title: const Text('Personalization'), onPress: () {}),
              .item(prefix: const Icon(FIcons.paperclip), title: const Text('Add attachments'), onPress: () {}),
              .item(prefix: const Icon(FIcons.qrCode), title: const Text('Scan Document'), onPress: () {}),
            ],
          ),
          .group(
            children: [
              .item(prefix: const Icon(FIcons.list), title: const Text('List View'), onPress: () {}),
              .item(prefix: const Icon(FIcons.layoutGrid), title: const Text('Grid View'), onPress: () {}),
            ],
          ),
        ],
        builder: (_, controller, _) => FButton(
          variant: .outline,
          size: .sm,
          mainAxisSize: .min,
          onPress: controller.toggle,
          child: const Text('Open menu'),
        ),
      ),
    ],
  );
}

@RoutePage()
class TilePopoverMenuPage extends Example {
  TilePopoverMenuPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FHeader(
    title: const Text('Edit Notes'),
    suffixes: [
      // {@highlight}
      FPopoverMenu.tiles(
        // {@endhighlight}
        autofocus: true,
        menuAnchor: .topRight,
        childAnchor: .bottomRight,
        menu: [
          .group(
            children: [
              .tile(prefix: const Icon(FIcons.user), title: const Text('Personalization'), onPress: () {}),
              .tile(prefix: const Icon(FIcons.paperclip), title: const Text('Add attachments'), onPress: () {}),
              .tile(prefix: const Icon(FIcons.qrCode), title: const Text('Scan Document'), onPress: () {}),
            ],
          ),
          .group(
            children: [
              .tile(prefix: const Icon(FIcons.list), title: const Text('List View'), onPress: () {}),
              .tile(prefix: const Icon(FIcons.layoutGrid), title: const Text('Grid View'), onPress: () {}),
            ],
          ),
        ],
        builder: (_, controller, _) => FHeaderAction(icon: const Icon(FIcons.ellipsis), onPress: controller.toggle),
      ),
    ],
  );
}
