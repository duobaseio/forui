// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class AlertPrimaryPage extends Example {
  AlertPrimaryPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => const FAlert(
    // {@highlight}
    variant: .primary,
    // {@endhighlight}
    title: Text('Heads Up!'),
    subtitle: Text('You can add components to your app using the cli.'),
  );
}

@RoutePage()
class AlertDestructivePage extends Example {
  AlertDestructivePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => const FAlert(
    // {@highlight}
    variant: .destructive,
    // {@endhighlight}
    title: Text('Heads Up!'),
    subtitle: Text('You can add components to your app using the cli.'),
  );
}
