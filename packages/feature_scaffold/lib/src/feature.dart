import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router/router.dart';

abstract class Feature {
  const Feature();
}

mixin FRoute on Feature {
  abstract final List<RouteInfo> routes;

  /// override only if you want to handle redirect
  FutureOr<RouteInfo?> handleRedirect(
    BuildContext ctx,
    GoRouterState state,
  ) async {
    return null;
  }
}

mixin FSetup on Feature {
  Future<void> initialize();
}
