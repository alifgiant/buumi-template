library router;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RouteInfo {
  const RouteInfo({
    required this.path,
    required this.routeBase,
    this.isPublic = false,
  });

  final String path;
  final bool isPublic;
  final RouteBase routeBase;

  static final empty = RouteInfo(path: '', routeBase: GoRoute(path: ''));
}

/// base route
abstract class CommonPath {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
}

typedef RedirectHandle = FutureOr<RouteInfo?> Function(
  BuildContext ctx,
  GoRouterState state,
);

class RouteService {
  final bool isLoggedIn;
  final List<RouteInfo> routes;
  final List<RedirectHandle> redirectHandle;

  RouteService({
    required this.isLoggedIn,
    required this.routes,
    required this.redirectHandle,
  });

  // GoRouter configuration
  late final router = GoRouter(
    // refreshListenable: authService,
    initialLocation: CommonPath.splash,
    routes: routes.map((e) => e.routeBase).toList(),
    redirect: handleRedirect,
  );

  FutureOr<String?> handleRedirect(
    BuildContext ctx,
    GoRouterState state,
  ) async {
    final matchedRoute = routes.firstWhere(
      (route) => route.path == state.matchedLocation,
      orElse: () => RouteInfo.empty,
    );
    final redirect = switch (state.matchedLocation) {
      CommonPath.splash || CommonPath.login when isLoggedIn => CommonPath.home,
      CommonPath.splash => CommonPath.login,
      _ when isLoggedIn || matchedRoute.isPublic =>
        (await _getRedirectRoute(ctx, state))?.path,
      _ => CommonPath.login
    };
    return redirect ?? state.fullPath;
  }

  FutureOr<RouteInfo?> _getRedirectRoute(
    BuildContext ctx,
    GoRouterState state,
  ) async {
    for (var i = 0; i < redirectHandle.length; i++) {
      final handle = redirectHandle[i];
      final selectedRoute = await handle(ctx, state);
      if (selectedRoute != null) return selectedRoute;
    }
    return null;
  }

  static final provider = Provider(
    (ref) => RouteService(
      isLoggedIn: false,
      routes: [],
      redirectHandle: [],
    ),
  );
}
