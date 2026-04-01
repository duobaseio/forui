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
  final Future<void> Function() slidePressHapticFeedback;
  final CrossAxisAlignment alignment;
  final Widget? image;
  final Widget? title;
  final TextAlign titleTextAlign;
  final Widget? body;
  final TextAlign bodyTextAlign;
  final List<Widget> actions;

  const Content({
    required this.style,
    required this.slideableActions,
    required this.slidePressHapticFeedback,
    required this.alignment,
    required this.image,
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
        ?image,
        if (image != null && (title != null || body != null)) SizedBox(height: style.imageSpacing),
        if (title case final title?)
          Padding(
            padding: style.titlePadding,
            child: Semantics(
              container: true,
              child: DefaultTextStyle.merge(textAlign: titleTextAlign, style: style.titleTextStyle, child: title),
            ),
          ),
        if (title != null && body != null) SizedBox(height: style.titleSpacing),
        if (body case final body?)
          Flexible(
            child: Padding(
              padding: style.bodyPadding,
              child: Semantics(
                container: true,
                child: DefaultTextStyle.merge(textAlign: bodyTextAlign, style: style.bodyTextStyle, child: body),
              ),
            ),
          ),
        if ((image != null || title != null || body != null) && actions.isNotEmpty)
          SizedBox(height: style.contentSpacing),
        if (slideableActions)
          FTappableGroup(slidePressHapticFeedback: slidePressHapticFeedback, child: _actions(context))
        else
          _actions(context),
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
      ..add(ObjectFlagProperty.has('slidePressHapticFeedback', slidePressHapticFeedback))
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
    required super.slidePressHapticFeedback,
    required super.image,
    required super.title,
    required super.body,
    required super.actions,
    super.key,
  }) : super(alignment: .start, titleTextAlign: .start, bodyTextAlign: .start);

  @override
  Widget _actions(BuildContext context) => Row(
    mainAxisAlignment: .end,
    spacing: style.actionSpacing,
    children: style.expandActions ? [for (final action in actions) Expanded(child: action)] : actions,
  );
}

@internal
class VerticalContent extends Content {
  const VerticalContent({
    required super.style,
    required super.slideableActions,
    required super.slidePressHapticFeedback,
    required super.image,
    required super.title,
    required super.body,
    required super.actions,
    super.key,
  }) : super(alignment: .start, titleTextAlign: .start, bodyTextAlign: .start);

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

  /// The padding surrounding the content. Defaults to `EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 18)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The padding surrounding the title. Defaults to `EdgeInsets.symmetric(horizontal: 8)`.
  @override
  final EdgeInsetsGeometry titlePadding;

  /// The padding surrounding the body. Defaults to `EdgeInsets.symmetric(horizontal: 8)`.
  @override
  final EdgeInsetsGeometry bodyPadding;

  /// The spacing between the image and the title/body. Ignored if either is not provided. Defaults to 9.
  @override
  final double imageSpacing;

  /// The spacing between the title and the body. Ignored if either is not provided. Defaults to 9.
  @override
  final double titleSpacing;

  /// The spacing between the content (title/body) and the actions. Ignored if either is not provided. Defaults to 20.
  @override
  final double contentSpacing;

  /// The space between actions. Defaults to 10.
  @override
  final double actionSpacing;

  /// Whether each action expands to fill the available width. Defaults to true.
  @override
  final bool expandActions;

  /// Creates a [FDialogContentStyle].
  FDialogContentStyle({
    required this.titleTextStyle,
    required this.bodyTextStyle,
    this.padding = const .only(left: 16, right: 16, top: 18, bottom: 18),
    this.titlePadding = const .symmetric(horizontal: 8),
    this.bodyPadding = const .symmetric(horizontal: 8),
    this.imageSpacing = 9,
    this.titleSpacing = 9,
    this.contentSpacing = 20,
    this.actionSpacing = 10,
    this.expandActions = true,
  });
}
