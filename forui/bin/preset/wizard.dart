import 'dart:io';

import 'package:forui/src/create/codec.dart';

import '../args/prompts.dart';

/// Interactively builds a [Preset] by prompting for each option, then prints its shareable code.
Preset wizard() {
  final base = pick<BaseColor>('Base color:', {'': BaseColor.values.named}, defaultValue: .neutral);
  final primary = pick<PrimaryColor?>('Primary color:', {
    '': {'None': null, ...PrimaryColor.values.named},
  }, defaultValue: null);

  final fonts = {
    'Sans': FontFamily.values.where((f) => f.category == .sans).named,
    'Serif': FontFamily.values.where((f) => f.category == .serif).named,
    'Mono': FontFamily.values.where((f) => f.category == .mono).named,
  };
  final display = pick<FontFamily>('Display font:', fonts, defaultValue: .inter);
  final body = pick<FontFamily>('Body font:', fonts, defaultValue: display);

  final icon = pick<IconLibrary>('Icon library:', {'': IconLibrary.values.named}, defaultValue: .lucide);
  final radius = pick<Radius>('Border radius:', {'': Radius.values.named}, defaultValue: .medium);

  final preset = Preset(base: base, primary: primary, display: display, body: body, icon: icon, radius: radius);
  final encoded = preset.encode();

  stdout
    ..writeln('Your preset: $encoded')
    ..writeln('Use "--preset $encoded" to regenerate this theme, or edit it at https://create.forui.dev.')
    ..writeln();

  return preset;
}
