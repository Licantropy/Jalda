import 'dart:async';
import 'package:jalda/src/core/components/rest_client/src/rest_client_dio.dart';
import 'package:jalda/src/feature/auth/data/dto/token_pair_dto.dart';
import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';
import 'package:jalda/src/feature/auth/data/sources/auth_data_source.dart';

///
final class AuthDataSourceImpl implements AuthDataSource {
  final RestClientDio _dio;

  ///
  AuthDataSourceImpl(this._dio);

  @override
  Future<TokenPairDto> login({
    required LoginParams params,
  }) async {
    final response = await _dio.post(
      'auth/login',
      body: params.toData(),
    );

    if (response != null) {
      return TokenPairDto.fromJson(response);
    }

    throw Exception('Error during login');
  }

  @override
  Future<TokenPairDto> register({
    required RegistrationParams params,
  }) async {
    final response = await _dio.post(
      'auth/registration',
      body: params.toData(),
    );

    if (response != null) {
      return TokenPairDto.fromJson(response);
    }

    throw Exception('Error during registration');
  }
}
