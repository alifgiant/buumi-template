import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuumiBackButton extends StatelessWidget {
  const BuumiBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final icon = switch (Theme.of(context).platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => Icons.arrow_back_ios,
      _ => Icons.arrow_back
    };
    return IconButton(
      onPressed: () => context.pop(),
      icon: Icon(icon),
    );
  }
}
