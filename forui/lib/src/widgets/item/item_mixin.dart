import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A marker interface which denotes that mixed-in widgets is an item.
mixin FItemMixin on Widget {
  /// {@macro forui.widgets.FItem.new}
  ///
  /// This function is a shorthand for [FItem.new].
  static FItem item({
    required Widget title,
    FItemVariant variant = .primary,
    FItemStyleDelta style = const .context(),
    bool? enabled,
    bool selected = false,
    String? semanticsLabel,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    FTappableVariantChangeCallback? onVariantChange,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    VoidCallback? onSecondaryPress,
    VoidCallback? onSecondaryLongPress,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    Widget? prefix,
    Widget? subtitle,
    Widget? details,
    Widget? suffix,
    Key? key,
  }) => .new(
    title: title,
    variant: variant,
    style: style,
    enabled: enabled,
    selected: selected,
    semanticsLabel: semanticsLabel,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
    onHoverChange: onHoverChange,
    onVariantChange: onVariantChange,
    onPress: onPress,
    onLongPress: onLongPress,
    onDoubleTap: onDoubleTap,
    onSecondaryPress: onSecondaryPress,
    onSecondaryLongPress: onSecondaryLongPress,
    shortcuts: shortcuts,
    actions: actions,
    prefix: prefix,
    subtitle: subtitle,
    details: details,
    suffix: suffix,
    key: key,
  );

  /// {@macro forui.widgets.FItem.raw}
  ///
  /// This function is a shorthand for [FItem.raw].
  static FItem raw({
    required Widget child,
    FItemVariant variant = .primary,
    FItemStyleDelta style = const .context(),
    bool? enabled,
    bool selected = false,
    String? semanticsLabel,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    FTappableVariantChangeCallback? onVariantChange,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    VoidCallback? onSecondaryPress,
    VoidCallback? onSecondaryLongPress,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    Widget? prefix,
    Key? key,
  }) => .raw(
    variant: variant,
    style: style,
    enabled: enabled,
    selected: selected,
    semanticsLabel: semanticsLabel,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
    onHoverChange: onHoverChange,
    onVariantChange: onVariantChange,
    onPress: onPress,
    onLongPress: onLongPress,
    onDoubleTap: onDoubleTap,
    onSecondaryPress: onSecondaryPress,
    onSecondaryLongPress: onSecondaryLongPress,
    shortcuts: shortcuts,
    actions: actions,
    prefix: prefix,
    key: key,
    child: child,
  );
}
