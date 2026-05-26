import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class BottomNavigationBarPage extends StatefulExample {
  BottomNavigationBarPage({@queryParam super.theme});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends StatefulExampleState<BottomNavigationBarPage> {
  int _index = 1;

  @override
  Widget example(BuildContext _) => FBottomNavigationBar(
    index: _index,
    onChange: (index) => setState(() => _index = index),
    children: const [
      FBottomNavigationBarItem(icon: Icon(FLucideIcons.house), label: Text('Home')),
      FBottomNavigationBarItem(icon: Icon(FLucideIcons.layoutGrid), label: Text('Browse')),
      FBottomNavigationBarItem(icon: Icon(FLucideIcons.radio), label: Text('Radio')),
      FBottomNavigationBarItem(icon: Icon(FLucideIcons.libraryBig), label: Text('Library')),
      FBottomNavigationBarItem(icon: Icon(FLucideIcons.search), label: Text('Search')),
    ],
  );
}
