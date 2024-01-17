import 'dart:developer';

import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';
import 'package:jalda/src/feature/auth/data/sources/auth_data_source_impl.dart';
import 'package:jalda/src/feature/auth/data/sources/token_manager_source.dart';

/// [AuthRepository] is a class responsible for handling authentication operations.
///
/// This class provides functionality for user login and registration, utilizing
/// [AuthDataSourceImpl] and [TokenManagerDataSourceImpl] to manage authentication
/// tokens and user credentials.
class AuthRepository {
  final AuthDataSourceImpl _auth;
  final TokenManagerDataSourceImpl _tokenManager;

  /// Constructs an instance of [AuthRepository].
  ///
  /// Requires instances of [AuthDataSourceImpl] and [TokenManagerDataSourceImpl]
  /// for handling authentication and token management operations.
  AuthRepository(this._auth, this._tokenManager);

  /// Asynchronously logs in a user with the given [LoginParams].
  ///
  /// This method attempts to login the user by calling the `login` method of [AuthDataSourceImpl].
  /// If successful, it saves the access and refresh tokens using [TokenManagerDataSourceImpl].
  /// In case of an error, it logs the error and rethrows it.
  ///
  /// Throws: Exception if login operation fails.
  Future<void> login(LoginParams params) async {
    try {
      final tokens = await _auth.login(params: params);
      await _saveTokens(tokens.access, tokens.refresh);
    } catch (e) {
      log('Login Error: $e');
      rethrow;
    }
  }

  /// Asynchronously registers a new user with the given [RegistrationParams].
  ///
  /// This method attempts to register the user by calling the `register` method of [AuthDataSourceImpl].
  /// If successful, it saves the access and refresh tokens using [TokenManagerDataSourceImpl].
  /// In case of an error, it logs the error and rethrows it.
  ///
  /// Throws: Exception if registration operation fails.
  Future<void> register(RegistrationParams params) async {
    try {
      final tokens = await _auth.register(params: params);
      await _saveTokens(tokens.access, tokens.refresh);
    } catch (e) {
      log('Registration Error: $e');
      rethrow;
    }
  }

  /// Saves access and refresh tokens using [TokenManagerDataSourceImpl].
  ///
  /// After saving, it retrieves the access token to confirm the operation and logs it.
  /// This method is private and only used internally within [AuthRepository].
  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await _tokenManager.saveAccessToken(accessToken);
    await _tokenManager.saveRefreshToken(refreshToken);
    final retrievedToken = await _tokenManager.getAccessToken();
    log('RECEIVED TOKEN: $retrievedToken');
  }
}