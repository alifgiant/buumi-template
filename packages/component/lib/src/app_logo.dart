import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final width = screenWidth < 600 ? screenWidth : 600.0;

          return SvgPicture.asset(
            'assets/kula_logo.svg',
            width: width * 0.8,
            package: 'component',
          );
        },
      ),
    );
  }
}
