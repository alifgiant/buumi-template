import 'package:flutter/material.dart';

class NavRail extends StatefulWidget {
  const NavRail({
    super.key,
    required this.menusCreator,
  });

  final Widget Function(bool isExpanded) menusCreator;

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> with SingleTickerProviderStateMixin {
  bool isExpanded = true;

  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    // Create the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    // Create the width animation, from 100 to 300
    _widthAnimation = Tween<double>(
      begin: RailMode.minimized.width,
      end: RailMode.expanded.width,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRails() {
    if (isExpanded) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    isExpanded = !isExpanded;
  }

  @override
  Widget build(BuildContext _) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (ctx, child) {
        return Material(
          child: SizedBox(
            width: _widthAnimation.value,
            child: Column(
              children: [
                Expanded(
                  child: widget.menusCreator(
                    _widthAnimation.value == RailMode.expanded.width,
                  ),
                ),
                ListTile(
                  tileColor: Theme.of(ctx).colorScheme.primaryContainer,
                  trailing: isExpanded
                      ? const Icon(Icons.keyboard_double_arrow_left_rounded)
                      : const Icon(Icons.keyboard_double_arrow_right_rounded),
                  onTap: () => _toggleRails(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum RailMode {
  minimized(68),
  expanded(256);

  final double width;
  const RailMode(this.width);
}
