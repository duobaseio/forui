import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/text_field/text_field_control.dart';

part 'search_content.design.dart';

/// A builder for [FSelect] search results.
typedef FSelectSearchContentBuilder<T> = List<FSelectItemMixin> Function(
  BuildContext context,
  String query,
  Iterable<T> values,
);

@internal
class const SearchContent<T>({
  required final ScrollController? scrollController,
  required final FSelectSearchStyle searchStyle,
  required final FSelectContentStyle contentStyle,
  required final FSelectSearchFieldProperties properties,
  required final bool autofocusFirst,
  required final bool enabled,
  required final bool scrollHandles,
  required final ScrollPhysics physics,
  required final FItemDivider divider,
  required final bool Function(T) autofocus,
  required final FutureOr<Iterable<T>> Function(String query) filter,
  required final Widget Function(BuildContext context, FSelectSearchStyle style) loadingBuilder,
  required final FSelectSearchContentBuilder<T> builder,
  required final WidgetBuilder emptyBuilder,
  required final Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? errorBuilder,
  super.key,
}) extends StatefulWidget {
  @override
  State<SearchContent<T>> createState() => _SearchContentState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('searchStyle', searchStyle))
      ..add(DiagnosticsProperty('contentStyle', contentStyle))
      ..add(FlagProperty('first', value: autofocusFirst, ifTrue: 'first'))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('scrollHandles', scrollHandles))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(EnumProperty('divider', divider))
      ..add(ObjectFlagProperty.has('autofocus', autofocus))
      ..add(ObjectFlagProperty.has('filter', filter))
      ..add(ObjectFlagProperty.has('loadingBuilder', loadingBuilder))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('emptyBuilder', emptyBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder));
  }
}

class _SearchContentState<T> extends State<SearchContent<T>> {
  final FocusNode _focus = .new(debugLabel: 'search field');
  late TextEditingController _controller;
  late String _previous;
  late FutureOr<Iterable<T>> _data;

  @override
  void initState() {
    super.initState();
    _controller = widget.properties.control.create(_update);

    _previous = _controller.text;
    _data = widget.filter(_controller.text);
  }

  @override
  void didUpdateWidget(covariant SearchContent<T> old) {
    super.didUpdateWidget(old);
    final (controller, updated) = widget.properties.control.update(old.properties.control, _controller, _update);
    if (updated) {
      _controller = controller;
      _previous = _controller.text;
      _data = widget.filter(_controller.text);
    }
  }

  @override
  void dispose() {
    widget.properties.control.dispose(_controller, _update);
    _focus.dispose();
    super.dispose();
  }

  void _update() {
    if (_previous != _controller.text) {
      _previous = _controller.text;
      setState(() {
        // DO NOT TRY TO CONVERT THIS TO AN ARROW EXPRESSION. Doing so changes the return type to a future, which
        // results in an assertion error being thrown.
        _data = widget.filter(_controller.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final autofocusSearch = widget.properties.autofocus ?? context.platformVariant.desktop;

    return Column(
      mainAxisSize: .min,
      children: [
        CallbackShortcuts(
          bindings: {const SingleActivator(.enter): _focus.nextFocus},
          child: FTextField(
            control: .managed(controller: _controller, onChange: widget.properties.onChange),
            focusNode: _focus,
            style: widget.searchStyle.fieldStyles.resolve({widget.properties.size, context.platformVariant}),
            hint: widget.properties.hint ?? localizations.selectSearchHint,
            magnifierConfiguration: widget.properties.magnifierConfiguration,
            keyboardType: widget.properties.keyboardType,
            textInputAction: widget.properties.textInputAction,
            textCapitalization: widget.properties.textCapitalization,
            textAlign: widget.properties.textAlign,
            textAlignVertical: widget.properties.textAlignVertical,
            textDirection: widget.properties.textDirection,
            autofocus: autofocusSearch,
            autocorrect: widget.properties.autocorrect,
            smartDashesType: widget.properties.smartDashesType,
            smartQuotesType: widget.properties.smartQuotesType,
            enableSuggestions: widget.properties.enableSuggestions,
            minLines: widget.properties.minLines,
            maxLines: widget.properties.maxLines,
            readOnly: widget.properties.readOnly,
            showCursor: widget.properties.showCursor,
            maxLength: widget.properties.maxLength,
            maxLengthEnforcement: widget.properties.maxLengthEnforcement,
            onTap: widget.properties.onTap,
            onTapAlwaysCalled: widget.properties.onTapAlwaysCalled,
            onEditingComplete: widget.properties.onEditingComplete,
            onSubmit: widget.properties.onSubmit,
            inputFormatters: widget.properties.inputFormatters,
            enabled: widget.properties.enabled,
            ignorePointers: widget.properties.ignorePointers,
            enableInteractiveSelection: widget.properties.enableInteractiveSelection,
            selectionControls: widget.properties.selectionControls,
            dragStartBehavior: widget.properties.dragStartBehavior,
            mouseCursor: widget.properties.mouseCursor,
            scrollPhysics: widget.properties.scrollPhysics,
            scrollController: widget.properties.scrollController,
            autofillHints: widget.properties.autofillHints,
            restorationId: widget.properties.restorationId,
            stylusHandwritingEnabled: widget.properties.stylusHandwritingEnabled,
            enableIMEPersonalizedLearning: widget.properties.enableIMEPersonalizedLearning,
            contentInsertionConfiguration: widget.properties.contentInsertionConfiguration,
            contextMenuBuilder: widget.properties.contextMenuBuilder,
            undoController: widget.properties.undoController,
            spellCheckConfiguration: widget.properties.spellCheckConfiguration,
            prefixBuilder: widget.properties.prefixBuilder,
            suffixBuilder: widget.properties.suffixBuilder,
            clearable: widget.properties.clearable,
            clearIconBuilder: widget.properties.clearIconBuilder,
          ),
        ),
        FDivider(style: widget.searchStyle.dividerStyle),
        switch (_data) {
          final Iterable<T> data => _content(context, data, autofocusSearch: autofocusSearch),
          final Future<Iterable<T>> future => FutureBuilder(
            future: future,
            builder: (context, snapshot) => switch (snapshot.connectionState) {
              ConnectionState.waiting => Center(child: widget.loadingBuilder(context, widget.searchStyle)),
              _ when snapshot.hasError && widget.errorBuilder != null => widget.errorBuilder!.call(
                context,
                snapshot.error,
                snapshot.stackTrace!,
              ),
              _ => _content(context, snapshot.data ?? [], autofocusSearch: autofocusSearch),
            },
          ),
        },
      ],
    );
  }

  Widget _content(BuildContext context, Iterable<T> data, {required bool autofocusSearch}) {
    final children = widget.builder(context, _controller.text, data);
    if (children.isEmpty) {
      return widget.emptyBuilder(context);
    }

    return Flexible(
      child: Content<T>(
        controller: widget.scrollController,
        style: widget.contentStyle,
        enabled: widget.enabled,
        scrollHandles: widget.scrollHandles,
        physics: widget.physics,
        divider: widget.divider,
        autofocusFirst: widget.autofocusFirst && !autofocusSearch,
        autofocus: (value) => widget.autofocus(value) && !autofocusSearch,
        visible: widget.autofocus,
        children: children,
      ),
    );
  }
}

/// A [FSelect]'s search field style.
class FSelectSearchStyle with Diagnosticable, _$FSelectSearchStyleFunctions {
  /// The search field's size styles.
  @override
  final FTextFieldSizeStyles fieldStyles;

  /// The style of the divider between the search field and results.
  @override
  final FDividerStyle dividerStyle;

  /// The loading progress's style.
  @override
  final FCircularProgressStyle progressStyle;

  /// Creates a [FSelectSearchStyle].
  new({required this.fieldStyles, required this.dividerStyle, required this.progressStyle});

  /// Creates a [FSelectSearchStyle] that inherits its properties.
  factory inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required bool touch,
  }) {
    final styles = FTextFieldSizeStyles.inherit(colors: colors, typography: typography, style: style, touch: touch);
    return FSelectSearchStyle(
      fieldStyles: FTextFieldSizeStyles(
        styles.apply([
          .all(
            const .delta(
              color: FVariants.all(null),
              border: FVariants.all(OutlineInputBorder(borderSide: .none)),
            ),
          ),
        ]),
      ),
      dividerStyle: FDividerStyles.inherit(
        colors: colors,
        style: style,
      ).horizontal.copyWith(width: 2, padding: const .value(.zero)),
      progressStyle: FCircularProgressStyle.inherit(colors: colors),
    );
  }
}
