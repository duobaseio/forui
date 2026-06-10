import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class _Crumb {
  final String title;
  final IconData icon;

  const _Crumb(this.title, this.icon);
}

const _trail = [
  _Crumb('Forui', FLucideIcons.house),
  _Crumb('Docs', FLucideIcons.book),
  _Crumb('Widgets', FLucideIcons.box),
  _Crumb('Navigation', FLucideIcons.compass),
  _Crumb('Breadcrumb', FLucideIcons.list),
];

class Breadcrumb extends StatefulWidget {
  const Breadcrumb({super.key});

  @override
  State<Breadcrumb> createState() => _BreadcrumbState();
}

class _BreadcrumbState extends State<Breadcrumb> {
  int _current = _trail.length - 1;

  void _navigate(int index) => setState(() => _current = index);

  @override
  Widget build(BuildContext context) =>
      Center(child: Row(mainAxisAlignment: .center, children: [FBreadcrumb(children: _crumbs())]));

  List<Widget> _crumbs() {
    final last = _current;

    if (last < 3) {
      return [for (var i = 0; i <= last; i++) _crumb(i)];
    }

    return [
      _crumb(0),
      FBreadcrumbItem.collapsed(
        menu: [
          FItemGroup(
            children: [
              for (var i = 1; i <= last - 2; i++)
                FItem(prefix: Icon(_trail[i].icon), title: Text(_trail[i].title), onPress: () => _navigate(i)),
            ],
          ),
        ],
      ),
      _crumb(last - 1),
      _crumb(last),
    ];
  }

  FBreadcrumbItem _crumb(int index) => FBreadcrumbItem(
    current: index == _current,
    onPress: index == _current ? null : () => _navigate(index),
    child: Text(_trail[index].title),
  );
}
