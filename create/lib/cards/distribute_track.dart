import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'components/preview_card.dart';
import 'components/preview_icons.dart';

/// An empty state prompting the artist to upload.
class DistributeTrackCard extends StatelessWidget {
  /// Creates a [DistributeTrackCard].
  const DistributeTrackCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;

    return PreviewCard(
      child: Padding(
        padding: const .symmetric(vertical: 20),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: colors.muted, borderRadius: theme.style.borderRadius.lg),
              child: SizedBox.square(
                dimension: 48,
                child: Center(child: PreviewIcons.of(context).icon(.music, size: 22, color: colors.foreground)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Distribute Track',
              textAlign: .center,
              style: typography.body.lg.copyWith(color: colors.foreground, fontWeight: .w600),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const .symmetric(horizontal: 16),
              child: Text(
                'Upload your first master to start reaching listeners on Spotify, Apple Music, and more.',
                textAlign: .center,
                style: typography.body.sm.copyWith(color: colors.mutedForeground, height: 1.5),
              ),
            ),
            const SizedBox(height: 16),
            FButton(mainAxisSize: .min, onPress: () {}, child: const Text('Create Release')),
          ],
        ),
      ),
    );
  }
}
