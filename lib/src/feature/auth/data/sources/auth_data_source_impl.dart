import 'dart:async';
import 'package:dio/dio.dart';
import 'package:jalda/src/feature/auth/data/dto/token_pair_dto.dart';
import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';
import 'package:jalda/src/feature/auth/data/sources/auth_data_source.dart';

///
final class AuthDataSourceImpl implements AuthDataSource {
  final Dio _dio;

  ///
  AuthDataSourceImpl(this._dio);

  @override
  Future<TokenPairDto> login({
    required LoginParams params,
  }) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: params.toData(),
      );
      return TokenPairDto.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      print('LOGIN ERROR: $e');
      rethrow;
    }
  }

  // @override
  // Future<TokenPairDto> login({
  //   required LoginParams params,
  // }) async {
  //   try {
  //     final response = await _dio.post(
  //       'auth/login',
  //       body: params.toData(),
  //     );
  //     return TokenPairDto.fromJson(response!);
  //   } catch (e) {
  //     print('LOGIN ERROR: $e');
  //     rethrow;
  //   }
  // }

  @override
  Future<TokenPairDto> register({
    required RegistrationParams params,
  }) async {
    try {
      final response = await _dio.post(
        'auth/registration',
        data: params.toData(),
      );
      return TokenPairDto.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      print('REGISTRATION ERROR: $e');
      rethrow;
    }
  }
}
