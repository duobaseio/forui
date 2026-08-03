import 'dart:math';

import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter/widgets.dart' hide Radius;

import 'package:forui/forui.dart';
import 'package:forui_cli/forui_cli.dart';

import '../selection.dart';
import 'controls.dart';
import 'footer.dart';

/// The horizontal inset shared by the sidebar's sections.
const sidebarHInset = EdgeInsets.symmetric(horizontal: 16);

/// The sidebar.
class Sidebar extends StatelessWidget {
  static final _random = Random();

  final Selection selection;
  final ThemeMode mode;
  final ValueChanged<Selection> onChanged;
  final ValueChanged<ThemeMode> onModeChanged;

  final EdgeInsetsGeometry padding;

  const Sidebar({
    required this.selection,
    required this.mode,
    required this.onChanged,
    required this.onModeChanged,
    this.padding = const .fromLTRB(12, 0, 0, 12),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: padding,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: FSidebar(
          style: .delta(
            decoration: .value(
              BoxDecoration(
                color: theme.colors.background,
                borderRadius: theme.style.borderRadius.lg,
                border: Border.all(color: theme.colors.border),
                boxShadow: theme.style.shadow,
              ),
            ),
            constraints: const .tightFor(width: 248),
            contentPadding: .value(const .fromLTRB(0, 16, 0, 8)),
            footerPadding: .value(.zero),
          ),
          footer: Footer(
            selection: selection,
            mode: mode,
            onModeChanged: onModeChanged,
            onShuffle: _shuffle,
            onReset: () => onChanged(Selection.decode()),
            onLoad: onChanged,
          ),
          children: [
            for (final control in [
              BaseColorControl(
                value: selection.base,
                onChanged: (v) => onChanged(selection.copyWith(base: v)),
              ),
              PrimaryColorControl(
                base: selection.base,
                value: selection.primary,
                onChanged: (v) => onChanged(selection.copyWith(primary: v, clearPrimary: v == null)),
              ),
              FontControl(
                key: const ValueKey('preset-heading'),
                label: 'Heading',
                value: selection.display,
                onChanged: (v) => onChanged(selection.copyWith(display: v)),
              ),
              FontControl(
                key: const ValueKey('preset-font'),
                label: 'Font',
                value: selection.body,
                onChanged: (v) => onChanged(selection.copyWith(body: v)),
              ),
              IconLibraryControl(
                value: selection.icon,
                onChanged: (v) => onChanged(selection.copyWith(icon: v)),
              ),
              RadiusControl(
                value: selection.radius,
                onChanged: (v) => onChanged(selection.copyWith(radius: v)),
              ),
            ])
              Padding(padding: sidebarHInset.add(const .only(bottom: 16)), child: control),
          ],
        ),
      ),
    );
  }

  void _shuffle() {
    T pick<T>(List<T> values) => values[_random.nextInt(values.length)];
    onChanged(
      Selection(
        base: pick(BaseColor.values),
        primary: pick([null, ...PrimaryColor.values]),
        display: pick(FontFamily.values),
        body: pick(FontFamily.values),
        icon: pick(IconLibrary.values),
        radius: pick(Radius.values),
      ),
    );
  }
}
