import 'package:go_router/go_router.dart';

class RouteInfo {
  const RouteInfo({
    required this.path,
    required RouteBase Function(String path) routeBuilder,
    this.authRequired = true,
  }) : _routeBuilder = routeBuilder;

  final String path;
  final RouteBase Function(String path) _routeBuilder;
  final bool authRequired;

  RouteBase build() => _routeBuilder(path);
}
