part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

///
class AuthInitial extends AuthState {}

///
class LoginLoading extends AuthState {}

///
class LoginSuccess extends AuthState {}

class AuthFailure extends AuthState {
  ///
  final String? error;

  AuthFailure(this.error);

  ///
}

///
class RegisterLoading extends AuthState {}

///
class RegisterSuccess extends AuthState {}

///
class TokenRefreshLoading extends AuthState {}

///
class TokenRefreshSuccess extends AuthState {}

