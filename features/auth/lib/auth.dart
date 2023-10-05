library auth;

import 'package:auth/src/data/routes.dart';
import 'package:feature_scaffold/feature_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:router/router.dart';

import 'src/service/auth_service.dart';
import 'src/service/supabase_auth_service.dart';
import 'src/views/screen/forgot_pass_screen.dart';
import 'src/views/screen/login_screen.dart';
import 'src/views/screen/register_screen.dart';

export 'src/data/profile.dart';
export 'src/service/auth_service.dart';
export 'src/service/profile_service.dart';

class AuthFeature extends Feature with FRoute {
  static final provider = Provider<AuthService>(
    (ref) => ref.watch(SupabaseAuthService.provider),
  );

  @override
  List<RouteInfo> routes = [
    RouteInfo(
      path: CommonPath.login,
      routeBase: GoRoute(
        path: CommonPath.login,
        builder: (context, state) => const LoginScreen(),
      ),
      isPublic: true,
    ),
    RouteInfo(
      path: AuthRoute.forgotPass,
      routeBase: GoRoute(
        path: AuthRoute.forgotPass,
        builder: (context, state) => const ForgotPassScreen(),
      ),
      isPublic: true,
    ),
    RouteInfo(
      path: AuthRoute.register,
      routeBase: GoRoute(
        path: AuthRoute.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      isPublic: true,
    ),
  ];
}
