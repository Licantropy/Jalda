import 'dart:developer';

import 'package:jalda/src/feature/auth/data/models/token_pair_model.dart';
import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';
import 'package:jalda/src/feature/auth/data/sources/auth_data_source_impl.dart';
import 'package:jalda/src/feature/auth/data/sources/token_manager.dart';
///
class AuthRepository {
  final AuthDataSourceImpl _authDataSource;
  final TokenManagerImpl _tokenManager;
///
  AuthRepository(this._authDataSource, this._tokenManager);

  ///
  Future<void> login(LoginParams params) async {
    try {
      final tokensDto = await _authDataSource.login(params: params);
      final tokensModel = TokenPairModel.fromDto(tokensDto);
      await _saveTokens(tokensModel);
    } catch (e) {
      log('Login Error: $e');
      rethrow;
    }
  }
///
  Future<void> register(RegistrationParams params) async {
    try {
      final tokensDto = await _authDataSource.register(params: params);
      final tokensModel = TokenPairModel.fromDto(tokensDto);
      await _saveTokens(tokensModel);
    } catch (e) {
      log('Registration Error: $e');
      rethrow;
    }
  }

  ///
  Future<void> refresh(String refresh) async {
    try {
      final tokensDto = await _authDataSource.refresh(refresh);
      final tokensModel = TokenPairModel.fromDto(tokensDto);
      await _saveTokens(tokensModel);
    } catch (e) {
      log('Refresh Error: $e');
      rethrow;
    }
  }

  Future<void> _saveTokens(TokenPairModel tokenModel) async {
    await _tokenManager.saveAccessToken(tokenModel.accessToken);
    await _tokenManager.saveRefreshToken(tokenModel.refreshToken);
    final retrievedToken = await _tokenManager.getAccessToken();
    log('RECEIVED TOKEN: $retrievedToken');
  }
}
