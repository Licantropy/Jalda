import 'package:dio/dio.dart';
import 'package:jalda/src/core/localization/localization.dart';
import 'package:jalda/src/feature/auth/data/sources/token_manager.dart';
import 'package:jalda/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:jalda/src/feature/settings/data/settings_repository.dart';

class TokenInterceptor extends Interceptor {
  final TokenManagerImpl _tokenManager;
  final AuthRepository _authRepository;

  TokenInterceptor(this._tokenManager, this._authRepository);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _tokenManager.getRefreshToken();
        if (refreshToken != null) {
          await _authRepository.refresh(refreshToken);
          final newToken = await _tokenManager.getAccessToken();
          if (newToken != null) {
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            return handler.resolve(await Dio().fetch(err.requestOptions));
          }
        }
      } catch (e) {
        /// TODO: LOGOUT
      }
    }

    return super.onError(err, handler);
  }
}

class LanguageInterceptor extends Interceptor {
  final SettingsRepositoryImpl _settingsRepository;

  LanguageInterceptor(this._settingsRepository);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final locale = _settingsRepository.fetchLocaleFromCache() ?? Localization.computeDefaultLocale();
    options.headers['Accept-Language'] = locale.languageCode;
    return super.onRequest(options, handler);
  }
}
