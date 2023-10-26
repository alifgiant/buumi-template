import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:router/src/common_path.dart';
import 'package:router/src/page/unknown_page.dart';
import 'package:router/src/route_result.dart';

import 'route_info.dart';

typedef RedirectHandle = FutureOr<RouteResult?> Function(
  BuildContext ctx,
  GoRouterState state,
  RouterState authState,
);

class RouterState {
  final bool isLoggedIn;

  const RouterState({this.isLoggedIn = false});

  static const loggedIn = RouterState(isLoggedIn: true);
  static const loggedOut = RouterState(isLoggedIn: false);

  static final provider = StateProvider<RouterState>(
    (ref) => const RouterState(),
  );
}

class RouteData {
  final List<RouteInfo> routes;
  final List<RedirectHandle> redirectHandle;

  const RouteData({
    required this.routes,
    required this.redirectHandle,
  });

  static final provider = Provider(
    (ref) => const RouteData(routes: [], redirectHandle: []),
  );
}

class RouteService {
  final RouterState routerAuthState;
  final RouteData routeData;

  RouteService({
    required this.routerAuthState,
    required this.routeData,
  });

  Future<void> showLoading({String status = 'loading...'}) {
    return EasyLoading.show(status: status);
  }

  Future<void> dismiss() {
    return EasyLoading.dismiss();
  }

  Widget Function(BuildContext, Widget?) init({
    Widget Function(BuildContext, Widget?)? builder,
  }) {
    return EasyLoading.init(builder: builder);
  }

  // GoRouter configuration
  late final router = GoRouter(
    // TODO: read aut state changes
    // refreshListenable: authService,
    initialLocation: CommonPath.splash,
    routes: [
      ...routeData.routes.map((e) => e.build()).toList(),
      UnknownPage.routeInfo.build(),
    ],
    redirect: handleRedirect,
    errorBuilder: (_, __) => const UnknownPage(),
  );

  FutureOr<String?> handleRedirect(
    BuildContext ctx,
    GoRouterState state,
  ) async {
    final redirectedRoute = await _getRedirectRoute(ctx, state);
    return redirectedRoute ?? state.fullPath;
  }

  FutureOr<String?> _getRedirectRoute(
    BuildContext ctx,
    GoRouterState state,
  ) async {
    for (int i = 0; i < routeData.redirectHandle.length; i++) {
      final handle = routeData.redirectHandle[i];
      final result = await handle(ctx, state, routerAuthState);
      final path = switch (result) {
        NoAuth() => CommonPath.login,
        RouteAllowed(:final path) => path,
        CustomRedirect(:final path) => path,
        _ => null
      };
      if (path != null) return path;
    }
    return null;
  }

  static final provider = Provider(
    (ref) {
      final authState = ref.watch(RouterState.provider);
      final data = ref.watch(RouteData.provider);
      return RouteService(
        routerAuthState: authState,
        routeData: data,
      );
    },
  );
}
