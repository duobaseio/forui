import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

typedef _Player = ({String name, String points});

const _today = <_Player>[
  (name: 'Ava Chen', points: '2,480'),
  (name: 'Liam Wong', points: '2,310'),
  (name: 'Noah Park', points: '1,905'),
  (name: 'Priya Rao', points: '1,640'),
];

const _week = <_Player>[
  (name: 'Noah Park', points: '14,220'),
  (name: 'Ava Chen', points: '12,980'),
  (name: 'Mia Torres', points: '11,540'),
  (name: 'Liam Wong', points: '10,870'),
];

const _allTime = <_Player>[
  (name: 'Ava Chen', points: '98,400'),
  (name: 'Mia Torres', points: '87,110'),
  (name: 'Noah Park', points: '76,050'),
  (name: 'Priya Rao', points: '68,320'),
];

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: 360,
      child: FTabs(
        children: [
          .entry(label: const Text('Today'), child: _Leaderboard(_today)),
          .entry(label: const Text('Week'), child: _Leaderboard(_week)),
          .entry(label: const Text('All time'), child: _Leaderboard(_allTime)),
        ],
      ),
    ),
  );
}

class _Leaderboard extends StatelessWidget {
  final List<_Player> players;

  const _Leaderboard(this.players);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FItemGroup(
      children: [
        for (final (index, player) in players.indexed)
          FItem(
            prefix: SizedBox(
              width: 20,
              child: Text(
                '${index + 1}',
                textAlign: .center,
                style: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground),
              ),
            ),
            title: Text(player.name),
            suffix: Text(player.points, style: theme.typography.body.sm.copyWith(fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }
}
