sealed class RouteResult {}

class NoAuth extends RouteResult {}

class CustomRedirect extends RouteResult {
  final String path;

  CustomRedirect({required this.path});
}

class RouteAllowed extends RouteResult {
  final String path;

  RouteAllowed({required this.path});
}
