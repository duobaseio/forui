import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// The themes.
final themes = {'neutral-light': FTheme.neutral.light.desktop, 'neutral-dark': FTheme.neutral.dark.desktop};

abstract class Example extends StatelessWidget {
  final FThemeData theme;
  final Alignment alignment;
  final double maxWidth;
  final double maxHeight;
  final double top;

  Example({
    String theme = 'neutral-light',
    this.alignment = .center,
    this.maxWidth = 400,
    this.maxHeight = .infinity,
    this.top = 0,
  }) : theme = themes[theme]!;

  // FTheme is created in MaterialApp.builder(...) so that routes, i.e. dialogs and modal sheets, inherit from it.
  @override
  Widget build(BuildContext context) => FToaster(
    child: FScaffold(
      child: Align(
        alignment: alignment,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          child: Padding(
            padding: .only(top: top),
            child: Builder(builder: example),
          ),
        ),
      ),
    ),
  );

  Widget example(BuildContext context);
}

abstract class StatefulExample extends StatefulWidget {
  final FThemeData theme;
  final Alignment alignment;
  final double maxWidth;
  final double maxHeight;
  final double top;

  StatefulExample({
    String theme = 'neutral-light',
    this.alignment = .center,
    this.maxWidth = 400,
    this.maxHeight = .infinity,
    this.top = 0,
    super.key,
  }) : theme = themes[theme]!;
}

abstract class StatefulExampleState<T extends StatefulExample> extends State<T> {
  @override
  Widget build(BuildContext context) => FScaffold(
    child: Align(
      alignment: widget.alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: widget.maxWidth, maxHeight: widget.maxHeight),
        child: Padding(
          padding: .only(top: widget.top),
          child: Builder(builder: example),
        ),
      ),
    ),
  );

  Widget example(BuildContext context);
}
