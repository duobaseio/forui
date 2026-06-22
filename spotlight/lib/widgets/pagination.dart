import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class Pagination extends StatelessWidget {
  const Pagination({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: FPagination(control: .managed(pages: 10)),
  );
}
