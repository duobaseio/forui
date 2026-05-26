import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class ItemPage extends Example {
  ItemPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    prefix: const Icon(FLucideIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FLucideIcons.chevronRight),
    // {@highlight}
    onPress: () {},
    // {@endhighlight}
  );
}

@RoutePage()
class ItemDestructivePage extends Example {
  ItemDestructivePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    // {@highlight}
    variant: .destructive,
    // {@endhighlight}
    prefix: const Icon(FLucideIcons.trash),
    title: const Text('Delete Account'),
    suffix: const Icon(FLucideIcons.chevronRight),
    onPress: () {},
  );
}

@RoutePage()
class ItemDisabledPage extends Example {
  ItemDisabledPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    // {@highlight}
    enabled: false,
    // {@endhighlight}
    prefix: const Icon(FLucideIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FLucideIcons.chevronRight),
    onPress: () {},
  );
}

@RoutePage()
class ItemUntappablePage extends Example {
  ItemUntappablePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    prefix: const Icon(FLucideIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FLucideIcons.chevronRight),
  );
}

@RoutePage()
class ItemSubtitlePage extends Example {
  ItemSubtitlePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    prefix: const Icon(FLucideIcons.bell),
    title: const Text('Notifications'),
    // {@highlight}
    subtitle: const Text('Banners, Sounds, Badges'),
    // {@endhighlight}
    suffix: const Icon(FLucideIcons.chevronRight),
    onPress: () {},
  );
}

@RoutePage()
class ItemDetailsPage extends Example {
  ItemDetailsPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    prefix: const Icon(FLucideIcons.wifi),
    title: const Text('WiFi'),
    // {@highlight}
    details: const Text('Duobase (5G)'),
    // {@endhighlight}
    suffix: const Icon(FLucideIcons.chevronRight),
    onPress: () {},
  );
}
