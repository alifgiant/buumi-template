import 'dart:async';

import 'package:analytic/analytic.dart';
import 'package:data_source/supabase_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import 'auth_service.dart';

class SupabaseAuthService extends AuthService {
  final Supabase supabase;

  const SupabaseAuthService(this.supabase, super.isLoggedIn);

  static final _authStateProvider = StreamProvider(
    (ref) {
      final supabase = ref.watch(SupabaseFeature.provider).client;
      return supabase.auth.onAuthStateChange.map(
        (state) {
          switch (state.event) {
            case AuthChangeEvent.signedIn:
              Analytic.i.logLogin();
              break;
            case AuthChangeEvent.signedOut:
              Analytic.i.logLogout();
              break;
            default:
          }

          return supabase.auth.currentUser;
        },
      );
    },
  );

  static final provider = Provider((ref) {
    final supabase = ref.watch(SupabaseFeature.provider);
    final state = ref.watch(_authStateProvider);

    return state.maybeMap(
      data: (data) => SupabaseAuthService(supabase, data.value?.id ?? ''),
      orElse: () => SupabaseAuthService(supabase, ''),
    );
  });

  @override
  Future<AuthResult> login(String email, String password) async {
    try {
      final response = await supabase.client.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user != null) {
        return AuthResult.success;
      } else {
        return AuthResult.invalid;
      }
    } catch (e) {
      if (e is AuthException) {
        return switch (e.statusCode) {
          "400" => AuthResult.invalid,
          _ => AuthResult.error,
        };
      }
    }
    return AuthResult.error;
  }

  @override
  Future<void> logout() {
    return supabase.client.auth.signOut();
  }
}
