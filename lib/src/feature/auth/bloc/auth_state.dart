part of 'auth_bloc.dart';

@immutable
///
sealed class AuthState {}

///
class AuthInitial extends AuthState {}

///
class LoginLoading extends AuthState {}

///
class LoginSuccess extends AuthState {}

///
class LoginFailure extends AuthState {
  final String error;

  LoginFailure(this.error);
}

///
class RegisterLoading extends AuthState {}

///
class RegisterSuccess extends AuthState {}

///
class RegisterFailure extends AuthState {
  final String error;

  RegisterFailure(this.error);
}
