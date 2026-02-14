import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class ButtonPrimaryPage extends Example {
  ButtonPrimaryPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(mainAxisSize: .min, onPress: () {}, child: const Text('Button'));
}

@RoutePage()
class ButtonSecondaryPage extends Example {
  ButtonSecondaryPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    // {@highlight}
    variant: .secondary,
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonDestructivePage extends Example {
  ButtonDestructivePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    // {@highlight}
    variant: .destructive,
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonGhostPage extends Example {
  ButtonGhostPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    // {@highlight}
    variant: .ghost,
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonOutlinePage extends Example {
  ButtonOutlinePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    // {@highlight}
    variant: .outline,
    // {@endhighlight}
    mainAxisSize: .min,
    onPress: () {},
    child: const Text('Button'),
  );
}

@RoutePage()
class ButtonSizesPage extends Example {
  ButtonSizesPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => Column(
    mainAxisSize: .min,
    spacing: 20,
    children: [
      // {@highlight}
      Row(
        mainAxisSize: .min,
        spacing: 10,
        children: [
          FButton(variant: .outline, size: .xs, mainAxisSize: .min, onPress: () {}, child: const Text('xs')),
          FButton(variant: .outline, size: .sm, mainAxisSize: .min, onPress: () {}, child: const Text('sm')),
          FButton(variant: .outline, mainAxisSize: .min, onPress: () {}, child: const Text('base')),
          FButton(variant: .outline, size: .lg, mainAxisSize: .min, onPress: () {}, child: const Text('lg')),
        ],
      ),
      Row(
        mainAxisSize: .min,
        spacing: 10,
        children: [
          FButton.icon(size: .xs, onPress: () {}, child: const Icon(FIcons.chevronRight)),
          FButton.icon(size: .sm, onPress: () {}, child: const Icon(FIcons.chevronRight)),
          FButton.icon(onPress: () {}, child: const Icon(FIcons.chevronRight)),
          FButton.icon(size: .lg, onPress: () {}, child: const Icon(FIcons.chevronRight)),
        ],
      ),
      // {@endhighlight}
    ],
  );
}

@RoutePage()
class ButtonIconPage extends Example {
  ButtonIconPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    mainAxisSize: .min,
    // {@highlight}
    prefix: const Icon(FIcons.mail),
    // {@endhighlight}
    onPress: () {},
    child: const Text('Login with Email'),
  );
}

@RoutePage()
class ButtonOnlyIconPage extends Example {
  ButtonOnlyIconPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton.icon(child: const Icon(FIcons.chevronRight), onPress: () {});
}

@RoutePage()
class ButtonTogglePage extends StatefulExample {
  ButtonTogglePage({@queryParam super.theme});

  @override
  State<ButtonTogglePage> createState() => _ButtonTogglePageState();
}

class _ButtonTogglePageState extends StatefulExampleState<ButtonTogglePage> {
  bool _italic = false;

  @override
  Widget example(BuildContext _) => FButton(
    variant: .outline,
    size: .sm,
    mainAxisSize: .min,
    selected: _italic,
    onPress: () => setState(() => _italic = !_italic),
    prefix: const Icon(FIcons.italic),
    child: Text('Italic', style: TextStyle(decoration: _italic ? .underline : null)),
  );
}

@RoutePage()
class ButtonCircularProgressPage extends Example {
  ButtonCircularProgressPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FButton(
    mainAxisSize: .min,
    // {@highlight}
    prefix: const FCircularProgress(),
    // {@endhighlight}
    onPress: null,
    child: const Text('Please wait'),
  );
}
