import 'package:flutter/material.dart';

class DynamicLayout extends StatelessWidget {
  final Widget Function(BuildContext context, Size size) landscape;
  final Widget Function(BuildContext context, Size size) potrait;

  const DynamicLayout({
    super.key,
    required this.potrait,
    required this.landscape,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cons) {
        final width = cons.maxWidth;
        final height = cons.maxHeight;
        final size = Size(width, height);
        return width > height ? landscape(ctx, size) : potrait(ctx, size);
      },
    );
  }
}
