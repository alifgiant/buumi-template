import 'package:feature_scaffold/feature_scaffold.dart';
import 'package:flutter/material.dart';

class AutoMenuScreen extends StatelessWidget {
  const AutoMenuScreen({
    super.key,
    required this.pageCreator,
    required this.menusCreator,
  });

  final Widget Function(Widget? menus, bool isRailShowed) pageCreator;
  final Widget Function(bool isExpanded) menusCreator;

  @override
  Widget build(BuildContext context) {
    return DynamicLayout(
      potrait: (_, __) => pageCreator(menusCreator(true), false),
      landscape: (_, __) => Row(
        children: [
          NavRail(menusCreator: (isExpanded) => menusCreator(isExpanded)),
          Expanded(child: pageCreator(null, true)),
        ],
      ),
    );
  }
}
