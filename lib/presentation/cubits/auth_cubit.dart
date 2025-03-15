import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:checkin_app/data/services/auth_service.dart';
import 'package:checkin_app/app_exception.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  AuthAuthenticated(this.token);
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}


class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit({required this.authService}) : super(AuthInitial());

  Future<void> authenticate({required String username, required String password}) async {
    emit(AuthLoading());
    try {
      await authService.authenticate(username: username, password: password);
      final token = await authService.secureStorage.read(key: 'token');
      emit(AuthAuthenticated(token!));
    } catch (e) {
      if (e is AppException) {
        emit(AuthFailure(e.message));
      } else {
        emit(AuthFailure("An error occurred when login"));
      }
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authService.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure("An error occurred when logout"));
    }
  }

  Future<void> refreshToken() async {
    try {
      await authService.refreshToken();
      final token = await authService.secureStorage.read(key: 'token');
      emit(AuthAuthenticated(token!));
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> checkAuthentication() async {
    final token = await authService.secureStorage.read(key: 'token');
    if (token != null) {
      try {
        debugPrint(token);
        await authService.refreshToken();
        final refreshedToken = await authService.secureStorage.read(key: 'token');
        emit(AuthAuthenticated(refreshedToken!));
      } catch (e) {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }
}

