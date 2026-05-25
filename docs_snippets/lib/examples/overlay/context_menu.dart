import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class ContextMenuPage extends StatefulExample {
  ContextMenuPage({@queryParam super.theme});

  @override
  State<ContextMenuPage> createState() => _ContextMenuState();
}

class _ContextMenuState extends StatefulExampleState<ContextMenuPage> {
  @override
  void initState() {
    super.initState();
    unawaited(BrowserContextMenu.disableContextMenu());
  }

  @override
  void dispose() {
    unawaited(BrowserContextMenu.enableContextMenu());
    super.dispose();
  }

  @override
  Widget example(BuildContext context) => FContextMenu(
    menu: [
      .group(
        children: [
          .item(prefix: const Icon(FLucideIcons.scissors), title: const Text('Cut'), onPress: () {}),
          .item(prefix: const Icon(FLucideIcons.copy), title: const Text('Copy'), onPress: () {}),
          .item(prefix: const Icon(FLucideIcons.clipboardPaste), title: const Text('Paste'), onPress: () {}),
        ],
      ),
      .group(
        children: [.item(prefix: const Icon(FLucideIcons.textSelect), title: const Text('Select All'), onPress: () {})],
      ),
    ],
    child: Container(
      width: 350,
      height: 200,
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          side: BorderSide(color: context.theme.colors.border),
          borderRadius: context.theme.style.borderRadius.lg,
        ),
      ),
      alignment: .center,
      child: const Text('Right-click/long press here'),
    ),
  );
}

@RoutePage()
class NestedContextMenuPage extends StatefulExample {
  NestedContextMenuPage({@queryParam super.theme});

  @override
  State<NestedContextMenuPage> createState() => _NestedContextMenuState();
}

class _NestedContextMenuState extends StatefulExampleState<NestedContextMenuPage> {
  @override
  void initState() {
    super.initState();
    unawaited(BrowserContextMenu.disableContextMenu());
  }

  @override
  void dispose() {
    unawaited(BrowserContextMenu.enableContextMenu());
    super.dispose();
  }

  @override
  Widget example(BuildContext _) => FContextMenu(
    menu: [
      .group(
        children: [
          .item(prefix: const Icon(FLucideIcons.scissors), title: const Text('Cut'), onPress: () {}),
          .item(prefix: const Icon(FLucideIcons.copy), title: const Text('Copy'), onPress: () {}),
          .item(prefix: const Icon(FLucideIcons.clipboardPaste), title: const Text('Paste'), onPress: () {}),
          // {@highlight}
          .submenu(
            title: const Text('Share'),
            prefix: const Icon(FLucideIcons.share2),
            submenu: [
              .group(
                children: [
                  .item(prefix: const Icon(FLucideIcons.mail), title: const Text('Email'), onPress: () {}),
                  .item(prefix: const Icon(FLucideIcons.messageSquare), title: const Text('Message'), onPress: () {}),
                  .item(prefix: const Icon(FLucideIcons.link), title: const Text('Copy Link'), onPress: () {}),
                ],
              ),
            ],
          ),
          // {@endhighlight}
        ],
      ),
      .group(
        children: [.item(prefix: const Icon(FLucideIcons.textSelect), title: const Text('Select All'), onPress: () {})],
      ),
    ],
    child: Container(
      width: 350,
      height: 200,
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          side: BorderSide(color: context.theme.colors.border),
          borderRadius: context.theme.style.borderRadius.lg,
        ),
      ),
      alignment: .center,
      child: const Text('Right-click/long press here'),
    ),
  );
}

@RoutePage()
class TileContextMenuPage extends StatefulExample {
  TileContextMenuPage({@queryParam super.theme});

  @override
  State<TileContextMenuPage> createState() => _TileContextMenuState();
}

class _TileContextMenuState extends StatefulExampleState<TileContextMenuPage> {
  @override
  void initState() {
    super.initState();
    unawaited(BrowserContextMenu.disableContextMenu());
  }

  @override
  void dispose() {
    unawaited(BrowserContextMenu.enableContextMenu());
    super.dispose();
  }

  @override
  Widget example(BuildContext _) =>
      // {@highlight}
      FContextMenu.tiles(
        // {@endhighlight}
        menu: [
          .group(
            children: [
              .tile(prefix: const Icon(FLucideIcons.scissors), title: const Text('Cut'), onPress: () {}),
              .tile(prefix: const Icon(FLucideIcons.copy), title: const Text('Copy'), onPress: () {}),
              .tile(prefix: const Icon(FLucideIcons.clipboardPaste), title: const Text('Paste'), onPress: () {}),
            ],
          ),
          .group(
            children: [
              .tile(prefix: const Icon(FLucideIcons.textSelect), title: const Text('Select All'), onPress: () {}),
            ],
          ),
        ],
        child: Container(
          width: 350,
          height: 200,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              side: BorderSide(color: context.theme.colors.border),
              borderRadius: context.theme.style.borderRadius.lg,
            ),
          ),
          alignment: .center,
          child: const Text('Right-click/long press here'),
        ),
      );
}
