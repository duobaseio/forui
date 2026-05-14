import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class ItemGroupPage extends Example {
  ItemGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItemGroup(
    children: [
      FItem(
        prefix: const Icon(FLucideIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      FItem(
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
class ItemGroupIndentedPage extends Example {
  ItemGroupIndentedPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItemGroup(
    // {@highlight}
    divider: .indented,
    // {@endhighlight}
    children: [
      FItem(
        prefix: const Icon(FLucideIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      FItem(
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
class ItemGroupFullPage extends Example {
  ItemGroupFullPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItemGroup(
    // {@highlight}
    divider: .full,
    // {@endhighlight}
    children: [
      FItem(
        prefix: const Icon(FLucideIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      FItem(
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
class ScrollableItemGroupPage extends Example {
  ScrollableItemGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItemGroup(
    maxHeight: 150,
    children: [
      .item(
        prefix: const Icon(FLucideIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .item(
        prefix: const Icon(FLucideIcons.mail),
        title: const Text('Mail'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .item(
        prefix: const Icon(FLucideIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Duobase (5G)'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .item(
        prefix: const Icon(FLucideIcons.alarmClock),
        title: const Text('Alarm Clock'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
      .item(
        prefix: const Icon(FLucideIcons.qrCode),
        title: const Text('QR code'),
        suffix: const Icon(FLucideIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class LazyItemGroupPage extends Example {
  LazyItemGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItemGroup.builder(
    maxHeight: 200,
    count: 200,
    itemBuilder: (context, index) =>
        FItem(title: Text('Item $index'), suffix: const Icon(FLucideIcons.chevronRight), onPress: () {}),
  );
}

@RoutePage()
class MergeItemGroupPage extends Example {
  MergeItemGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItemGroup.merge(
    children: [
      .group(
        children: [
          .item(
            prefix: const Icon(FLucideIcons.user),
            title: const Text('Personalization'),
            suffix: const Icon(FLucideIcons.chevronRight),
            onPress: () {},
          ),
          .item(
            prefix: const Icon(FLucideIcons.wifi),
            title: const Text('WiFi'),
            details: const Text('Duobase (5G)'),
            suffix: const Icon(FLucideIcons.chevronRight),
            onPress: () {},
          ),
        ],
      ),
      .group(
        children: [
          .item(
            prefix: const Icon(FLucideIcons.list),
            title: const Text('List View'),
            suffix: const Icon(FLucideIcons.chevronRight),
            onPress: () {},
          ),
          .item(
            prefix: const Icon(FLucideIcons.grid2x2),
            title: const Text('Grid View'),
            suffix: const Icon(FLucideIcons.chevronRight),
            onPress: () {},
          ),
        ],
      ),
    ],
  );
}
