import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router/router.dart';

abstract class Feature {
  const Feature();
}

class ShellFeature extends Feature with FSetup, FRoute {
  final List<Feature> childFeature;
  final Widget Function(Widget) builder;
  final bool authRequired;
  final String path;

  ShellFeature({
    required this.path,
    required this.childFeature,
    required this.builder,
    this.authRequired = true,
  });

  @override
  Future<void> initialize() {
    return Future.wait(
      childFeature
          .whereType<FSetup>()
          .cast<FSetup>()
          .map((e) => e.initialize()),
    );
  }

  @override
  late final List<RouteInfo> routes = [
    RouteInfo(
      path: path,
      routeBuilder: (path) => ShellRoute(
        builder: (_, __, child) => builder(child),
        routes: childFeature.whereType<FRoute>().fold<List<RouteBase>>(
              List<RouteBase>.empty(growable: true),
              (prev, next) =>
                  prev +
                  next.routes
                      .map(
                        (e) => e.build(),
                      )
                      .toList(),
            ),
      ),
      authRequired: authRequired,
    ),
  ];

  @override
  FutureOr<RouteResult?> handleRedirect(
    BuildContext ctx,
    GoRouterState state,
    RouterState routerState,
  ) {
    final redirects = childFeature
        .whereType<FRoute>()
        .map(
          (next) => next.handleRedirect,
        )
        .toList();

    for (int i = 0; i < redirects.length; i++) {
      final result = redirects[i].call(ctx, state, routerState);
      if (result != null) return result;
    }
    return null;
  }
}

mixin FRoute on Feature {
  abstract final List<RouteInfo> routes;

  /// override only if you want to handle redirect
  FutureOr<RouteResult?> handleRedirect(
    BuildContext ctx,
    GoRouterState state,
    RouterState routerState,
  ) async {
    final matchedPath = List<RouteInfo?>.from(routes).firstWhere(
      (info) => info?.path == state.matchedLocation,
      orElse: () => null,
    );
    if (matchedPath?.authRequired == true && !routerState.isLoggedIn) {
      return NoAuth();
    }

    return null;
  }
}

mixin FSetup on Feature {
  Future<void> initialize();
}
