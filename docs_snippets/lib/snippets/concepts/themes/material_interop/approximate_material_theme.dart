import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

@override
Widget build(BuildContext context) => MaterialApp(
  // {@highlight}
  theme: FTheme.neutral.light.touch.toApproximateMaterialTheme(),
  // {@endhighlight}
  home: Scaffold(
    body: Center(
      child: FCard(
        builder: (context, style, _) => Padding(
          padding: style.padding,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text('Mixed Widgets', style: style.titleTextStyle),
              const SizedBox(height: 2),
              Text('Using both Forui and Material widgets together', style: style.subtitleTextStyle),
              const SizedBox(height: 6),
              ElevatedButton(onPressed: () {}, child: const Text('Material Button')),
            ],
          ),
        ),
      ),
    ),
  ),
);
