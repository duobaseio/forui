import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class TileGroupPage extends Example {
  TileGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FTileGroup(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    children: [
      .tile(
        prefix: const Icon(FLucideIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FLucideIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Duobase (5G)'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class ScrollableTileGroupPage extends Example {
  ScrollableTileGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FTileGroup(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    maxHeight: 200,
    children: [
      .tile(
        prefix: const Icon(FLucideIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FLucideIcons.mail),
        title: const Text('Mail'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FLucideIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Duobase (5G)'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FLucideIcons.alarmClock),
        title: const Text('Alarm Clock'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FLucideIcons.qrCode),
        title: const Text('QR code'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class LazyTileGroupPage extends Example {
  LazyTileGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FTileGroup.builder(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    maxHeight: 200,
    count: 200,
    tileBuilder: (context, index) =>
        FTile(title: Text('Tile $index'), suffix: const Icon(FLucideIcons.chevronRight), onPress: () {}),
  );
}

@RoutePage()
class MergeTileGroupPage extends StatefulExample {
  MergeTileGroupPage({@queryParam super.theme});

  @override
  State<MergeTileGroupPage> createState() => _MergeTileGroupPageState();
}

class _MergeTileGroupPageState extends StatefulExampleState<MergeTileGroupPage> {
  @override
  Widget example(BuildContext context) => FTileGroup.merge(
    label: const Text('Settings'),
    children: [
      .group(
        children: [
          .tile(
            prefix: const Icon(FLucideIcons.user),
            title: const Text('Personalization'),
            suffix: const Icon(FLucideIcons.chevronRight),
            onPress: () {},
          ),
          .tile(
            prefix: const Icon(FLucideIcons.wifi),
            title: const Text('WiFi'),
            details: const Text('Duobase (5G)'),
            suffix: const Icon(FLucideIcons.chevronRight),
            onPress: () {},
          ),
        ],
      ),
      .selectGroup(
        control: const .managedRadio(initial: 'List'),
        children: const [
          FSelectTile(title: Text('List View'), value: 'List'),
          FSelectTile(title: Text('Grid View'), value: 'Grid'),
        ],
      ),
    ],
  );
}

@RoutePage()
class FullDividerTileGroupPage extends Example {
  FullDividerTileGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FTileGroup(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    // {@highlight}
    divider: .full,
    // {@endhighlight}
    children: [
      .tile(
        prefix: const Icon(FLucideIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FLucideIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Duobase (5G)'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class NoDividerTileGroupPage extends Example {
  NoDividerTileGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FTileGroup(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    // {@highlight}
    divider: .none,
    // {@endhighlight}
    children: [
      .tile(
        prefix: const Icon(FLucideIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FLucideIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Duobase (5G)'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}
