import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class TappableGroupPage extends Example {
  TappableGroupPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FTappableGroup(
    child: Row(
      mainAxisSize: .min,
      spacing: 10,
      children: [
        for (final label in ['Copy', 'Cut', 'Paste'])
          FTappable(
            onPress: () {},
            builder: (context, states, child) => Container(
              decoration: BoxDecoration(
                color: states.contains(FTappableVariant.pressed)
                    ? context.theme.colors.secondary
                    : context.theme.colors.background,
                borderRadius: context.theme.style.borderRadius,
                border: .all(color: context.theme.colors.border),
              ),
              padding: const .symmetric(vertical: 8.0, horizontal: 12),
              child: child!,
            ),
            child: Text(label, style: context.theme.typography.sm),
          ),
      ],
    ),
  );
}
