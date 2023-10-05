import 'package:feature_scaffold/feature_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:router/router.dart';

void main() {
  final feature = TestFeature();

  test('route count', () {
    expect(feature.routes.length, 1);
  });

  test('initialize correct', () async {
    // given
    assert(!feature.isInitialized);

    // when
    await feature.initialize();

    // then
    expect(feature.isInitialized, true);
  });
}

class TestFeature extends Feature with FSetup, FRoute {
  bool isInitialized = false;

  @override
  final List<RouteInfo> routes = [
    RouteInfo(
      path: '/test',
      routeBase: GoRoute(
        path: '/test',
        builder: (_, __) => Container(),
      ),
    )
  ];

  @override
  Future<void> initialize() {
    isInitialized = true;
    return Future.value();
  }
}
