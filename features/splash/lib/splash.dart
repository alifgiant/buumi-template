library splash;

import 'package:component/component.dart';
import 'package:feature_scaffold/feature_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router/router.dart';

class SplashFeature extends Feature with FRoute {
  @override
  List<RouteInfo> routes = [
    RouteInfo(
      path: CommonPath.splash,
      routeBase: GoRoute(
        path: CommonPath.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      isPublic: true,
    ),
  ];
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppLogo(),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
