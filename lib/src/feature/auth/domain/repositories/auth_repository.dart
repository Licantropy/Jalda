import 'dart:developer';

import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';
import 'package:jalda/src/feature/auth/data/sources/auth_data_source_impl.dart';
import 'package:jalda/src/feature/auth/data/sources/token_manager_source.dart';

///
class AuthRepository {
  final AuthDataSourceImpl _auth;
  final TokenManagerDataSourceImpl _tokenManager;

  ///
  AuthRepository(this._auth, this._tokenManager);

  ///
  Future<void> login(LoginParams params) async {
    try {
      final tokens = await _auth.login(params: params);
      await _saveTokens(tokens.access, tokens.refresh);
    } catch (e) {
      log('Login Error: $e');
      rethrow;
    }
  }

  ///
  Future<void> register(RegistrationParams params) async {
    try {
      final tokens = await _auth.register(params: params);
      await _saveTokens(tokens.access, tokens.refresh);
    } catch (e) {
      log('Registration Error: $e');
      rethrow;
    }
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await _tokenManager.saveAccessToken(accessToken);
    await _tokenManager.saveRefreshToken(refreshToken);
    final retrievedToken = await _tokenManager.getAccessToken();
    log('RECEIVED TOKEN: $retrievedToken');
  }
}
