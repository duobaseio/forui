import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/otp_field/caret.dart';

/// A marker interface which denotes that mixed-in widgets is an item in an OTP field.
mixin FOtpItemMixin on Widget {}

/// Provides the state of an individual item in an [FOtpField] to its descendants.
class FOtpItemScope extends InheritedWidget {
  /// Returns the [FOtpItemScope] from the enclosing [FOtpField].
  static FOtpItemScope of(BuildContext context) {
    assert(debugCheckHasAncestor<FOtpItemScope>('$FOtpField', context));
    return context.dependOnInheritedWidgetOfExactType<FOtpItemScope>()!;
  }

  /// The character to display, or null if the item is empty.
  final String? character;

  /// Whether this item is focused (i.e. the caret should be shown).
  final bool focused;

  /// Whether this item is the first in its group (e.g. the first item or the first item after a divider).
  final bool start;

  /// Whether this item is the last in its group (e.g. the last item or the last item before a divider).
  final bool end;

  /// Creates an [FOtpItemScope].
  const FOtpItemScope({
    required this.character,
    required this.focused,
    required this.start,
    required this.end,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FOtpItemScope old) =>
      character != old.character || focused != old.focused || start != old.start || end != old.end;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('character', character))
      ..add(FlagProperty('focused', value: focused, ifTrue: 'focused'))
      ..add(FlagProperty('start', value: start, ifTrue: 'start'))
      ..add(FlagProperty('end', value: end, ifTrue: 'end'));
  }
}

/// An item in an [FOtpField].
class FOtpItem extends StatefulWidget with FOtpItemMixin {
  /// Creates an [FOtpItem].
  const FOtpItem({super.key});

  @override
  State<FOtpItem> createState() => _FOtpItemState();
}

class _FOtpItemState extends State<FOtpItem> {
  late FOtpFieldStyle _style;
  late FPlatformVariant _platform;
  late String? _character;
  late bool _focused;
  late FOtpFieldItemStyle _itemStyle;
  late double _cursorHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final FOtpFieldScope(:style, :variants) = FOtpFieldScope.of(context);
    final FOtpItemScope(:character, :focused, :start, :end) = FOtpItemScope.of(context);

    _style = style;
    _platform = context.platformVariant;
    _character = character;
    _focused = focused;

    final itemVariants = <FVariant>{
      ...variants.difference({FTextFieldVariant.focused}),
      if (start) FOtpFieldItemVariant.start,
      if (end) FOtpFieldItemVariant.end,
      if (focused) FOtpFieldItemVariant.focused,
    };

    _itemStyle = style.itemStyles.resolve(itemVariants);

    final painter = TextPainter(
      text: TextSpan(text: ' ', style: _itemStyle.contentTextStyle),
      textDirection: .ltr,
    )..layout();

    _cursorHeight = painter.preferredLineHeight + (_platform == .iOS || _platform == .macOS ? 2 : -4);

    painter.dispose();
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
    // Adjacent items cause double borders. This is typically avoided by painting only the right border, but focused
    // items are an exception since one or many items can be focused at once.
    decoration: _itemStyle.decoration,
    child: SizedBox.fromSize(
      size: _style.itemSize,
      child: switch (_character) {
        final character? => Center(child: Text(character, style: _itemStyle.contentTextStyle)),
        _ when _focused => Center(
          child: Caret(
            color: _style.cursorColor,
            width: _style.cursorWidth,
            height: _cursorHeight,
            cursorOpacityAnimates: _style.cursorOpacityAnimates ?? (_platform == .iOS || _platform == .macOS),
          ),
        ),
        _ => null,
      },
    ),
  );
}

/// A divider between groups of items in an [FOtpField].
///
/// Does not mix in [FOtpItemMixin], so [FOtpController] treats it as a visual separator and uses it to determine
/// `start`/`end` boundaries on adjacent [FOtpItem]s.
class FOtpDivider extends StatelessWidget {
  /// Creates an [FOtpDivider].
  const FOtpDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final FOtpFieldScope(:style, :variants) = FOtpFieldScope.of(context);
    return Padding(
      padding: style.dividerPadding,
      child: SizedBox.fromSize(
        size: style.dividerSize,
        child: ColoredBox(color: style.dividerColor.resolve(variants)),
      ),
    );
  }
}
