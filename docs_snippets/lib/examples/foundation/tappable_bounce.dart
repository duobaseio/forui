import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

const _motions = {
  'Default': FTappableMotion(),
  'Heavy': FTappableMotion(bounceTween: FImmutableTween(begin: 1.0, end: 0.9)),
  'None': FTappableMotion.none,
};

@RoutePage()
@Options(include: [_motions])
class TappableBouncePage extends Example {
  TappableBouncePage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => Row(
    mainAxisSize: .min,
    spacing: 10,
    children: [
      for (final MapEntry(:key, :value) in _motions.entries)
        FTappable(
          // {@highlight}
          style: .delta(motion: value),
          // {@endhighlight}
          onPress: () {},
          builder: (context, states, child) => Container(
            decoration: BoxDecoration(
              color: states.contains(FTappableVariant.pressed)
                  ? context.theme.colors.secondary
                  : context.theme.colors.background,
              borderRadius: context.theme.style.borderRadius.base,
              border: .all(color: context.theme.colors.border),
            ),
            padding: const .symmetric(vertical: 8.0, horizontal: 12),
            child: child!,
          ),
          child: Text(key, style: context.theme.typography.sm),
        ),
    ],
  );
}
