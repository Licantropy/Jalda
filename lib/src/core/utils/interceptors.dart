import 'package:dio/dio.dart';
import 'package:jalda/src/feature/auth/data/sources/token_manager.dart';

class TokenInterceptor extends Interceptor {
  final ITokenManager _tokenManager;

  TokenInterceptor(this._tokenManager);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }
}
