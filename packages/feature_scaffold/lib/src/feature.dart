import 'package:go_router/go_router.dart';

abstract class Feature {
  const Feature();
}

mixin FRoute on Feature {
  abstract final List<RouteBase> routes;
}

mixin FSetup on Feature {
  Future<void> initialize();
}
