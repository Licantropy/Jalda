part of 'auth_bloc.dart';

///
@immutable
abstract class AuthEvent {}



///
@immutable
class LoginRequested extends AuthEvent {
  ///
  final LoginParams params;

  ///
  LoginRequested(this.params);
}

///
@immutable
class RegisterRequested extends AuthEvent {
  ///
  final RegistrationParams params;

  ///
  RegisterRequested(this.params);
}

///
@immutable
class TokenRefreshRequested extends AuthEvent {
  ///
  final String refreshToken;
///
  TokenRefreshRequested(this.refreshToken);
}
