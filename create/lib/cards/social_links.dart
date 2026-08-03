import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';
import 'components/preview_icons.dart';

/// An artist's social link.
class SocialLinksCard extends StatelessWidget {
  /// Creates a [SocialLinksCard].
  const SocialLinksCard({super.key});

  @override
  Widget build(BuildContext context) => PreviewCard(
    title: 'Social Links',
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        const _Field(label: 'Spotify Artist URL', icon: .music, initial: 'spotify.com/artist/3j...2k'),
        const SizedBox(height: 16),
        const _Field(label: 'Instagram Handle', icon: .camera, initial: '@julianduryea_music'),
        const SizedBox(height: 16),
        const _Field(label: 'SoundCloud URL', icon: .cloud, hint: 'soundcloud.com/username'),
        const SizedBox(height: 16),
        const _Field(label: 'Website', icon: .globe, hint: 'https://yoursite.com'),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: .end,
          children: [
            FButton(variant: .secondary, mainAxisSize: .min, onPress: () {}, child: const Text('Discard')),
            const SizedBox(width: 8),
            FButton(mainAxisSize: .min, onPress: () {}, child: const Text('Save Changes')),
          ],
        ),
      ],
    ),
  );
}

class _Field extends StatelessWidget {
  final String label;
  final PreviewIcon icon;

  final String? initial;
  final String? hint;

  const _Field({required this.label, required this.icon, this.initial, this.hint});

  @override
  Widget build(BuildContext context) => FTextField(
    prefixBuilder: (_, _, _) => Padding(
      padding: const .directional(start: 12, end: 6),
      child: PreviewIcons.of(context).icon(icon, size: 16, color: context.theme.colors.mutedForeground),
    ),
    control: .managed(initial: TextEditingValue(text: initial ?? '')),
    label: Text(label),
    hint: hint,
    keyboardType: .url,
  );
}
