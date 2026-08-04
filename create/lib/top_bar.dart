import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:http/http.dart' as http;
import 'package:remixicon/remixicon.dart' as remix;
import 'package:url_launcher/url_launcher.dart';

/// The number of GitHub stars, or null if they could not be fetched.
final Future<int?> _stars = () async {
  try {
    final response = await http.get(Uri.parse('https://api.github.com/repos/duobaseio/forui'));
    if (response.statusCode != 200) {
      return null;
    }

    return switch (jsonDecode(response.body)) {
      {'stargazers_count': final int stars} => stars,
      _ => null,
    };
  } on Exception {
    return null;
  }
}();

void _openGitHub() => launchUrl(Uri.parse('https://github.com/duobaseio/forui'));

/// Abbreviates a star count, e.g. 1234 -> '1.2k'.
String abbreviate(int stars) {
  if (stars < 1000) {
    return '$stars';
  }

  final tenths = (stars / 100).round();
  if (tenths < 100 && tenths % 10 != 0) {
    return '${tenths ~/ 10}.${tenths % 10}k';
  }

  return '${(stars / 1000).round()}k';
}

/// The header.
class TopBar extends StatelessWidget {
  /// Opens the sidebar sheet.
  ///
  /// Should be null on wide layouts where the sidebar is inline.
  final VoidCallback? onMenu;

  const TopBar({this.onMenu, super.key});

  @override
  Widget build(BuildContext context) {
    final compact = onMenu != null;

    return Padding(
      padding: compact ? const .all(8) : const .fromLTRB(26, 8, 20, 12),
      child: Row(
        spacing: 8,
        children: [
          if (onMenu case final onMenu?)
            FButton.icon(
              key: const ValueKey('menu'),
              variant: .ghost,
              onPress: onMenu,
              child: const Icon(FLucideIcons.menu),
            ),
          FTappable(
            semanticsLabel: 'forui.dev',
            onPress: () => launchUrl(Uri.parse('https://forui.dev')),
            child: _Logo(height: compact ? 20 : 24),
          ),
          const Spacer(),
          if (!compact)
            FButton(
              variant: .ghost,
              onPress: () => launchUrl(Uri.parse('https://forui.dev/docs')),
              child: const Text('Documentation'),
            ),
          FutureBuilder(
            future: _stars,
            builder: (context, snapshot) => switch (snapshot.data) {
              final stars? => FButton(
                variant: .ghost,
                prefix: const Icon(remix.RemixIcons.github_fill, size: 18),
                onPress: _openGitHub,
                child: Text(
                  abbreviate(stars),
                  style: context.theme.typography.body.sm.copyWith(color: context.theme.colors.mutedForeground),
                ),
              ),
              null => FButton(variant: .ghost, onPress: _openGitHub, child: const Text('GitHub')),
            },
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final double height;

  const _Logo({required this.height});

  @override
  Widget build(BuildContext context) => Image.asset(
    context.theme.colors.brightness == Brightness.dark ? 'assets/logos/dark_logo.png' : 'assets/logos/light_logo.png',
    height: height,
  );
}
