import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'dialog_content.design.dart';

@internal
sealed class Content extends StatelessWidget {
  final FDialogContentStyle style;
  final bool slideableActions;
  final CrossAxisAlignment alignment;
  final Widget? title;
  final TextAlign titleTextAlign;
  final Widget? body;
  final TextAlign bodyTextAlign;
  final List<Widget> actions;

  const Content({
    required this.style,
    required this.slideableActions,
    required this.alignment,
    required this.title,
    required this.titleTextAlign,
    required this.body,
    required this.bodyTextAlign,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: style.padding,
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: alignment,
      children: [
        if (title case final title?)
          Padding(
            padding: .only(bottom: style.titleSpacing),
            child: Semantics(
              container: true,
              child: DefaultTextStyle.merge(textAlign: titleTextAlign, style: style.titleTextStyle, child: title),
            ),
          ),
        if (body case final body?)
          Flexible(
            child: Padding(
              padding: .only(bottom: style.bodySpacing),
              child: Semantics(
                container: true,
                child: DefaultTextStyle.merge(textAlign: bodyTextAlign, style: style.bodyTextStyle, child: body),
              ),
            ),
          ),
        if (title != null && body != null) SizedBox(height: style.contentSpacing),
        if (slideableActions) FTappableGroup(child: _actions(context)) else _actions(context),
      ],
    ),
  );

  Widget _actions(BuildContext context);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('slideableActions', value: slideableActions, ifTrue: 'slideableActions'))
      ..add(EnumProperty('alignment', alignment))
      ..add(EnumProperty('titleTextAlign', titleTextAlign))
      ..add(EnumProperty('bodyTextAlign', bodyTextAlign))
      ..add(IterableProperty('actions', actions));
  }
}

@internal
class HorizontalContent extends Content {
  const HorizontalContent({
    required super.style,
    required super.slideableActions,
    required super.title,
    required super.body,
    required super.actions,
    super.key,
  }) : super(alignment: .start, titleTextAlign: .start, bodyTextAlign: .start);

  @override
  Widget _actions(BuildContext context) =>
      Row(mainAxisAlignment: .end, spacing: style.actionSpacing, children: actions);
}

@internal
class VerticalContent extends Content {
  const VerticalContent({
    required super.style,
    required super.slideableActions,
    required super.title,
    required super.body,
    required super.actions,
    super.key,
  }) : super(alignment: .center, titleTextAlign: .center, bodyTextAlign: .center);

  @override
  Widget _actions(BuildContext context) => Column(mainAxisSize: .min, spacing: style.actionSpacing, children: actions);
}

/// [FDialog] content's style.
class FDialogContentStyle with Diagnosticable, _$FDialogContentStyleFunctions {
  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The body's [TextStyle].
  @override
  final TextStyle bodyTextStyle;

  /// The padding surrounding the content.
  @override
  final EdgeInsetsGeometry padding;

  /// The spacing below the title.
  @override
  final double titleSpacing;

  /// The spacing below the body.
  @override
  final double bodySpacing;

  /// The spacing between the content (title/body) and the actions. Defaults to 8.
  @override
  final double contentSpacing;

  /// The space between actions.
  @override
  final double actionSpacing;

  /// Creates a [FDialogContentStyle].
  FDialogContentStyle({
    required this.titleTextStyle,
    required this.bodyTextStyle,
    required this.padding,
    required this.titleSpacing,
    required this.bodySpacing,
    required this.actionSpacing,
    this.contentSpacing = 8,
  });
}
