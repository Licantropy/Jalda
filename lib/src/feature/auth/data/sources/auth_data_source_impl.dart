import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:jalda/src/feature/auth/data/dto/token_pair_dto.dart';
import 'package:jalda/src/feature/auth/data/params/login_params.dart';
import 'package:jalda/src/feature/auth/data/params/registration_params.dart';
import 'package:jalda/src/feature/auth/data/sources/auth_data_source.dart';

/// [AuthDataSourceImpl] implements the [AuthDataSource] interface.
///
/// It provides the functionalities to communicate with a backend service for
/// authentication processes like login and registration using the Dio HTTP client.
final class AuthDataSourceImpl implements AuthDataSource {
  final Dio _dio;

  /// Constructs an [AuthDataSourceImpl] with a Dio client.
  ///
  /// Requires an instance of Dio ([_dio]) for making HTTP requests.
  AuthDataSourceImpl(this._dio);

  /// Asynchronously logs in a user with the provided [LoginParams].
  ///
  /// Performs a POST request to 'auth/login' with the data from [LoginParams].
  /// Returns a [TokenPairDto] containing the access and refresh tokens upon success.
  /// Logs and rethrows any exceptions that occur during the process.
  ///
  /// Throws: Exception if the login request fails.
  @override
  Future<TokenPairDto> login({
    required LoginParams params,
  }) async {
    try {
      final response = await _dio.post('auth/login', data: params.toData());
      return TokenPairDto.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      log('LOGIN ERROR: $e');
      rethrow;
    }
  }

  /// Asynchronously registers a new user with the provided [RegistrationParams].
  ///
  /// Performs a POST request to 'auth/registration' with the data from [RegistrationParams].
  /// Returns a [TokenPairDto] containing the access and refresh tokens upon success.
  /// Logs and rethrows any exceptions that occur during the process.
  ///
  /// Throws: Exception if the registration request fails.
  @override
  Future<TokenPairDto> register({
    required RegistrationParams params,
  }) async {
    try {
      final response = await _dio.post('auth/registration', data: params.toData());
      return TokenPairDto.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      log('REGISTRATION ERROR: $e');
      rethrow;
    }
  }

  @override
  FutureOr<TokenPairDto> refresh(String refreshToken) async {
    try {
      final response = await _dio.post('auth/refresh', data: {'refresh_token': refreshToken});
      return TokenPairDto.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      log('REGISTRATION ERROR: $e');
      rethrow;
    }
  }
}
