import 'dart:async';
import 'package:jalda/src/feature/auth/data/dto/token_pair_dto.dart';
import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';

/// [AuthDataSource] is an abstract interface defining the contract for authentication data sources.
///
/// This interface outlines the methods necessary for implementing user login and registration functionalities.
abstract interface class AuthDataSource {
  /// Asynchronously logs in a user.
  ///
  /// This method requires [LoginParams] as a parameter, which should contain the user's login credentials.
  /// It returns a [FutureOr] of [TokenPairDto], which includes the access and refresh tokens.
  ///
  /// Implementations of this method are expected to handle the authentication logic and return
  /// the relevant token information upon successful login.
  ///
  /// Parameters:
  ///   [params] ([LoginParams]): The login parameters containing user credentials.
  ///
  /// Returns:
  ///   [FutureOr<TokenPairDto>]: The token pair data transfer object containing access and refresh tokens.
  FutureOr<TokenPairDto> login({required LoginParams params});

  /// Asynchronously registers a new user.
  ///
  /// This method requires [RegistrationParams] as a parameter, which should contain the user's registration information.
  /// It returns a [FutureOr] of [TokenPairDto], which includes the access and refresh tokens.
  ///
  /// Implementations of this method are expected to handle the registration logic and return
  /// the relevant token information upon successful registration.
  ///
  /// Parameters:
  ///   [params] ([RegistrationParams]): The registration parameters containing user information.
  ///
  /// Returns:
  ///   [FutureOr<TokenPairDto>]: The token pair data transfer object containing access and refresh tokens.
  FutureOr<TokenPairDto> register({required RegistrationParams params});

  FutureOr<TokenPairDto> refresh(String refreshToken);
}
